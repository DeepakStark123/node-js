const mongoose = require("mongoose");
const dbName = "todo";
const url = `mongodb://localhost:27017/${dbName}`;
// If Database is not available then create the database name 'todo'.
mongoose.connect(url);
const dbConnect = mongoose.connection;
dbConnect.on('error', console.error.bind(console, 'connection error:'));
dbConnect.once('open', () => {
    console.log('Connected to MongoDB');
});

//--Exporting-Database--
module.exports = dbConnect;