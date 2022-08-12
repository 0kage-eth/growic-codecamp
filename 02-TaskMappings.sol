// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/// @title Contract to deposit and keep track of balances. Pretty basic - no ERC20 implementation.
/// @author 0Kage
/// @dev Creating a mapping of user address -> balances

contract Mappings{

    // Variables    
    mapping (address => uint256) public s_balances;

    // Constructor
    constructor() {

    }

    // functions

    /// @dev Deposit amount into a mapping 
    /// @param _amount amount in wei to be deposited
    function deposit(uint256 _amount) public {
        s_balances[msg.sender] += _amount;
    }

    /// @dev Returns balance for the addrees who initiated this function call
    function checkBalance() public view returns(uint256){
        return s_balances[msg.sender];
    }

}