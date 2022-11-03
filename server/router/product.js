const express = require("express");
const productRouter = express.Router();
const { Product } = require("../models/product");
const {Category} =require("../models/categories");


//fetching categories
productRouter.get("/api/category/", async (req, res) => {
    try {
      const category = await Category.find();
      res.json(category);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });


//fetch all products
productRouter.get("/api/allproducts/",async (req, res) => {
    try {
      const products = await Product.find();
      res.json(products);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

//category wise products
productRouter.get("/api/categoryproducts/", async (req, res) => {
    try {
      const products = await Product.find({ category: req.query.category });
      res.json(products);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });


module.exports = productRouter;