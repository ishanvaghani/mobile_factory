import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/models/product.dart';
import 'package:mobile_factory/providers/carts_provider.dart';
import 'package:mobile_factory/providers/products_provider.dart';
import 'package:mobile_factory/widgets/cart_icon_widget.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;
  ProductDetailsPage({@required this.productId});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _scale;
  bool _isFavorite = false;
  Product product;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final provider = Provider.of<ProductsProvider>(context);
    product = provider.findById(widget.productId);
    setState(() {
      _isFavorite = provider.favoriteProducts.contains(product);
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _animate() async {
    await _controller.forward();
    await _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    final cartsProvider = Provider.of<CartsProvider>(context);
    _scale = 1 - _controller.value;
    return Scaffold(
      appBar: AppBar(
        actions: [
          CartIconWidget(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.2,
                  child: CachedNetworkImage(
                    imageUrl: product.imgUrl,
                    placeholder: (context, url) => Image.asset(
                      'assets/images/placeholder.jpg',
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10.0,
                  right: 10.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        provider.toggleFavoriteStatus(_isFavorite, product);
                      },
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_outline,
                        size: 30.0,
                      ),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: productDetailsTitleStyle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '₹ ${product.price}',
                    style: productDetailsPriceStyle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  AddToCartButton(
                    scale: _scale,
                    product: product,
                    cartsProvider: cartsProvider,
                    animate: _animate,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Description',
                    style: productDetailsPriceStyle,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    product.description,
                    style: productDetailsBodyStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddToCartButton extends StatefulWidget {
  final scale;
  final product;
  final cartsProvider;
  final animate;

  const AddToCartButton(
      {this.scale, this.product, this.cartsProvider, this.animate});

  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  bool _isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scale,
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: widget.product.quantity == 0
                  ? null
                  : () {
                      widget.cartsProvider.addToCart(widget.product);
                      widget.animate();
                      setState(() {
                        _isAdded = true;
                      });
                    },
              child: widget.product.quantity == 0
                  ? Text('OUT OF STOCK')
                  : _isAdded
                      ? Text('ADDED!')
                      : Text('ADD TO CART'),
            ),
          ),
        ],
      ),
    );
  }
}
