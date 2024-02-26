const dbConnect = require("./mongodb");
const express = require("express");
const app = express();
log = console.log;
app.listen(4500);

app.use(express.json());

//-------Get-APi-----
app.get("/", async (req, res) => {
  var db = await dbConnect();
  log(data);
  log(req.body);
  try {
    var db = await dbConnect();
    const result = await db.find().toArray();
    res.send(result);
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
});

//-----Post-APi-----
app.post("/", async (req, res) => {
  log(req.body);
  try {
    var db = await dbConnect();
    if (Array.isArray(req.body)) {
      const result = await db.insertMany(req.body);
      res.send(result);
    } else {
      const result = await db.insertOne(req.body);
      res.send(result);
    }
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
});

//-----Update-APi-----
app.put("/:name", async (req, res) => {
  log(req.body);
  try {
    var db = await dbConnect();
    const result = await db.updateOne(
      { name: req.params.name },
      { $set: req.body }
    );
    res.send(result);
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
});

//-----Delete-APi-----
app.delete("/:name", async (req, res) => {
  log(req.params.name);
  try {
    var db = await dbConnect();
    const result = await db.deleteOne({ name: req.params.name });
    res.send(result);
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
});
