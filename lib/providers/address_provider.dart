import 'package:flutter/cupertino.dart';
import 'package:mobile_factory/helper/firebase_constant.dart';
import 'package:mobile_factory/models/address.dart';

class AddressProvider with ChangeNotifier {
  List<Address> _addresses = [];

  List<Address> get addresses => _addresses;

  Future<void> fetchAddresses() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addressRef.snapshots().listen((querySnapshot) {
        _addresses.clear();
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.forEach((address) {
            _addresses.clear();
            _addresses.add(Address.fromMap(address.data()));
          });
        }
      });
      notifyListeners();
    });
  }

  Address findById(String addressId) {
    return _addresses.firstWhere((address) => address.id == addressId);
  }

  Future<void> addAddress(Address address) async {
    await addressRef.doc(address.id).set(address.toMap());
  }

  Future<void> updateAddress(Address address) async {
    await addressRef.doc(address.id).update(address.toMap());
  }
}
