# KaseiCoin & KaseiCoinCrowdsale

## Overview

This repository contains the Solidity smart contracts for KaseiCoin, a cryptocurrency designed for use in a hypothetical colonization of Mars, and its associated crowdsale for initial distribution. KaseiCoin utilizes ERC-20 standards with extended functionality for minting capabilities, supporting a crowdsale mechanism directly through Ethereum blockchain technology.

## Contract Descriptions

### KaseiCoin

KaseiCoin is a fully compliant ERC-20 token with additional minting functionality, allowing the crowdsale contract to mint new tokens when purchases are made. It is based on the OpenZeppelin library, which is known for its secure and community-vetted smart contracts.

#### Features
- **ERC-20 Compliance**: Ensures compatibility with the broad Ethereum ecosystem, including wallets and other contracts.
- **Mintable**: New tokens can be created by designated parties, in this case, the crowdsale contract, during the initial sale period.

#### KaseiCoin.sol
```solidity
pragma solidity ^0.5.0;

// Importing necessary components from the OpenZeppelin Solidity library.
// ERC20 provides the standard functionality of an ERC-20 token, including balance tracking and transfers.
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
// ERC20Detailed allows for additional details such as name, symbol, and decimals to be associated with the token.
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
// ERC20Mintable provides minting functionality, which is essential for creating new tokens during the crowdsale.
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

// KaseiCoin is defined as a comprehensive ERC-20 token with minting capabilities.
contract KaseiCoin is ERC20, ERC20Detailed, ERC20Mintable {
    // Constructor to initialize the KaseiCoin with specific attributes.
    constructor(
        string memory name,          // Name of the token, e.g., "KaseiCoin"
        string memory symbol,        // Symbol of the token, e.g., "KAI"
        uint initial_supply          // Initial supply of tokens, if any, to be minted upon deployment
    ) 
    ERC20Detailed(name, symbol, 18) // Setting '18' as the standard number of decimal places
    public {
        // Conditionally mint the initial supply to the deployer's address.
        if (initial_supply > 0) {
            _mint(msg.sender, initial_supply);
        }
    }
}
```
#### KaseiCoinCrowsale.sol
```solidity
pragma solidity ^0.5.0;

// Importing the token and crowdsale contracts.
import "./KaseiCoin.sol";
import "./KaseiCoinCrowdsale.sol";

// Deployer contract for setting up the KaseiCoin token and its crowdsale.
contract KaseiCoinCrowdsaleDeployer {
    // Publicly accessible address of the KaseiCoin token contract.
    address public kasei_token_address;
    // Publicly accessible address of the KaseiCoin crowdsale contract.
    address public kasei_crowdsale_address;

    // Constructor to deploy and setup the KaseiCoin token and crowdsale.
    constructor(
        string memory name,            // Name for the KaseiCoin token, e.g., "KaseiCoin"
        string memory symbol,          // Symbol for the KaseiCoin token, e.g., "KAI"
        address payable wallet         // Address where collected funds will be sent
    ) public {
        // Deploying the KaseiCoin token contract.
        KaseiCoin token = new KaseiCoin(name, symbol, 0);
        // Storing the address of the deployed KaseiCoin token contract.
        kasei_token_address = address(token);

        // Deploying the KaseiCoin crowdsale contract.
        KaseiCoinCrowdsale crowdsale = new KaseiCoinCrowdsale(1, wallet, token);
        // Storing the address of the deployed KaseiCoin crowdsale contract.
        kasei_crowdsale_address = address(crowdsale);

        // Setting the KaseiCoinCrowdsale contract as a minter of the KaseiCoin tokens.
        token.addMinter(kasei_crowdsale_address);
        // The deployer renounces its minter role, ensuring no new tokens can be minted by this deployer.
        token.renounceMinter();
    }
}
```
