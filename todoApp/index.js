const app = require('./app');
const db = require('./config/db');
// const ToDoService = require('../services/todo_services');

const port = 4500;
app.listen(port,()=>{
    console.log(`Server is running on port http://localhost:${port}`);
})

//--get--
app.get('/',(req,res)=>{
    res.send("Hello World")
})

