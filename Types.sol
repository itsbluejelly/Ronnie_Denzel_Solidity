// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract TypesContract{
    bool internal myBoolean = true;

    uint256 public myUint = 6000000000;
    uint32 public myUint32 = 6000000;
    uint16 public myUint16 = 6000;
    uint8 public myUint8 = 6;

    int256 private myInt = 3000000000;
    int32 private myInt32 = -3000000;
    int16 private myInt16 = 3000;
    int8 private myInt8 = -3;

    address public myAddress = msg.sender;
    address public myContractAddress = address(this);
}