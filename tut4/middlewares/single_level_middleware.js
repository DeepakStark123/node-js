const express = require("express");

const app = express();
app.listen(4500);
app.set("view engine","ejs");
//----Get-Middleware---
const myMiddleWare  = require("./middleware")

//---check-user-input--
// app.use(myMiddleWare); //--multi-level-route-middleware--

//--home-page--            
app.get("/",myMiddleWare,(_,res)=>{   //--single-level-route-middleware--
    res.render("home");
});