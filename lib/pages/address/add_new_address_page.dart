import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/models/address.dart';
import 'package:mobile_factory/providers/address_provider.dart';
import 'package:provider/provider.dart';

class AddNewAddress extends StatefulWidget {
  final Address address;
  AddNewAddress({this.address});

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final _formKey = GlobalKey<FormState>();

  bool isEnabled = true;
  bool isLoading = false;

  String firstName;
  String lastName;
  String address1;
  String address2;
  String city;
  String state;
  String zipcode;
  String country;

  @override
  void initState() {
    if (widget.address != null) {
      firstName = widget.address.firstName;
      lastName = widget.address.lastName;
      address1 = widget.address.address1;
      address2 = widget.address.address2;
      city = widget.address.city;
      state = widget.address.state;
      zipcode = widget.address.zipcode;
      country = widget.address.country;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AddressProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.address == null ? 'Add New Address' : 'Update Address'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: defaultPadding,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "First Name",
                  border: UnderlineInputBorder(),
                ),
                initialValue: firstName,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Value should not be empty";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  firstName = newValue;
                },
                enabled: isEnabled,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Last Name",
                  border: UnderlineInputBorder(),
                ),
                initialValue: lastName,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Value should not be empty";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  lastName = newValue;
                },
                enabled: isEnabled,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Street Address",
                  border: UnderlineInputBorder(),
                ),
                initialValue: address1,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Value should not be empty";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  address1 = newValue;
                },
                enabled: isEnabled,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Apt / Suite / Other",
                  border: UnderlineInputBorder(),
                ),
                initialValue: address2,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Value should not be empty";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  address2 = newValue;
                },
                enabled: isEnabled,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "City",
                        border: UnderlineInputBorder(),
                      ),
                      initialValue: city,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Value should not be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        city = newValue;
                      },
                      enabled: isEnabled,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "State",
                        border: UnderlineInputBorder(),
                      ),
                      initialValue: state,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Value should not be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        state = newValue;
                      },
                      enabled: isEnabled,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Country",
                        border: UnderlineInputBorder(),
                      ),
                      initialValue: country,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Value should not be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        country = newValue;
                      },
                      enabled: isEnabled,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Zipcode",
                        border: UnderlineInputBorder(),
                      ),
                      initialValue: zipcode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Value should not be empty";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        zipcode = newValue;
                      },
                      enabled: isEnabled,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                setState(() {
                                  isLoading = true;
                                  isEnabled = false;
                                });
                                if (widget.address == null) {
                                  await provider
                                      .addAddress(
                                        Address(
                                          id: DateTime.now().toIso8601String(),
                                          firstName: firstName,
                                          lastName: lastName,
                                          address1: address1,
                                          address2: address2,
                                          city: city,
                                          state: state,
                                          zipcode: zipcode,
                                          country: country,
                                        ),
                                      )
                                      .then(
                                        (_) => provider.fetchAddresses().then(
                                              (value) => Navigator.pop(context),
                                            ),
                                      );
                                }
                              }
                              if (widget.address != null) {
                                await provider
                                    .updateAddress(
                                      Address(
                                        id: widget.address.id,
                                        firstName: firstName,
                                        lastName: lastName,
                                        address1: address1,
                                        address2: address2,
                                        city: city,
                                        state: state,
                                        zipcode: zipcode,
                                        country: country,
                                      ),
                                    )
                                    .then(
                                      (_) => provider.fetchAddresses().then(
                                            (value) => Navigator.pop(context),
                                          ),
                                    );
                              }
                            },
                            child: Text(widget.address == null
                                ? 'ADD ADDRESS'
                                : 'UPDATE ADDRESS'),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
