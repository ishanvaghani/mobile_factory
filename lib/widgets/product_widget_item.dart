import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/models/product.dart';
import 'package:mobile_factory/pages/product_details/product_details_page.dart';
import 'package:shimmer/shimmer.dart';

class ProductWidgetItem extends StatelessWidget {
  final Product product;
  final bool isLoading;
  ProductWidgetItem({this.product, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: shimmerBaseColor,
                    highlightColor: shimmerHighlightColor,
                    child: Container(
                      decoration: BoxDecoration(
                        color: shimmerBoxColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Shimmer.fromColors(
                  baseColor: shimmerBaseColor,
                  highlightColor: shimmerHighlightColor,
                  child: Container(
                    height: 25.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: shimmerBoxColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ],
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 0.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: product.imgUrl,
                                    height: 200.0,
                                    width: 200.0,
                                    placeholder: (context, url) => Image.asset(
                                      'assets/images/placeholder.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  Positioned.fill(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsPage(
                                                    productId: product.id),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: product.featured != "none"
                                    ? const EdgeInsets.all(4.0)
                                    : EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: Theme.of(context).accentColor,
                                ),
                                child: Text(product.featured != "none"
                                    ? product.featured
                                    : ""),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: productTitleStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
