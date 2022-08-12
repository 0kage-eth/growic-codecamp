// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

/// @title Working with structs
/// @author 0Kage
/// @dev Contract helps create, modify and delete custom user data in structs 
contract Structs{

    /// @dev UserInfo struct stores name, age and balance (in wei) of a specific user
    struct UserInfo{
        string name;
        uint8 age;
        uint256 balance;
    }

    /// @dev throw error if balance is less than withdrawal requested by user
    error Structs__NotEnoughBalance(address user, uint256 balance);

    /// @dev maps address against UserInfo for all users. Variable stored in Storage.
    mapping(address => UserInfo) public s_userDetails;

    // SET FUNCTIONS (CHANGE STATE)

    /// @dev assign balance against given address in mapping. Note that its a dummy transfer 
    /// @param _amount amount in wei
    function deposit(uint256 _amount) public {
        s_userDetails[msg.sender].balance += _amount; 
    }

    /// @dev withdraw existing balance against given address in mapping. Note that its a dummy transfer 
    /// @dev revert with an error if withdrawal amount is more than current balance
    /// @param _amount amount in wei
    function withdraw(uint256 _amount) public {
        if(_amount > s_userDetails[msg.sender].balance){
            revert Structs__NotEnoughBalance(msg.sender, s_userDetails[msg.sender].balance);
        }
        // Subtracting withdrawal amount from user balance
        s_userDetails[msg.sender].balance -= _amount;
    }
    
    /// @dev sets user details including name & age for a given address
    /// @dev note that _name is stored in calldata and not memory - because it is a payload of msg.sender
    /// @param _name name of user (string)
    /// @param _age age of user (note its in uint8 type)
    function setUserDetails(string calldata _name, uint8 _age) public {
        s_userDetails[msg.sender].name = _name;
        s_userDetails[msg.sender].age = _age;
    }


   /// @dev Modifies user data for given user
   /// @param _name name of user. Stored in calldata
   /// @param _age age of use (uint8)
    function modifyUserDetails(string calldata _name, uint8 _age) public {
         s_userDetails[msg.sender].name = _name;
         s_userDetails[msg.sender].age = _age;
    }

    /// @dev Deletes all data stored in mapping for user address
    function deleteUserDetails() public {
        delete s_userDetails[msg.sender];
    }

    // GET FUNCTIONS (PURE/VIEW)

    /// @dev Check balance for a given user address
    /// @return balance returns balance in wei 
    function checkBalance() public view returns(uint256 balance) {
        balance = s_userDetails[msg.sender].balance;
        return balance;
    }

    /// @dev Returns user details for a given address
    /// @return info user info that includes name, age and balance
    function getUserDetails() public view returns(UserInfo memory info){
        return s_userDetails[msg.sender];
    }

}