## <h1>GROWIC TASKS </h1>

1. **Task 1 - Use primitive data types to create a student database onchain.**

   _Immutable Student Registry_

   - Make owner a state variable with value type address and make it public
   - Have a mapping of address to students, you can give the mapping any name of your choice
   - Have a constructor that ensures that owner is equal to the msg.sender
   - Make use of a custom error for 'Entry already exists'
   - Have a modifier called onlyOwner and require that msg.sender = owner
   - Have a struct to contain details of students
   - Make sure that student cannot register twice
   - Have a function to get student details and it accepts one argument
   - Have a function to register students and it should be onlyOwner
   - `function registerNewStudent(address _studentID)` then add all the rest details of the student from your struct to the argument of this function
   - Create `function getStudentDetails(address _studentId)` to get details of a specific student
   - Create `function getAllStudentDetails()` to get a list of all student details in one place
   - Create `function modifyStudentDetail(address _studentId, string memory _name, uint256 _age)` to modify details of an existing student
   - Create `function deleteStudentDetail(address _studentId)` to delete details of an existing student

   **Refer to [01-TaskPrimitiveDataTypes.sol](./01-TaskPrimitiveDataTypes.sol)**

   ***

2. **Task 2 - Use mappings to store balances of users.**
   _Balance deposit and checker_

   - `deposit (uint256 _amount)` this function accepts one argument and it saves the amount a user is depositing into a mapping,
   - `checkBalance()` this function searches for the user balance inside the balance mapping and returns the balance of whoever is calling the contract.

   **Refer to [02-TaskMappings.sol](./02-TaskMappings.sol)**

   ***
