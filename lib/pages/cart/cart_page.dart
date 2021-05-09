import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/models/cart.dart';
import 'package:mobile_factory/models/order.dart';
import 'package:mobile_factory/models/product.dart';
import 'package:mobile_factory/pages/cart/widgets/cart_item.dart';
import 'package:mobile_factory/pages/home/home_page.dart';
import 'package:mobile_factory/providers/carts_provider.dart';
import 'package:mobile_factory/providers/orders_provider.dart';
import 'package:mobile_factory/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Razorpay _razorpay;
  CartsProvider _cartsProvider;
  OrdersProvider _ordersProvider;
  bool _isAbsorbing = false;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _payNow(String phoneNo, String email, Cart cart) {
    Product product = cart.products.first;
    var options = {
      'key': 'rzp_test_adTx3hIu6IdwCx',
      'amount': cart.total * 100,
      'name': product.name,
      'description': product.description.substring(0, 250),
      'timeout': 120,
      'prefill': {'contact': phoneNo, 'email': email}
    };
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    setState(() {
      _isAbsorbing = true;
    });
    Order order = Order(
      id: DateTime.now().toIso8601String(),
      amount: _cartsProvider.cart.total,
      products: _cartsProvider.cart.products,
    );
    _ordersProvider.placeOrder(order);
    _cartsProvider.clearCart();
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(pageBuilder: (_, __, ___) => HomePage()),
      (Route<dynamic> route) => false,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('fail');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    _cartsProvider = Provider.of<CartsProvider>(context);
    _ordersProvider = Provider.of<OrdersProvider>(context);

    final provider = Provider.of<CartsProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final products = provider.cart == null ? [] : provider.cart.products;
    final total = provider.cart == null ? 0 : provider.cart.total;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: total == 0
          ? AbsorbPointer(
              absorbing: _isAbsorbing,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      size: 30.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Cart is Empty!',
                      style: productDetailsTitleStyle,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('SHOP NOW'),
                    ),
                  ],
                ),
              ),
            )
          : AbsorbPointer(
              absorbing: _isAbsorbing,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: defaultPadding,
                      itemCount: products.length,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => Column(
                        children: [
                          Divider(
                            height: 8.0,
                          ),
                        ],
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return CartItem(product: product);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: defaultPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${products.length} items',
                          style: productDetailsTitleStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '₹ $total',
                          style: productDetailsPriceStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _payNow(
                                    userProvider.user.phoneNo,
                                    userProvider.user.email,
                                    provider.cart,
                                  );
                                },
                                child: Text('CHECKOUT'),
                              ),
                            ),
                          ],
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
