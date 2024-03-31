// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

library NumbersArray{
    // A FUNCTION MEANT TO IMPLEMENT THE .INCLUDES FUNCTIONALITY
    ///@dev [1,2,3].includes(4) = false
    function includes(uint[] memory _numbers, uint _element)internal pure returns(bool){
        for(uint i = 0; i < _numbers.length; i++){
            if(_numbers[i] == _element){
                return true;
            }
        }

        return false;
    }
}