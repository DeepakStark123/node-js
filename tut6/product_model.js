const mongoose = require('mongoose');
const productSchema = mongoose.Schema({
    name:String,
    price:Number,
    brand:String,
    category:String,
});
const productModel = mongoose.model("products", productSchema);

//---exporting variables--
module.exports = productModel;

