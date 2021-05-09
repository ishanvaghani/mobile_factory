import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/pages/products/products_page.dart';
import 'package:mobile_factory/providers/brands_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BrandsWidget extends StatelessWidget {
  final bool isLoading;
  BrandsWidget({this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BrandsProvider>(context);
    final brands = provider.brands;
    return Container(
      height: 120.0,
      child: isLoading
          ? ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              padding: defaultPadding,
              itemCount: 4,
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(
                width: 8.0,
              ),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: shimmerBaseColor,
                  highlightColor: shimmerHighlightColor,
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: shimmerBoxColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                );
              },
            )
          : ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: defaultPadding,
              itemCount: brands.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(
                width: 8.0,
              ),
              itemBuilder: (context, index) {
                final brand = brands[index];
                return Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        CachedNetworkImage(
                          imageUrl: brand.imgUrl,
                          width: 150.0,
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
                                  builder: (context) => ProductsPage(
                                    brandName: brand.name,
                                    isBrand: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
