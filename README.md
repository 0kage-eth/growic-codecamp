## <h1>GROWIC TASKS </h1>

1.  **Task 1 - Use primitive data types to create a student database onchain.**

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

2.  **Task 2 - Use mappings to store balances of users.**

    _Balance deposit and checker_

    - `deposit (uint256 _amount)` this function accepts one argument and it saves the amount a user is depositing into a mapping,
    - `checkBalance()` this function searches for the user balance inside the balance mapping and returns the balance of whoever is calling the contract.

    **Refer to [02-TaskMappings.sol](./02-TaskMappings.sol)**

    ***

3.  **Task 3 - Use struct to store user details and balances.**

    _User registry with balance and user details_

    - create a struct `UserInfo` that captures balance, name and age of user
    - `deposit (uint256 _amount)` this function accepts one argument and it saves the amount a user is depositing into a mapping,
    - `withdraw(uint256 _amount)` function takes amount and reduces balances against a given user. Do error handling if withdrawal amount > current balance
    - `setUserDetails(string calldata _name, uint8 _age)` sets user details for user address originating txn, including name and age
    - `modifyUserDetails(string calldata _name, uint8 _age)` modifies user details including name and age
    - `deleteUserDetails()` delete user details of msg.sender
    - `checkBalance()` this function searches for the user balance inside the balance mapping and returns the balance of whoever is calling the contract.

    **Refer to [03-TaskStructs.sol](./03-TaskStructs.sol)**

    ***

4.  **Task 4 - Use modifiers to insert logic before or after a function call**

    _Use modifiers Check if a contract is in pause state & if numbers are out of range before executing function logic_

    - create a counter with `increment` and `decrement` functions that increase/decrese a stored value by a specific number
    - Have a state value `s_paused` - to execute any logic this state should be in `false` state
    - Create a function modifier called `checkPause()` that checks this condition before executing function logic
    - Embed modifier in function definitaion like so

                    function increment(uint256 _increment) public checkPause{
                        s_counter += _increment;
                      }

    - I've also written sample code for modifiers that take input variables & 'sandwich' modifiers where function logic can be sandwiched between a set of operations witin a function modifier

    Refer to code [04-TaskModifiers.sol](./04-TaskModifiers.sol) for further details

    ***

5.  **Task 5 - Create and emit events from within contract functions**

    _For exercise in task 3, add a `FundsDeposited(address, amount)` event and emit this event on deposit, and add a `ProfileUpdated(address)` event and emit this event everytime user details are updated_

    - create `FundsDeposited(address,amount)` event and `ProfileUpdated(address)` event
    - emit these events in `deposit` and `modifyUserDetails` functions respectively

    Refer to code [05-TaskEvents.sol](./05-TaskEvents.sol) for further details

    ***
