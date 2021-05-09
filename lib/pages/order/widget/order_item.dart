import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/models/order.dart';

class OrderItem extends StatefulWidget {
  final Order order;
  OrderItem({@required this.order});
  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(widget.order.id);
    DateFormat formatter = DateFormat('dd, MMMM yyyy');
    String dateTimeFormated = formatter.format(dateTime);
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 300,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '# ${widget.order.id}',
                      style: addressTitleStyle,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '₹ $dateTimeFormated',
                      style: addressBodyStyle,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      '₹ ${widget.order.amount}',
                      style: addressBodyStyle,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ],
          ),
          AnimatedContainer(
            duration: Duration(
              milliseconds: 300,
            ),
            height: _expanded ? widget.order.products.length * 80.0 : 0,
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.order.products.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(
                height: 5.0,
              ),
              itemBuilder: (context, index) {
                final product = widget.order.products[index];
                return Row(
                  children: [
                    Container(
                      height: 80.0,
                      width: 80.0,
                      child: CachedNetworkImage(
                        imageUrl: product.imgUrl,
                        placeholder: (context, url) => Image.asset(
                          'assets/images/placeholder.jpg',
                          fit: BoxFit.cover,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: cartProductTitleStyle,
                          ),
                          Text(
                            '₹ ${product.price}',
                            style: cartProductBodyStyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
