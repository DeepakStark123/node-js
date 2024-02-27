const mongoose = require('mongoose');
const productSchema = mongoose.Schema({
    name:String,
    brand:String,
    category:String,
    price:Number,
});
const productModel = mongoose.model("products", productSchema);

//---exporting variables--
module.exports = productModel;

