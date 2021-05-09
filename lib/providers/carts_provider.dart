import 'package:flutter/material.dart';
import 'package:mobile_factory/helper/firebase_constant.dart';
import 'package:mobile_factory/models/cart.dart';
import 'package:mobile_factory/models/product.dart';

class CartsProvider with ChangeNotifier {
  Cart _cart;
  int _cartLength = 0;

  Cart get cart => _cart;

  int get cartLength => _cartLength;

  Future<void> fetchCart() async {
    cartRef.snapshots().listen((documentSnapshot) {
      if (documentSnapshot.exists) {
        Cart cart = Cart.fromMap(documentSnapshot.data());
        _cart = cart;
        _cartLength = _cart.products.length;
        notifyListeners();
      } else {
        _cart = null;
        _cartLength = 0;
        notifyListeners();
      }
    });
  }

  Future<void> addToCart(Product product) async {
    if (cart != null) {
      if (cart.products.contains(product)) {
        Product cartProduct =
            cart.products.firstWhere((prod) => prod.id == product.id);
        product.quantity = cartProduct.quantity + 1;
        List<Product> products = cart.products;
        int total = cart.total + product.price;
        int index = products.indexOf(cartProduct);
        products.removeAt(index);
        products.insert(index, product);
        await cartRef.update(Cart(total: total, products: products).toMap());
      } else {
        product.quantity = 1;
        List<Product> products = cart == null ? [] : cart.products;
        products.add(product);
        int total = cart.total + product.price;
        await cartRef.set(Cart(total: total, products: products).toMap());
      }
    } else {
      product.quantity = 1;
      List<Product> products = cart == null ? [] : cart.products;
      products.add(product);
      int total = product.price;
      await cartRef.set(Cart(total: total, products: products).toMap());
    }

    notifyListeners();
  }

  Future<void> clearCart() async {
    await cartRef.delete();
  }

  Future<void> incrementProductQuantity(Product product) async {
    Product cartProduct =
        cart.products.firstWhere((prod) => prod.id == product.id);
    product.quantity = cartProduct.quantity + 1;
    List<Product> products = cart.products;
    int total = cart.total + product.price;
    int index = products.indexOf(cartProduct);
    products.removeAt(index);
    products.insert(index, product);
    await cartRef.update(Cart(total: total, products: products).toMap());
  }

  Future<void> removeProduct(Product product) async {
    if (product.quantity == 1) {
      List<Product> products = cart.products;
      products.removeWhere((prod) => prod.id == product.id);
      int total = cart.total - product.price;
      await cartRef.set(Cart(total: total, products: products).toMap());
    } else {
      Product cartProduct =
          cart.products.firstWhere((prod) => prod.id == product.id);
      product.quantity--;
      List<Product> products = cart.products;
      int index = products.indexOf(cartProduct);
      products.removeAt(index);
      products.insert(index, product);
      int total = cart.total - product.price;
      await cartRef.set(Cart(total: total, products: products).toMap());
    }
  }
}
