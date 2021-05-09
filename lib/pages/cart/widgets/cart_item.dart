import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/models/product.dart';
import 'package:mobile_factory/providers/carts_provider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final Product product;
  CartItem({@required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartsProvider>(context);
    return Row(
      children: [
        Container(
          height: 80.0,
          width: 80.0,
          child: CachedNetworkImage(
            imageUrl: product.imgUrl,
            placeholder: (context, url) => Image.asset(
              'assets/images/placeholder.jpg',
              fit: BoxFit.cover,
            ),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: cartProductTitleStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹ ${product.price}',
                    style: cartProductBodyStyle,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => provider.removeProduct(product),
                      ),
                      Text(product.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () =>
                            provider.incrementProductQuantity(product),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
