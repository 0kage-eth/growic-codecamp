// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract StudentData{

    /// @dev Owner is creator of contract   
    address public s_owner;

    /// @dev Student struct stores name and age of registered student   
    struct Student{
        string name;
        uint8 age;
    }

    /// @dev mapping that stores a hash of addres -> student
    mapping (address => Student) public s_studentMap;

    /// @dev custom error fires if user is already registere
    /// returns id and name that caused this error
    error StudentData__AlreadyExists(address id, uint8 name);

    /// @dev constructor assigns owner to msg.sender at time of creation
    /// check this in future to ensure nobody can change state of student Map except owner
    constructor() {
        // setting owner to msg.sender at the time of contract creation
        s_owner = msg.sender;
    }

   
    /// @dev onlyOwner checks if a msg.sender is owner. Will execute before any function call that uses this modifier
    modifier onlyOwner {
        require(msg.sender == s_owner);
        _;
    }


    /// @dev Gets student details for a given Id
    /// @param _studentId Ethereum address of student
    /// @return Student details

    function getStudentDetails(address _studentId) public view returns(Student memory){
        return s_studentMap[_studentId];
    }


    /// @dev function to register a new student. Only to be done by contract owner
    /// @param _studentId eth address of new student
    /// @param _name name of new student. Pointing to memory location
    /// @param _id id of new student. Pointing to memory location 
    
    function registerNewStudent(address _studentId, string memory _name, uint8 _id) public onlyOwner {
        Student memory details = s_studentMap[_studentId];
        // Checking if address already exists
        // Reverting to an error if address exists
        if(bytes(details.name).length != 0){
            revert StudentData__AlreadyExists(_studentId, details.age);
        }
        Student memory newStudent = Student(_name, _id);

        // Registering new student
        s_studentMap[_studentId] = newStudent;

    }

}