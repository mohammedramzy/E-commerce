// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

import 'package:commerce/model/product.dart';


ProductResponse productResponseFromJson(String str) => ProductResponse.fromJson(json.decode(str));

String productResponseToJson(ProductResponse data) => json.encode(data.toJson());

class ProductResponse {
  ProductResponse({
    this.products,
  });

  List<Product> products;

  factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

