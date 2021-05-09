import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_factory/models/product.dart';

class Cart {
  int total;
  List<Product> products;
  Cart({
    @required this.total,
    @required this.products,
  });
  

  Cart copyWith({
    int total,
    List<Product> products,
  }) {
    return Cart(
      total: total ?? this.total,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'products': products?.map((x) => x.toMap())?.toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      total: map['total'],
      products: List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() => 'Cart(total: $total, products: $products)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Cart &&
      other.total == total &&
      listEquals(other.products, products);
  }

  @override
  int get hashCode => total.hashCode ^ products.hashCode;
}
