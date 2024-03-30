// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

// IMPORTS
import "contracts/Variables.sol";

contract MainContract is Variables{
    uint8 public awesomeVar = 100;
    uint public currentTime = _time;
}