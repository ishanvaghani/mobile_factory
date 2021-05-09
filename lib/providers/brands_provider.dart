import 'package:flutter/material.dart';
import 'package:mobile_factory/helper/firebase_constant.dart';
import 'package:mobile_factory/models/brand.dart';

class BrandsProvider with ChangeNotifier {
  List<Brand> _brands = [];

  List<Brand> get brands => _brands;

  Future<void> fetchAndSetBrands() async {
    List<Brand> brands = [];
    await brandRef.get().then((querySnapshot) => querySnapshot.docs.forEach((doc) {
          brands.add(Brand.fromMap(doc.data()));
        }));
    _brands = brands;
    notifyListeners();
  }
}
