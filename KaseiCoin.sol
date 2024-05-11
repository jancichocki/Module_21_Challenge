pragma solidity ^0.5.5;

// Import the necessary OpenZeppelin contracts
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";

// Declare the KaseiCoin contract
contract KaseiCoin is ERC20, ERC20Detailed, ERC20Mintable {
    // Constructor for the KaseiCoin token
    constructor(
        string memory name,    // Name of the token, e.g., "KaseiCoin"
        string memory symbol,  // Symbol of the token, e.g., "KAI"
        uint initial_supply    // Initial supply of tokens, if any
    )
        ERC20Detailed(name, symbol, 18)  // Set the token details, including 18 decimal places
        public
    {
        // Constructor can stay empty as minting is controlled elsewhere
    }
}