const express = require('express');
const body_parser = require('body-parser');
const UserRouter = require('./routes/user_router');
const ToDoRoute = require('./routes/todo_router');
const app = express();
app.use(body_parser.json());
app.use('/',UserRouter);
app.use("/",ToDoRoute);

//Exporting Variable
module.exports = app;