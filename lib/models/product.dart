// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
  bool available;
  double price;
  String name;
  String? picture;
  String? id;

  Product({
    required this.available,
    required this.name,
    required this.price,
    this.picture,
    this.id,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "name": name,
        "picture": picture,
        "price": price,
      };

      Product copyProduct() => Product(
        available: available,
        name: name,
        price: price,
        picture: picture,
        id: id
        );
}
