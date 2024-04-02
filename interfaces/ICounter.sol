// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

interface ICounter{
    function setCounterActivated(bool _counterActivated) external;
    function increaseCount() external;
    function decreaseCount() external;
}