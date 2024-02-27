const productModel = require("./product_model");
const express = require('express');
const app = express();
log = console.log;

//---listen-4500-port--
app.listen(4500);

//--setting--midware--
app.use(express.json());

//-----Post-API-----
app.post("/create", async (req, resp) => {
    log(req.body);
    try {
      let data = new productModel(req.body);
      let result = await data.save()
      log(result);
      resp.send(result);
    } catch (error) {
      console.error(error);
      resp.status(500).send("Internal Server Error");
    }
  });