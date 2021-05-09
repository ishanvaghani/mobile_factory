import 'dart:convert';

import 'package:flutter/material.dart';

class Product {
  String id;
  String name;
  String imgUrl;
  int price;
  int quantity;
  String description;
  String brand;
  String featured;
  Product({
    @required this.id,
    @required this.name,
    @required this.imgUrl,
    @required this.price,
    @required this.quantity,
    @required this.description,
    @required this.brand,
    @required this.featured,
  });
  

  Product copyWith({
    String id,
    String name,
    String imgUrl,
    int price,
    int quantity,
    String description,
    String brand,
    String featured,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      featured: featured ?? this.featured,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'price': price,
      'quantity': quantity,
      'description': description,
      'brand': brand,
      'featured': featured,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      imgUrl: map['imgUrl'],
      price: map['price'],
      quantity: map['quantity'],
      description: map['description'],
      brand: map['brand'],
      featured: map['featured'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, imgUrl: $imgUrl, price: $price, quantity: $quantity, description: $description, brand: $brand, featured: $featured)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Product &&
      other.id == id &&
      other.name == name &&
      other.imgUrl == imgUrl &&
      other.price == price &&
      other.quantity == quantity &&
      other.description == description &&
      other.brand == brand &&
      other.featured == featured;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      imgUrl.hashCode ^
      price.hashCode ^
      quantity.hashCode ^
      description.hashCode ^
      brand.hashCode ^
      featured.hashCode;
  }
}
