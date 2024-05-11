pragma solidity ^0.5.5;

// Import the KaseiCoin token and OpenZeppelin Crowdsale contracts
import "./KaseiCoin.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";

// Declare the KaseiCoinCrowdsale contract, inheriting from OpenZeppelin's Crowdsale and MintedCrowdsale
contract KaseiCoinCrowdsale is Crowdsale, MintedCrowdsale {
    // Constructor for initializing the crowdsale
    constructor(
        uint256 rate,              // Rate (number of token units per wei)
        address payable wallet,    // Wallet address to send raised Ether
        KaseiCoin token            // Token to be sold
    )
        Crowdsale(rate, wallet, token)
        public
    {
        // Constructor body can remain empty
    }
}

// Deployer contract for setting up the KaseiCoin token and its crowdsale
contract KaseiCoinCrowdsaleDeployer {
    // Public addresses for accessing the deployed KaseiCoin and KaseiCoinCrowdsale contracts
    address public kasei_token_address;
    address public kasei_crowdsale_address;

    // Constructor for deploying and setting up the KaseiCoin and its crowdsale
    constructor(
        string memory name,            // Name of the KaseiCoin token, e.g., "KaseiCoin"
        string memory symbol,          // Symbol of the KaseiCoin token, e.g., "KAI"
        address payable wallet         // Wallet address to send raised funds
    )
        public
    {
        // Deploy the KaseiCoin token with zero initial supply
        KaseiCoin token = new KaseiCoin(name, symbol, 0);
        kasei_token_address = address(token);

        // Deploy the KaseiCoinCrowdsale contract
        KaseiCoinCrowdsale kasei_crowdsale = new KaseiCoinCrowdsale(1, wallet, token);
        kasei_crowdsale_address = address(kasei_crowdsale);

        // Grant the KaseiCoinCrowdsale contract the minter role
        token.addMinter(kasei_crowdsale_address);
        // The deployer renounces its minter role to ensure that no new tokens can be minted by this deployer
        token.renounceMinter();
    }
}