import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/providers/products_provider.dart';
import 'package:mobile_factory/widgets/cart_icon_widget.dart';
import 'package:mobile_factory/widgets/product_widget_item.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    final products = provider.favoriteProducts;
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
        actions: [
          CartIconWidget(),
        ],
      ),
      body: GridView.builder(
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
