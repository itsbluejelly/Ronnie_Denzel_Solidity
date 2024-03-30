// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract Variables{
    uint8 number = 20;
    bool paused = true;
    uint time = block.timestamp;

    function myFunc() external view returns(uint8, bool, address){
        uint8 myLocalNumber = 20;
        bool localPaused = false;
        address myAddress = msg.sender;

        return (myLocalNumber, localPaused, myAddress); 
    }
}