import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/pages/products/products_page.dart';
import 'package:mobile_factory/providers/products_provider.dart';
import 'package:mobile_factory/widgets/product_widget_item.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CollectionWidget extends StatelessWidget {
  final bool isLoading;
  final String collectionName;
  CollectionWidget({this.collectionName, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductsProvider>(context);
    var products = provider.selectedCollectionProducts(collectionName);
    return Container(
      padding: defaultPadding,
      child: isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: shimmerBaseColor,
                  highlightColor: shimmerHighlightColor,
                  child: Container(
                    height: 30.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                      color: shimmerBoxColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                GridView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
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
                ),
                SizedBox(
                  height: 10.0,
                ),
                Shimmer.fromColors(
                  baseColor: shimmerBaseColor,
                  highlightColor: shimmerHighlightColor,
                  child: Container(
                    height: 20.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: shimmerBoxColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  collectionName,
                  style: collectionTitleStyle,
                ),
                SizedBox(
                  height: 10.0,
                ),
                GridView.builder(
                  itemCount: products.length > 4 ? 4 : products.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    return ProductWidgetItem(
                      product: products[index],
                    );
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductsPage(
                        collectionName: collectionName,
                        isBrand: false,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: defaultPadding,
                    child: Text(
                      'View All',
                      style: collectionBodyStyle,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
