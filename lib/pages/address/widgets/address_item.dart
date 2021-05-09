import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/pages/address/add_new_address_page.dart';
import 'package:mobile_factory/providers/address_provider.dart';
import 'package:provider/provider.dart';

class AddressItem extends StatelessWidget {
  final addressId;
  const AddressItem({this.addressId});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddressProvider>(context);
    final address = provider.findById(addressId);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.location_on,
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${address.firstName} ${address.lastName}',
                style: addressTitleStyle,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                '${address.address1}, ${address.address2}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: addressBodyStyle,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                '${address.city}',
                style: addressBodyStyle,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddNewAddress(
                  address: address,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
