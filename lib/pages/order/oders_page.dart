import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/pages/order/widget/order_item.dart';
import 'package:mobile_factory/providers/orders_provider.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrdersProvider>(context);
    final orders = provider.orders;
    return Scaffold(
      appBar: AppBar(title: Text("Orders")),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: defaultPadding,
        itemCount: orders.length,
        shrinkWrap: true,
        separatorBuilder: (context, index) => Divider(
          height: 8.0,
        ),
        itemBuilder: (context, index) {
          final order = orders[index];
          return OrderItem(order: order);
        },
      ),
    );
  }
}
