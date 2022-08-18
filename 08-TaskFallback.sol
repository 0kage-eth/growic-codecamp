// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

/**
 * @title Use Fallbacks to allow transfers into contract
 * @dev fallback() gets called when an external function call does not exist in contract
 * @dev fallback() and receive() are largely used to manage transfers into contract, when no specific functions are fefined
 * @dev receive() gets called when msg.data is empty, else fallback() gets called
 */
contract Fallback{

    // variables


    /**
     * @dev Log event takes functionName, sender address, sender value and sender data
     */
    event Log(string functionName, address sender, uint256 value, bytes data);
 
    // errors


    // constructor


    // set functions
    /**
     * @dev fallback() gets called when function is not defined in contract
     * and when 'msg.data' is not null. In such case solidity falls back to the Fallback function
     * By making this function payable, we allow other addresses to transfer wei to contract address
     * Note that these are pre-existing funvtions - hence skipped the function tag at the beginning
     */
     fallback() external payable{
        // Emit Log event with "fallback" as name
        emit Log("Fallback", msg.sender, msg.value, msg.data);
    }

    /**
     * @dev Receive() function only gets called when transfer is made and msg.data is empty
     * Note that these are pre-existing functions - hence skipped the function tag at the beginning
     */
    receive() external payable{
        emit Log("Receive", msg.sender, msg.value,"");
    }

    // get functions
}