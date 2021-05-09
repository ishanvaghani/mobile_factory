import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/pages/address/add_new_address_page.dart';
import 'package:mobile_factory/pages/address/widgets/address_item.dart';
import 'package:mobile_factory/providers/address_provider.dart';
import 'package:provider/provider.dart';

class AddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddressProvider>(context);
    final addresses = provider.addresses;
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              padding: defaultPadding,
              itemCount: addresses.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => Column(
                children: [
                  Divider(
                    height: 8.0,
                  ),
                ],
              ),
              itemBuilder: (context, index) {
                final address = addresses[index];
                return AddressItem(
                  addressId: address.id,
                );
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: defaultPadding,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddNewAddress(),
                        ),
                      );
                    },
                    child: Text('ADD NEW ADDRESS'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
