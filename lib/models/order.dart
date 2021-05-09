import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_factory/models/product.dart';

class Order {
  String id;
  int amount;
  List<Product> products;
  Order({
    @required this.id,
    @required this.amount,
    @required this.products,
  });

  Order copyWith({
    String id,
    int amount,
    List<Product> products,
  }) {
    return Order(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'products': products?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      amount: map['amount'],
      products: List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  @override
  String toString() => 'Order(id: $id, amount: $amount, products: $products)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Order &&
      other.id == id &&
      other.amount == amount &&
      listEquals(other.products, products);
  }

  @override
  int get hashCode => id.hashCode ^ amount.hashCode ^ products.hashCode;
}
