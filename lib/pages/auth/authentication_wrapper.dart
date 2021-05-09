import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_factory/pages/auth/auth_page.dart';
import 'package:mobile_factory/pages/home/home_page.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if(firebaseUser == null) {
      return AuthPage();
    }
    return HomePage();
  }
}
