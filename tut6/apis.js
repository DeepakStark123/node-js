require("./config");
const productModel = require("./product_model");
const express = require("express");
const app = express();
log = console.log;

//---listen-4500-port--
app.listen(4500);

//--setting--midware--
app.use(express.json());

//-----Get-API-----
app.get("/get", async (req, resp) => {
  try {
    let result = await productModel.find();
    log(result);
    resp.send(result);
  } catch (error) {
    console.error(error);
    resp.status(500).send("Internal Server Error");
  }
});

//-----Post-API-----
app.post("/create", async (req, resp) => {
  log("request body=> ", req.body);
  try {
    let data = new productModel(req.body);
    let result = await data.save();
    log(result);
    resp.send("Data Added Successfully");
  } catch (error) {
    console.error(error);
    resp.status(500).send("Internal Server Error");
  }
});

//-----Update-API-----
app.put("/update/:_id", async (req, resp) => {
  log("request body => ", req.body);
  log("request params => ", req.params);
  var idObj = req.params;
  try {
    let result = await productModel.updateOne(idObj, {
      $set: req.body,
    });
    log(result);
    resp.send("Data Updated Successfully");
  } catch (error) {
    console.error(error);
    resp.status(500).send("Internal Server Error");
  }
});

//-----Update-API-----
app.delete("/delete/:_id", async (req, resp) => {
  log("request body => ", req.body);
  log("request params => ", req.params);
  var idObj = req.params;
  try {
    let result = await productModel.deleteOne(idObj);
    log(result);
    resp.send("Data Deleted Successfully");
  } catch (error) {
    console.error(error);
    resp.status(500).send("Internal Server Error");
  }
});

//-----Search-API-----
app.get("/search/:key", async (req, resp) => {
  try {
    let result = await productModel.find({
      $or: [
        { "name" : { $regex: req.params.key } }, 
        { "brand": { $regex: req.params.key } },
        { "category" : { $regex: req.params.key } },
      ],
    });
    log(result);
    resp.send(result);
  } catch (error) {
    console.error(error);
    resp.status(404).send("Not Found");
    resp.status(500).send("Internal Server Error");
  }
});
