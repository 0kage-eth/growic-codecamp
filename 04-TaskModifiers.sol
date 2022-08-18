// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

/**
 * @title Contract that uses different kinds of modifiers
 * @author 0Kage
 * @dev Explains how modifiers can be used without/with inputs and to sandwich logic
 */
contract Modifiers{

    bool public s_paused;
    uint256 public s_counter;


    constructor(){
        s_paused = false;
        s_counter = 0;
    }

    /**
     * @dev sets pause to true
     */
    function pause() public {
        s_paused = true;
    }

    /** 
     * @dev flips status from true to false and vice versa
     */
    function flip() public {
        s_paused = !s_paused;
    }

    /**
     * @dev run this logic only when contract is not paused. using modifier checkPause for this
     * @dev using checkCounter modifier to check if counter is more than 100
     * @param _increment increment for counter
     */
    function increment(uint256 _increment) public checkPause checkCounter(_increment){
        s_counter += _increment;
    }

    /**
     * @dev using checkPause modifier to execute this logic only contract is paused
     * @param _decrement decrement for counter
     */
    function decrement(uint256 _decrement) public checkPause sandwichCounter(2,5){
        s_counter -= _decrement;
    }

    /**
     * @dev modifier that checks if contract is paused
     */
    modifier checkPause() {
        require(!s_paused, "contract is paused!");
        _;
    }

    /**
     * @dev modifier that checks if increment is not greater than 100
     */
    modifier checkCounter(uint256 _increment) {
        require(_increment <= 100, "Increment out of range");
        _;
    }


    /**
     * @dev a modifier that sandwiches the function logic
     * Multiplication happens first -> then function logic gets executed -> then subtraction happens
     * for eg, If I use this on decrement() function with _decrement = 1, and s_counter = 10
     * _multiplier = 2, _subtracter = 5
     * first s_counter is multiplied with multiplier (2*10 = 20), then s_counter is decreased by 1 (20-1 =19), then s_counter
     * subtracts the _subtracter (19-5 = 14)
     * _ represents function logic, we can place any operations before or after _ to achieve sandwich effect
     */ 
    modifier sandwichCounter(uint256 _multiplier, uint256 _subtracter){
        s_counter *= _multiplier;
        _;
        s_counter -= _subtracter;
    }

    // get functions

    /** return current status */
    function getStatus() public view returns(bool){
        return s_paused;
    }

}