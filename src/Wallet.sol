// SPDX-License-Identifier: MIT

pragma solidity 0.8.26;

// TODO
// receive blockchain native token (Eth,Matic,BNB,...)
// withdraw blockchain native token (Eth,Matic,BNB,...)
// receive ERC20
// withdraw ERC20
// receive ERC721
// withdraw ERC721

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Wallet {
    //  TODO get hash of unique string slot
    bytes32 constant SLOT = 0;

    address owner;

    event OnReceiveEth(address indexed sender, uint256 amount);
    event OnWithdrawEth(address indexed recepiant, uint256 amount);
    event OnChangedOwner(address indexed oldOwner, address indexed newOwner, address indexed caller);

    error FailedWithdraw();
    error FailedWithdrawCall(bytes);
    error ZeroAddress();
    error ZeroAmount();
    error NotOwner();

    modifier OnlyOwner() {
        require(msg.sender == owner, NotOwner());
        _;
    }

    modifier NotZeroAmount(uint256 val) {
        require(val > 0, ZeroAmount());
        _;
    }

    modifier NotZeroAddress(address val) {
        require(val != address(0), ZeroAddress());
        _;
    }

    modifier nonReentrant() {
        assembly {
            if tload(SLOT) { revert(0, 0) }
            tstore(SLOT, 1)
        }
        _;
        assembly {
            tstore(SLOT, 0)
        }
    }

    constructor() {
        owner = msg.sender;
    }

    /*
    Which function is called, fallback() or receive()?

           send Ether
               |
         msg.data is empty?
              / \
            yes  no
            /     \
    receive() exists?  fallback()
         /   \
        yes   no
        /      \
    receive()   fallback()
    */
    receive() external payable NotZeroAmount(msg.value) {
        // if (msg.value == 0) {
        //     revert ZeroAmount();
        // }
        // require(msg.value > 0, "ZeroAmount");
        emit OnReceiveEth(msg.sender, msg.value);
    }

    fallback() external payable NotZeroAmount(msg.value) {
        emit OnReceiveEth(msg.sender, msg.value);
    }

    /// (2300 gas, throws error)
    function withdrawTransfer() external OnlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, ZeroAmount());
        payable(msg.sender).transfer(balance);
        emit OnWithdrawEth(msg.sender, balance);
    }

    ///(2300 gas, returns bool)
    function withdrawSend() external OnlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, ZeroAmount());
        bool res = payable(msg.sender).send(balance);
        require(res , FailedWithdraw());
        emit OnWithdrawEth(msg.sender, balance);
    }

    /// (forward all gas or set gas, returns bool and data)
    function withdrawCall() external OnlyOwner {
        uint256 balance = address(this).balance;
        if (balance <= 0) revert ZeroAmount();
        (bool res, bytes memory data) = payable(msg.sender).call{ value: balance }(" ");
        require(res , FailedWithdrawCall(data));
        emit OnWithdrawEth(msg.sender, balance);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function changeOwner(address newOwner) external NotZeroAddress(newOwner) OnlyOwner {
        address oldOwner = owner;
        owner = newOwner;
        emit OnChangedOwner(oldOwner, newOwner, msg.sender);
    }
}
