import 'package:flutter/material.dart';
import 'package:mobile_factory/pages/cart/cart_page.dart';
import 'package:mobile_factory/providers/carts_provider.dart';
import 'package:provider/provider.dart';

class CartIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartsProvider>(context);
    final cartLength = provider.cartLength;
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CartPage(),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.shopping_cart,
              size: 30.0,
            ),
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Container(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  '$cartLength',
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
