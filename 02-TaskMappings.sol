// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract Mappings{

    // Variables    
    mapping (address => uint256) public s_balances;

    // Constructor
    constructor() {

    }

    // functions

    // set deposit to balances
    function deposit(uint256 _amount) public {
        s_balances[msg.sender] += _amount;

    }

    // checks balance for msg sender address
    function checkBalance() public view returns(uint256){
        return s_balances[msg.sender];
    }



}