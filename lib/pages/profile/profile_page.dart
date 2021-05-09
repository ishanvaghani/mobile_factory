import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';
import 'package:mobile_factory/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController =
      new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();
  final TextEditingController _phoneNoController = new TextEditingController();

  String firstName;
  String lastName;
  String phoneNo;

  bool isAuthenticating = false;
  bool isEnabled = false;

  Future<void> _updateDetails() async {
    setState(() {
      isAuthenticating = true;
    });
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await Provider.of<UserProvider>(context, listen: false)
          .updateUser(firstName, lastName, phoneNo)
          .then(
            (value) => setState(() {
              isAuthenticating = false;
            }),
          );
    }
  }

  void _edit() {
    setState(() {
      isEnabled = true;
    });
  }

  @override
  void initState() {
    final provider = Provider.of<UserProvider>(context, listen: false);
    final user = provider.user;
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _phoneNoController.text = user.phoneNo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: defaultPadding,
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      hintText: "Enter First Name",
                      labelText: "First Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.length < 3) {
                        return "First Name is short";
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
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      hintText: "Enter Last Name",
                      labelText: "Last Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.length < 3) {
                        return "Last Name is short";
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
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _phoneNoController,
                    decoration: InputDecoration(
                      hintText: "Enter Phone No",
                      labelText: "Phone No",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.length != 10) {
                        return "Phone no is not valid";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      phoneNo = newValue;
                    },
                    enabled: isEnabled,
                    keyboardType: TextInputType.name,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  isAuthenticating
                      ? CircularProgressIndicator()
                      : Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  isEnabled ? _updateDetails() : _edit();
                                },
                                child: Text(isEnabled ? 'UPDATE' : 'Edit'),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
