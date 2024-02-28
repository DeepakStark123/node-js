const app = require('./app');
const db = require('./config/db');
const UserModel = require('./model/user_model');
const userModel = UserModel();
const port = 4500;
var log = console.log;
app.listen(port,()=>{
    log(`Server is running on port http://localhost:${port}`);
})

//get
app.get('',(req,resp)=>{
    resp.send("Hello, How are your");
});

