// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7; 
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


/**
 * @title Explains concept of inheritance in solidity
 * @dev ERC20 is an openzeppelin contract (github: OpenZeppelin)
 * @dev KageToken contract inherits all functionality of ERC20 contract
 * @dev We will override the decreaseAllowance() function of ERC20 contract
 */
contract KageToken is ERC20{
    
    /**
     * @dev ERC20 constructor needs two params to initialize
     * @param _name name of token
     * @param _symbol token symbol
     */
    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol){}

    function decreaseAllowance(address spender, uint256 subtractedValue) public override returns(bool){
                address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);

        /**
         * @dev here I modify the condition  - minimum approved balance should be 0.01 eth
         * In original ERC20 implememntation, minimum is 0. By overriding it, I can update logic as per my requirement
         * Note that a function should be virtual in parent contract for it to be overriden in its inherited contract
         */

        require(currentAllowance - subtractedValue >= 10000000000000000, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

}