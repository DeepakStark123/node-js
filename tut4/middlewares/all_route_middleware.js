const express = require("express");

const app = express();
app.listen(4500);
app.set("view engine","ejs");
//----Get-Middleware---
const middleWare  = require("./middleware")

//---check-user-input--
app.use(middleWare.myMiddleWare); //--multi-level-route-middleware--

//--home-page--
app.get("/",(_,res)=>{
    res.render("home");
});