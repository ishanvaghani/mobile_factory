import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_factory/pages/auth/authentication_service.dart';
import 'package:mobile_factory/pages/splash/splash_page.dart';
import 'package:mobile_factory/providers/address_provider.dart';
import 'package:mobile_factory/providers/brands_provider.dart';
import 'package:mobile_factory/providers/carts_provider.dart';
import 'package:mobile_factory/providers/connectivity_provider.dart';
import 'package:mobile_factory/providers/products_provider.dart';
import 'package:mobile_factory/providers/orders_provider.dart';
import 'package:mobile_factory/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'constants/MyTheme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider(
          create: (_) => BrandsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AddressProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ConnectivityProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Mobile Factory',
        debugShowCheckedModeBanner: false,  
        themeMode: ThemeMode.system,
        darkTheme: MyTheme.darkTheme(context),
        theme: MyTheme.lightTheme(context),
        home: SplashPage(),
      ),
    );
  }
}
