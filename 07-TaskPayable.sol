//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;


/**
 * @title Explains use of payable modifier to send/receive eth
 * @dev Deposit() function accepts deposits into the contract
 */
contract Payables{

       // Variables    
    mapping (address => uint256) public s_balances;
    address payable private s_owner;
    uint256 private immutable i_minPay;

  /**
   * @dev constructor initializes ownwer and minimum payable
   */
    constructor() {
        // cast it into payable to allow owner to send/receive payments
        s_owner = payable(msg.sender);
        i_minPay = 1000000000000000; // 0.001 eth is minimuum transfer value
    }

    /** 
     * @dev Deposit amount into contract and updates balances
     * function is made payable so that it can receive payments from external addresses
    */ 
    function deposit() external payable {
        require(msg.value > i_minPay, "Transfer below min allowed value");
        s_balances[msg.sender] += msg.value;
    }

    /**
     * @dev function allows owner to withdraw all the balance in contract
     */
    function withdraw() external payable{
        (bool sent, ) = s_owner.call{value: address(this).balance}("");
        require(sent, "Transfer failed");
    }

    /**
     *   @dev Returns balance for the addrees who initiated this function call
     */
    function checkBalance() public view returns(uint256){
        return s_balances[msg.sender];
    }

    /**
     *  @dev Returns balance amount in contract
     */
    function getContractBalance() external view returns(uint256){
        return address(this).balance;
    }
}