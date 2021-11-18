// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

import 'package:commerce/model/product.dart';


CartResponse cartResponseFromJson(String str) => CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  CartResponse({
    this.products,
  });

  List<ProductElement> products;

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
    products: List<ProductElement>.from(json["products"].map((x) => ProductElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class ProductElement {
  ProductElement({
    this.amount,
    this.total,
    this.totalText,
    this.product,
  });

  int amount;
  double total;
  String totalText;
  Product product;

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
    amount: json["amount"]== null ? 0 : json["amount"],
    total: json["total"] == null ? 0.0 :json["total"].toDouble(),
    totalText: json["total_text"] == null ? "" :json["total_text"],
    product: json["product"]== null ? Product(): Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "total": total,
    "total_text": totalText,
    "product": product.toJson(),
  };
}

class ProductProduct {
  ProductProduct({
    this.id,
    this.name,
    this.title,
    this.categoryId,
    this.description,
    this.price,
    this.discount,
    this.discountType,
    this.currency,
    this.inStock,
    this.avatar,
    this.priceFinal,
    this.priceFinalText,
  });

  int id;
  String name;
  String title;
  int categoryId;
  dynamic description;
  int price;
  int discount;
  dynamic discountType;
  String currency;
  int inStock;
  String avatar;
  double priceFinal;
  String priceFinalText;

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
    id: json["id"],
    name: json["name"],
    title: json["title"],
    categoryId: json["category_id"],
    description: json["description"],
    price: json["price"],
    discount: json["discount"],
    discountType: json["discount_type"],
    currency: json["currency"],
    inStock: json["in_stock"],
    avatar: json["avatar"],
    priceFinal: json["price_final"],
    priceFinalText: json["price_final_text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
    "category_id": categoryId,
    "description": description,
    "price": price,
    "discount": discount,
    "discount_type": discountType,
    "currency": currency,
    "in_stock": inStock,
    "avatar": avatar,
    "price_final": priceFinal,
    "price_final_text": priceFinalText,
  };
}
