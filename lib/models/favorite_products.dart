import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_factory/models/product.dart';

class FavoriteProducts {
  List<Product> products;
  FavoriteProducts({
    @required this.products,
  });

  FavoriteProducts copyWith({
    List<Product> products,
  }) {
    return FavoriteProducts(
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'products': products?.map((x) => x.toMap())?.toList(),
    };
  }

  factory FavoriteProducts.fromMap(Map<String, dynamic> map) {
    return FavoriteProducts(
      products: List<Product>.from(map['products']?.map((x) => Product.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteProducts.fromJson(String source) => FavoriteProducts.fromMap(json.decode(source));

  @override
  String toString() => 'FavoriteProducts(products: $products)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is FavoriteProducts &&
      listEquals(other.products, products);
  }

  @override
  int get hashCode => products.hashCode;
}
