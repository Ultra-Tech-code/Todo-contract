//SPDX-License-Identifier

pragma solidity ^0.8.9;

contract toDo{
    //owner of the contract
    address owner;
    //setting the owner to msg.sender
    constructor(){
        owner = msg.sender;
    }
    //restricting access to the owner
    modifier onlyOwner(){
        require(msg.sender == owner, "You can't access this");
        _;
    }

    //a struct that keeps the task and status of the task if it's completed or not
    struct Todo{
        string Subject;
        bool completed;
    }

    //initialize task id to be 1
    uint taskId = 1;
    // keeping track of each task created and stored in an array of the struct Todo
    mapping(uint => Todo[]) todolist;
    //Todo[] todolist;

    //this is where the owner create tasks
    //the status is set to false  as default
    function setTask(string memory _tasks) external onlyOwner{
        Todo memory todo = Todo(_tasks, false);
        //i'm pushing the task created to the mapping that keep tracks of each task
        todolist[taskId].push(todo);
        //the taskId is being inreased here. so each task have their own taskId
        taskId++;
    }

    //the user set each task he/she has completed to true
    //the user enters the id of the task and it changes the status to true
    function completeTask( uint _id) external onlyOwner{ 
    //get the length of the task with the id a user entered
        uint length = todolist[_id].length;
    //create a for loop using the lenght as a limit
        for(uint i = 0; i < length; i++)
        {
    //I get the task with the id enetered and changed the status of completed to true
            todolist[_id][i].completed = true;
        }   
    }

    //this return the task at a particular taskid
    function getTask(uint _id) external onlyOwner returns(Todo[] memory){
        require(_id <= taskId, "task with this id doesn't exist");
        return todolist[_id];   
    }


    //this returns the total number of task created by a user
    function getTotalTask() external view onlyOwner returns(uint){
        return taskId - 1; 
    }

    //This delete a task withe particular id (set the value to 0/empty;
    function deleteTask(uint _id) onlyOwner external{
        delete todolist[_id];
    }

}