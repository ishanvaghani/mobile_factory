import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_factory/helper/firebase_constant.dart';
import 'package:mobile_factory/models/user_data.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn(
      {@required String email, @required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String password,
    @required String phoneNo,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await saveUserInfo(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phoneNo: phoneNo,
      );
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> saveUserInfo({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String password,
    @required String phoneNo,
  }) async {
    try {
      Map<String, dynamic> userData = UserData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phoneNo: phoneNo,
      ).toMap();
      userRef.doc(currentUser.uid).set(userData);
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
