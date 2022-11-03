import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:furniture_app/constants.dart';
import 'package:furniture_app/models/product.dart';
import 'package:furniture_app/models/category.dart';
import 'package:http/http.dart' as http;

fetchProducts() async {
  final response = await http.get(Uri.parse("$uri/api/allproducts/"));
  if (response.statusCode == 200) {
    List<Product> products = (json.decode(response.body) as List)
        .map((data) => Product.fromJson(data))
        .toList();
    return products;
  } else {
    throw Exception('Failed to load');
  }
}

fetchCategoryProducts(String category) async {
  final response =
      await http.get(Uri.parse("$uri/api/categoryproducts/?category=$category"));
  if (response.statusCode == 200) {
    List<Product> products = (json.decode(response.body) as List)
        .map((data) => Product.fromJson(data))
        .toList();
    return products;
  } else {
    throw Exception('Failed to load');
  }
}

fetchCategories() async {
  final response = await http.get(Uri.parse("$uri/api/category/"));
  if (response.statusCode == 200) {
    List<Categories> category = (json.decode(response.body) as List)
        .map((data) => Categories.fromJson(data))
        .toList();
    return category;
  } else {
    throw Exception('Failed to load');
  }
}
