# EVM Universal Wallet Smart Contract

## Overview

This project aims to develop an advanced wallet smart contract on the EVM-based blockchain for **educational purposes**. The smart contract will provide enhanced features such as multi-signature support, time-lock functionality, recovery mechanism, and more.

> :warning: Educational Purpose
>
> This project is developed for educational purposes. The codes in this project have not been thoroughly reviewed or audited for security. It is your responsibility to use this project responsibly and understand that any usage or damage caused is at your own risk.


## Features

### Smart Contract Checklist and Roadmap
- [ ] Basic Wallet Functionality
- [ ] ERC-20 Token Support
- [ ] Event Logging
- [ ] Role-Based Access Control
- [ ] Time-Lock Functionality
- [ ] Multi-Signature Support
- [ ] Gas Optimization
- [ ] Whitelisting/Blacklisting
- [ ] Recovery Mechanism
- [ ] Upgradeability
- [ ] Security Measures
- [ ] Batch Transactions
- [ ] Emergency Stop Mechanism
- [ ] Gasless Transactions
- [ ] Decentralized Finance (DeFi) Integrations

### Front-End Checklist and Roadmap
- [ ] User Interface Design
- [ ] Integration with Smart Contract
- [ ] Transaction Monitoring
- [ ] User Authentication
- [ ] Testing and Optimization

## Tools and Stack Used
- **Smart Contract Development**: Solidity
- **Front-End Development**: React.js
- **Web3 Libraries**: Web3.js
- **Testing Framework**: Truffle Suite
- **Deployment**: Remix IDE, Truffle Framework
- **Version Control**: Git
- **Project Management**: GitHub Projects, Trello
- **Collaboration**: Slack, Discord
- **Documentation**: Markdown, Solidity NatSpec

## How to Use and Contribute

For detailed technical documentation on how to set up the project for execution and contribute to its development, please refer to [this](/README-Use-Contribute.md) doc.


## Tips
- Minimum EVM version requirement:
    - `Cancun` hardfork for `Transient Storage Opcodes`
- Minimum solidity version: 0.8.26
    - 0.8.26: Using custom errors with `require`
    - 0.8.24: Transient Storage Opcodes ([EIP-1153](https://eips.ethereum.org/EIPS/eip-1153)) [Blog post](https://soliditylang.org/blog/2024/01/26/transient-storage/)
- Build with `--via-ir` arg like: `forge build  --via-ir`
    - reason: 
        - `Using custom errors with require is only supported by the via IR pipeline, i.e. compilation via Yul`
    - refrences: 
        - [soliditylang-error-handling-revert-custom errors](https://docs.soliditylang.org/en/latest/control-structures.html#error-handling-assert-require-revert-and-exceptions)
        - [All About the Via-Ir Pipeline](https://docs.tenderly.co/debugger/via-ir-pipeline)
        - [Video `via IR` speedrun by Nikola Matić](https://youtu.be/3ljewa1__UM?list=PLX8x7Zj6VeznJuVkZtRyKwseJdrr4mNsE)