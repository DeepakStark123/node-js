const { MongoClient } = require("mongodb");
const url = "mongodb://localhost:27017"; // Connection URL
const dbName = "e-com"; // Database Name
const client = new MongoClient(url);

async function dbConnect() {
    // Use connect method to connect to the server
    await client.connect();
    console.log("Connected successfully to server");
    const db = client.db(dbName);
    return db.collection("products");
}

module.exports = dbConnect;
