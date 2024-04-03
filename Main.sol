// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

// IMPORTING NECESSARY FILES
    // IMPORTING CONTRACTS
import "contracts/NFT.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
    // IMPORTING INTERFACES
import "interfaces/IMain.sol";
    // IMPORTING STRUCTS
import "structs.sol";

contract MainContract is IMain, Ownable(msg.sender){
    // DECLARING VARIABLES
    NFTContract[] public NFTContractAddresses;
    NFT[] public minedNFTS;

    uint lastMiningTime;
    uint public NFTPrice = 0.01 ether;
    uint cooldownTime = 30 seconds;
    uint countIndex = 0;

    // A FUNCTION TO UPDATE THE COOLDOWN TIME
    function setCooldown(uint _period) external onlyOwner{
        cooldownTime = _period;
    }

    // A FUNCTION TO UPDATE THE PRICE
    function updatePrice(uint _newPrice) external onlyOwner{
        uint oldPrice = NFTPrice;
        NFTPrice = _newPrice;

        emit UpdatedPrice(oldPrice, _newPrice);
    }

    // A FUNCTION TO MINT NFTS
    function mintNFT(string memory _name) external onlyOwner{
        bytes16 nftDna = bytes16(keccak256(abi.encodePacked(msg.sender, block.timestamp, countIndex)));
        NFT memory newNFT = NFT(_name, nftDna);
        minedNFTS.push(newNFT);
        countIndex++;
    }

    // A FUNCTION TO BUY NFT
    function purchaseNFT(string memory _name, bytes16 _dna) external payable{
        require(block.timestamp >= lastMiningTime + cooldownTime, "Market packed, purchase after cooldown");
        require(msg.value == NFTPrice, "Transaction failed, ensure your value is equal to current price");

        // FILTERING TO GET THE REQUIRED NFT
        NFT memory requiredNFT;
        for(uint i = 0; i < minedNFTS.length; i++){
            NFT storage currentNFT = minedNFTS[i];

            // IF NAME WAS PASSED, CHANGE THE NAME
            if(keccak256(abi.encodePacked(_name)) != keccak256("")){
                currentNFT.name = _name;
            }

            if(currentNFT.dna == _dna){
                requiredNFT = currentNFT;
            }
        }

        // ONCE NFT IS OBTAINED AND TRANSACTION DONE, GENERATE AND SELL THE CONTRACT AND UPDATE LAST MINING TIME
        NFTContract newNFTContract = new NFTContract(msg.sender, requiredNFT, NFTPrice);
        NFTContractAddresses.push(newNFTContract);
        lastMiningTime = block.timestamp;

        emit SoldNFT(owner(), msg.sender);
    }

    // A FUNCTION TO WITHDRAW FUNDS
    function withdrawFunds() external onlyOwner{
        address payable currentOwner = payable(owner());
        uint currentBalance = address(this).balance;
        (bool isSent, ) = currentOwner.call{value: currentBalance}("");
        
        require(isSent, "Funds not withdrawn successfully");
    }
}