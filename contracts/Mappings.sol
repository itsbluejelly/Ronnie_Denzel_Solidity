// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract MappingsContract{
    // DECLARING VARIABLES
    mapping (address => uint[]) public addressesToNfts;
    uint public lastMiningTime;
    uint cooldownTime;
    uint countIndex = 0;

    // DECLARING A CONSTRUCTOR TO SET COOLDOWN TIME
    constructor(){
        cooldownTime = 5 seconds;
    }

    // A FUNCTION TO MINT AN NFT
    function mintNft() external{
        require(block.timestamp > lastMiningTime + cooldownTime, "You need to mine after the cooldown");
        
        addressesToNfts[msg.sender].push(
            uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, countIndex)))
        );
        
        countIndex++;
        lastMiningTime = block.timestamp;
    }
}