import 'package:flutter/material.dart';
import 'package:mobile_factory/widgets/cart_icon_widget.dart';
import 'package:mobile_factory/widgets/product_widget.dart';

class ProductsPage extends StatelessWidget {
  final String brandName;
  final String collectionName;
  final bool isBrand;
  ProductsPage({this.brandName, this.collectionName, @required this.isBrand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isBrand ? brandName : collectionName),
        actions: [
          CartIconWidget(),
        ],
      ),
      body: isBrand
          ? ProductWidget(
              brandName: brandName,
              isBrand: isBrand,
            )
          : ProductWidget(
              isBrand: isBrand,
              collectionName: collectionName,
            ),
    );
  }
}
