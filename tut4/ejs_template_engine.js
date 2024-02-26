const express = require("express");
const path = require("path")
const app = express();
log = console.log
app.listen(4500);
publicDir = path.join(__dirname,"public")
app.set("view engine","ejs");

///--send-home--
app.get("/profile",(_,res)=>{
    const user = {
        'name':'deepak',
        'userid':100,
        'position':'flutter developer'
    }
  res.render("profile",{user});
});

