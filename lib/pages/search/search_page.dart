import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/models/product.dart';
import 'package:mobile_factory/providers/products_provider.dart';
import 'package:mobile_factory/widgets/product_widget_item.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchController = TextEditingController();
  ProductsProvider provider;
  List<Product> products = [];

  void filterSearchResults(String query) {
    products = provider.products;
    List<Product> filteredProducts = [];
    if (query.isNotEmpty) {
      products.forEach((product) {
        if (product.name.toLowerCase().contains(query.toLowerCase())) {
          filteredProducts.add(product);
        }
      });
      setState(() {
        products.clear();
        products.addAll(filteredProducts);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: defaultPadding,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Theme.of(context).cardColor,
                      ),
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search...",
                        ),
                        onSubmitted: (value) => filterSearchResults(value),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.search,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            GridView.builder(
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
          ],
        ),
      ),
    );
  }
}
