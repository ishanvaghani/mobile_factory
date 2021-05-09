import 'package:flutter/material.dart';
import 'package:mobile_factory/helper/firebase_constant.dart';
import 'package:mobile_factory/models/order.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<void> fetchAndSetOrders() async {
    _orders.clear();
    ordersRef
        .orderBy('id', descending: true)
        .snapshots()
        .listen((documentSnapshot) {
      _orders.clear();
      documentSnapshot.docs.forEach((order) {
        _orders.add(Order.fromMap(order.data()));
      });
    });
  }

  Future<void> placeOrder(Order order) async {
    await ordersRef.doc(order.id).set(order.toMap());
  }
}
