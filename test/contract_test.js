const TodoList = artifacts.require("TodoList.sol");

let _task = 'lavar';
let state = true;
contract("Set of account",async(accounts) => {
    
    

   beforeEach("Should prepare the test", async () => {
   
    todolistInstance = null;
    todolistInstance = await TodoList.deployed();
   });

   it("Should show the contract address.",async () => {
    console.log(TodoList.address);
    assert(TodoList !== " ");
   });

   //crear una tarea
   it("Should create a task", async () => {
    let task = await todolistInstance.createdTask(_task);
    return task;
   });

   //actualizamos la tarea
    it("Should change the task state.", async () => {
        await todolistInstance.createdTask(_task);
       let _state = await todolistInstance.taskState(_task,{from:accounts[0]});
       //assert(_state,state);
       return _state;
   });

});
