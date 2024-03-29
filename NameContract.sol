// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract NameContract{
    string public name;

    // A FUNCTION TO UPDATE THE NAME
    function updateName(string memory _newName) public{
        name = _newName;
    }
}