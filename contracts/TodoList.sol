//SPDX-License-Identifier:MIT

pragma solidity ^0.8.11;
pragma experimental  ABIEncoderV2;
/**
  PROGRAMA PARA REALIZAR UNA LISTA DE TAREAS
 */
contract TodoList{

 struct Task{
    uint id;
    string name;
    bool state;
 }
 //declaramos una lista de tareas
 Task[] tasklist;

 //mapping que relaciona el id de la tarea con la tarea
 mapping(uint => Task) tasks;

 //declaramos una variable que sera el nuevo id
 uint newId;

 //eventos para saber cuando se creo una tarea y cuando se le cambio el estado
 event createdTask(uint id, string name, bool state);
 event StateTask(uint id, bool state); 
 // lista para mostrar las tareas
 string[] listtask;

 //@ funcion para manipular las listas de tareas buscar tareas
 function Search(uint _valor) internal view returns(uint){
    for(uint i = 0; i < tasklist.length; i++){
        if(tasklist[i].id == _valor)
        return i;
    }
    revert("Task dos'nt exist.");
 }

 //@ funcion para crear las tareas
 function createTask(string memory _name) public{
    newId++; //incrementamos el valor del id cada vez que se llame a esta funcion
    for(uint i = 0; i < tasklist.length; i++){
        require(keccak256(abi.encodePacked(_name)) != keccak256(abi.encodePacked(tasklist[i].name)),"Task already exist.");
    }
    tasklist.push(Task(newId,_name,false));
    tasks[newId] = Task(newId,_name,false);
    listtask.push(_name);
    //emitimos el evento de tarea creada
    emit createdTask(newId, _name, false);
 }

 //@funcion para dar de alta a una tarea
 function taskState(uint _id) public{
    uint i = Search(_id); //comprobamos si la tarea existe 
    Task memory _tasks = tasks[i];
    _tasks.state = !_tasks.state;
    tasks[i] = _tasks;
    //emitimos que la tarea cambio de estado
    emit StateTask(_id, _tasks.state);
 }

 //@funcion para actualizar una tarea(cambiar el nombre de la tarea)
 function updateTask(uint _id, string memory _name) public {
    uint i = Search(_id);
    tasks[i].name = _name;
    listtask[i] = _name;
 }

 //@funcion para ver la tarea y su estado
 function seeTask(uint _id) public view returns(Task memory){
    uint i = Search(_id);
    return tasks[i];
 }

 //@funcio que me regresa el listado de tareas
 function allTask() public view returns(string[] memory){
    return listtask;
 }

}