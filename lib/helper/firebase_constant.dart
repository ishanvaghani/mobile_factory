import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final currentUser = FirebaseAuth.instance.currentUser;
final userRef = FirebaseFirestore.instance.collection('Users');
final productRef = FirebaseFirestore.instance.collection('Products');
final brandRef = FirebaseFirestore.instance.collection('Brands');
final favoritesProductRef = FirebaseFirestore.instance
    .collection('User Favorites')
    .doc(currentUser.uid);
final cartRef =
    FirebaseFirestore.instance.collection('Carts').doc(currentUser.uid);
final ordersRef = FirebaseFirestore.instance
    .collection('Users')
    .doc(currentUser.uid)
    .collection("Orders");
final addressRef = FirebaseFirestore.instance
    .collection('Users')
    .doc(currentUser.uid)
    .collection("Address");
