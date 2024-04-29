# KaseiCoin & KaseiCoinCrowdsale

## Overview

This repository contains the Solidity smart contracts for KaseiCoin, a cryptocurrency designed for use in a hypothetical colonization of Mars, and its associated crowdsale for initial distribution. KaseiCoin utilizes ERC-20 standards with extended functionality for minting capabilities, supporting a crowdsale mechanism directly through Ethereum blockchain technology.

## Contract Descriptions

### KaseiCoin

KaseiCoin is a fully compliant ERC-20 token with additional minting functionality, allowing the crowdsale contract to mint new tokens when purchases are made. It is based on the OpenZeppelin library, which is known for its secure and community-vetted smart contracts.

#### Features
- **ERC-20 Compliance**: Ensures compatibility with the broad Ethereum ecosystem, including wallets and other contracts.
- **Mintable**: New tokens can be created by designated parties, in this case, the crowdsale contract, during the initial sale period.

#### Contract Code
```solidity
pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

contract KaseiCoin is ERC20, ERC20Detailed, ERC20Mintable {
    constructor(
        string memory name,
        string memory symbol,
        uint initial_supply
    )
    ERC20Detailed(name, symbol, 18)
    public {
        if (initial_supply > 0) {
            _mint(msg.sender, initial_supply);
        }
    }
}
