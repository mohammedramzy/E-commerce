class Product {
  Product({
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
  String description;
  int price;
  int discount;
  String discountType;
  String currency;
  int inStock;
  String avatar;
  double priceFinal;
  String priceFinalText;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"] == null ? 0 :json["id"],
    name: json["name"]== null ? "" :json["name"],
    title: json["title"] == null ? "" :json["title"],
    categoryId: json["category_id"] == null ? 0 :json["category_id"],
    description: json["description"] == null ? "" : json["description"],
    price: json["price"]== null? 0.0 :json["price"],
    discount: json["discount"]== null ? 0.0 :json["discount"],
    discountType: json["discount_type"] == null ? "" : json["discount_type"],
    currency: json["currency"]== null ? "" :json["currency"],
    inStock: json["in_stock"]== null? 0 :json["in_stock"],
    avatar: json["avatar"]== null ? "" :json["avatar"],
    priceFinal: json["price_final"] == null ? 0.0 : json["price_final"].toDouble(),
    priceFinalText: json["price_final_text"]== null ? "":json["price_final_text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
    "category_id": categoryId,
    "description": description == null ? null : description,
    "price": price,
    "discount": discount,
    "discount_type": discountType == null ? null : discountType,
    "currency": currency,
    "in_stock": inStock,
    "avatar": avatar,
    "price_final": priceFinal,
    "price_final_text": priceFinalText,
  };
}




