const express = require("express");
const app = express();

const middleWare  = require("./middlewares/middleware")
const route = express.Router()

app.listen(4500);
app.set("view engine","ejs");

//---middleware---
route.use(middleWare) //--multi-level-route-with-express-js--
app.use('/',route); 

/*
if we want to use middleware the we user route.get() and if we don't want to use
middleware the we use the app.get()
*/

//--home-page--
app.get("/",middleWare.myMiddleWare,resFilter,(_,res)=>{  //single-route-middleware
    res.render("home");
});

//--login-page--
route.get("/login",(_,res)=>{
    res.render("login");
});

//--login-page--
route.get("/contact",(_,res)=>{
    res.render("contact");
});