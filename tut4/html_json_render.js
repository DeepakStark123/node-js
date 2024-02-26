const express = require("express");
const app = express();
log = console.log

app.get("", (req, res) => {
    log("request parameter =>",req.query.name)
    res.send(
        `
        <h1>Hello,Welcome to home Page<h1>
        <a href = "/about">Go to about page</a>

        `
    );
});

app.get("/about", (req, res) => {
    nameval = req.query.name == undefined ? "" : req.query.name;
    res.send(
        `   <h1>Hello,Welcome to About Page<h1>
            <input placeholder = "User Name" type="text"  value = "${nameval}"></input>
            <button>Click</button>
        `
    )
})

app.get("/help", (req, res) => {
    res.send(
        [
        {
            'name':'deepak',
            'position':'flutter dev'
        },
        {
            'name':'deepak',
            'position':'flutter dev'
        }
      ]
    )
})




app.listen(4500);