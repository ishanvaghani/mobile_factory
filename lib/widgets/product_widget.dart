import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/providers/products_provider.dart';
import 'package:mobile_factory/widgets/product_widget_item.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  final bool isLoading;
  final String brandName;
  final String collectionName;
  final bool isBrand;
  ProductWidget({this.brandName, this.collectionName, @required this.isBrand, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    var products;
    if(isBrand) {
      products = provider.selectedBrandProducts(brandName);
    } else {
      products = provider.selectedCollectionProducts(collectionName);
    }
    return Container(
      child: isLoading
          ? GridView.builder(
              itemCount: 6,
              shrinkWrap: true,
              padding: defaultPadding,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                return ProductWidgetItem(
                  isLoading: true,
                );
              },
            )
          : GridView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              padding: defaultPadding,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductWidgetItem(
                  product: product,
                );
              },
            ),
    );
  }
}
