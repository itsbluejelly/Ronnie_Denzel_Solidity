// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract Variables{
    uint8 public number = 20;
    bool private _paused = true;
    uint internal _time = block.timestamp;

    function setPrivate(bool _value) public {
        _paused = _value;
    }

    function myFunc() external view returns(bool, address){
        address myAddress = msg.sender;

        return (_paused, myAddress); 
    }
}