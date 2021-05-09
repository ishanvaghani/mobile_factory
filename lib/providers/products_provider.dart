import 'package:flutter/material.dart';
import 'package:mobile_factory/helper/firebase_constant.dart';
import 'package:mobile_factory/models/favorite_products.dart';
import 'package:mobile_factory/models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> _favoriteProducts = [];

  List<Product> get products => _products;
  List<Product> get favoriteProducts => _favoriteProducts;

  List<Product> selectedCollectionProducts(String collectionName) {
    return _products
        .where((product) => product.featured == collectionName)
        .toList();
  }

  List<Product> selectedBrandProducts(String brandName) {
    return _products.where((product) => product.brand == brandName).toList();
  }

  Product findById(String productId) {
    return _products.firstWhere((product) => product.id == productId);
  }

  Future<void> fetchAndSetProducts() async {
    List<Product> products = [];
    await productRef.get().then(
          (querySnapshot) => querySnapshot.docs.forEach((doc) {
            products.add(Product.fromMap(doc.data()));
          }),
        );
    _products = products;
    notifyListeners();
  }

  Future<void> fetchAndSetFavoriteProducts() async {
    _favoriteProducts.clear();
    favoritesProductRef.snapshots().listen((documentSnapshot) async {
      if (documentSnapshot.exists) {
        FavoriteProducts favoriteProducts =
            FavoriteProducts.fromMap(documentSnapshot.data());
        _favoriteProducts = favoriteProducts.products;
      }
      notifyListeners();
    });
  }

  Future<void> toggleFavoriteStatus(bool isFavorite, Product product) async {
    isFavorite = !isFavorite;
    await favoritesProductRef.get().then((documentSnapshot) async {
      if (isFavorite) {
        if (documentSnapshot.exists) {
          FavoriteProducts favoriteProducts =
              FavoriteProducts.fromMap(documentSnapshot.data());
          favoriteProducts.products.add(product);
          await favoritesProductRef.set(
              FavoriteProducts(products: favoriteProducts.products).toMap());
        } else {
          List<Product> favoriteProducts = [];
          favoriteProducts.add(product);
          await favoritesProductRef
              .set(FavoriteProducts(products: favoriteProducts).toMap());
        }
      } else {
        FavoriteProducts favoriteProducts =
            FavoriteProducts.fromMap(documentSnapshot.data());
        favoriteProducts.products.remove(product);
        await favoritesProductRef
            .set(FavoriteProducts(products: favoriteProducts.products).toMap());
      }
    });
    notifyListeners();
  }
}
