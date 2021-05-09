import 'package:flutter/material.dart';
import 'package:mobile_factory/pages/home/widgets/brands_widget.dart';
import 'package:mobile_factory/pages/search/search_page.dart';
import 'package:mobile_factory/providers/address_provider.dart';
import 'package:mobile_factory/providers/brands_provider.dart';
import 'package:mobile_factory/providers/carts_provider.dart';
import 'package:mobile_factory/providers/connectivity_provider.dart';
import 'package:mobile_factory/providers/orders_provider.dart';
import 'package:mobile_factory/providers/products_provider.dart';
import 'package:mobile_factory/providers/user_provider.dart';
import 'package:mobile_factory/widgets/cart_icon_widget.dart';
import 'package:mobile_factory/widgets/navigation_drawer_widget.dart';
import 'package:mobile_factory/widgets/no_internet_widget.dart';
import 'package:provider/provider.dart';

import 'widgets/collection_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isInit = true;
  var _isLoading = true;

  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<UserProvider>(context).fetchAndSetUser();
      Provider.of<BrandsProvider>(context).fetchAndSetBrands();
      Provider.of<CartsProvider>(context).fetchCart();
      Provider.of<ProductsProvider>(context).fetchAndSetFavoriteProducts();
      Provider.of<AddressProvider>(context).fetchAddresses();
      Provider.of<OrdersProvider>(context).fetchAndSetOrders();
      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return buildUI();
  }

  Widget buildUI() {
    return Consumer<ConnectivityProvider>(
      builder: (context, model, child) {
        if (model.isOnline != null) {
          return model.isOnline
              ? homeWidget()
              : NoInternetWidget(
                  title: "Mobile Factory",
                );
        }
        return homeWidget();
      },
    );
  }

  Widget homeWidget() {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Mobile Factory"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
          ),
          SizedBox(
            width: 8.0,
          ),
          CartIconWidget(),
        ],
      ),
      body: _isLoading
          ? SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandsWidget(
                    isLoading: true,
                  ),
                  CollectionWidget(
                    isLoading: true,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  CollectionWidget(
                    isLoading: true,
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrandsWidget(),
                  CollectionWidget(collectionName: "New Arrival"),
                  SizedBox(
                    height: 10.0,
                  ),
                  CollectionWidget(collectionName: "Sale"),
                ],
              ),
            ),
    );
  }
}
