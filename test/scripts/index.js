module.exports = async function main(callback){
 
    try{
        //mostrando las direcciones
        const accounts = await web3.eth.getAccounts();
        console.log(accounts);

        let task = []; //guardamos las tareas en un array vacio
        
        //Instancinado el contrato
        const TodoList = artifacts.require('TodoList.sol');
        const todolist = await TodoList.deployed();

        //mostrando las tareas
        task = await todolist.allTask();
        console.log('Tareas:', task);

        //mostrando el estado de la tarea lavar
        const stado = await todolist.seeTask(task[0]);
        console.log('Estado de la tarea lavar', stado);


        callback(0);
    }catch(error){
        console.error("Error!!");
        callback(1);
    }
        
};

 