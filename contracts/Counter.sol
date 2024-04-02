// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

// IMPORTING NECESSARY FILES
    // IMPORTING CONTRACTS
import "@openzeppelin/contracts/access/Ownable.sol";
    // IMPORTING INTERFACES
import "interfaces/ICounter.sol";

contract CounterContract is Ownable(msg.sender), ICounter{
    // DECLARING VARIABLES
    uint public count = 0;
    bool public counterActivated = true;
    uint public transactionCost = 0.01 ether;

    // A CONSTRUCTOR THAT DEPOSITS MONEY TO THE CONTRACT
    constructor() payable {
        require(msg.value >= 0.02 ether, "Minimum value to deposit to the contract is 0.02 ether");
    }

    // A MODIFIER TO CHECK IF COUNT CAN BE UPDATED
    modifier onlyCounterActivated{
        require(counterActivated == true, "Counter can be updated only when activated");
        _;
    }

    // A FUNCTION TO SET THE TRANSACTION COST
    function setTransactionCost(uint _value) external onlyOwner{
        transactionCost = _value;
    }

    // A FUNCTION TO UPDATE THE COUNTER ACTIVATED
    function setCounterActivated(bool _counterActivated) external onlyOwner{
        counterActivated = _counterActivated;
    }

    // A FUNCTION TO INCREASE OR DECREASE COUNT
    function increaseCount() external payable onlyCounterActivated{
        require(msg.value == transactionCost);
        count++;
    }

    function decreaseCount() external payable onlyCounterActivated{
        require(msg.value == transactionCost);
        count--;
    }

    // FUNCTION TO WITHDRAW FUNDS FROM THE CONTRACT
    function withdrawFunds() external onlyOwner{
        address payable currentOwner = payable (owner());
        uint contractBalance = address(this).balance;
        currentOwner.transfer(contractBalance);
    }
}