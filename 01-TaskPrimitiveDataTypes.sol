// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/// @title Immutable student registry management - example
/// @author 0Kage
/// @notice Contract stores, modifies and deletes student details. 
/// @dev Custom struct called Student is defined that stores name & age
/// @dev Stored mapping of students & student address array in storage variables

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

    /// @dev array of all student addresses
    address[] public s_students;

    /// @dev custom error fires if user is already registered
    /// returns id and name that caused this error
    error StudentData__AlreadyExists(address id, string name, uint8 age);

    /// @dev custom error fires if user is not registered 
    /// returns id and name that caused this error
    error StudentData__DoesNotExist(address id, string name, uint8 age);

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

    /// @dev function to register a new student. Only to be done by contract owner
    /// @param _studentId eth address of new student
    /// @param _name name of new student. Pointing to memory location
    /// @param _age id of new student. Pointing to memory location 
    
    function registerNewStudent(address _studentId, string memory _name, uint8 _age) public onlyOwner {
        Student memory details = s_studentMap[_studentId];
        // Checking if address already exists
        // Reverting to an error if address exists
        if(bytes(details.name).length != 0){
            revert StudentData__AlreadyExists(_studentId, details.name, details.age);
        }
        Student memory newStudent = Student(_name, _age);

        // Registering new student
        s_studentMap[_studentId] = newStudent;

        // Adding student to student list
        s_students.push(_studentId);

    }

    /// @dev Modifty an existing student details
     /// @param _studentId eth address of new student
    /// @param _name name of new student. Pointing to memory location
    /// @param _age id of new student. Pointing to memory location
    /// @return success if modified successfully
    function modifyStudentDetail(address _studentId, string memory _name, uint8 _age) public onlyOwner returns(bool success){
        Student memory existingStudent = s_studentMap[_studentId];

        if(existingStudent.age != 0){
            revert StudentData__DoesNotExist(_studentId, _name, _age);
        }

        existingStudent.name = _name;
        existingStudent.age = _age;
        s_studentMap[_studentId] = existingStudent;
        return true;

    }

    /// @dev Finds index of an specific address in an array of address list
    /// @dev note that this is a 'pure' internal function - pure because its logic does not use any storage variables
    /// @dev internal because we only want this contract or its inherited contracts to use this function
    /// @param targetAddress specific address we are searching for
    /// @param addresses list of addresses on which we need to search
    /// @return index index of element in search,  -1 if we cannot find index
    function findIndexOfElementinArray(address targetAddress, address[] memory addresses) private pure returns(int256 index){
        for(uint256 indx =0; indx < addresses.length; indx++){
            if(addresses[indx] == targetAddress){
                return int256(indx);
            }            
        }

        return -1;

    }

    /// @dev Delete student details for a given studentId
     /// @param _studentId eth address of new student
    /// @return success if modified successfully

    function deleteStudentDetail(address _studentId) public returns(bool) {
        Student memory existingStudent = s_studentMap[_studentId];

        existingStudent.name = "";
        existingStudent.age = 0;
        int256 index = findIndexOfElementinArray(_studentId, s_students);
        if (index == -1){
            revert StudentData__DoesNotExist(_studentId, "", 0);
        }

        // resetting the element in mapping to default values
        // note that there is no deletion of mapping
        delete s_studentMap[_studentId];

        // cast the variable ack to uint256 - this is fine because we reach here only if index != -1
        delete s_students[uint256(index)];

        return true;
    }


    /// @dev Gets student details for a given Id
    /// @param _studentId Ethereum address of student
    /// @return Student details

    function getStudentDetails(address _studentId) public view returns(Student memory){
        return s_studentMap[_studentId];
    }

    /// @dev Returns an array of Student type - all students at one place
    /// @return Student[] - Array of Student type
    function getAllStudentDetails() public view returns(Student[] memory){
        Student[] memory allStudents = new Student[](s_students.length);

        for(uint256 indx =0; indx <s_students.length ; indx++){
            address currentStudentAddress = s_students[indx];
            allStudents[indx] = s_studentMap[currentStudentAddress];
        }
        return allStudents;
    }

}