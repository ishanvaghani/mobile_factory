import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication_service.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController =
      new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _phoneNoController = new TextEditingController();

  String email;
  String password;
  String firstName;
  String lastName;
  String phoneNo;

  bool isAuthenticating = false;
  bool isEnabled = true;
  bool isSignIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isSignIn)
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
                    if (!isSignIn)
                      SizedBox(
                        height: 20.0,
                      ),
                    if (!isSignIn)
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
                    if (!isSignIn)
                      SizedBox(
                        height: 20.0,
                      ),
                    if (!isSignIn)
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
                        textInputAction: TextInputAction.next,
                      ),
                    if (!isSignIn)
                      SizedBox(
                        height: 20.0,
                      ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        labelText: "Email",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        email = newValue;
                      },
                      enabled: isEnabled,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.length < 6) {
                          return "Password is short";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        password = newValue;
                      },
                      enabled: isEnabled,
                      obscureText: true,
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
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        isAuthenticating = true;
                                        isEnabled = false;
                                      });
                                      _formKey.currentState.save();
                                      String response = isSignIn
                                          ? await context
                                              .read<AuthenticationService>()
                                              .signIn(
                                                  email: email,
                                                  password: password)
                                          : await context
                                              .read<AuthenticationService>()
                                              .signUp(
                                                firstName: firstName,
                                                lastName: lastName,
                                                email: email,
                                                password: password,
                                                phoneNo: phoneNo,
                                              );
                                      setState(() {
                                        isAuthenticating = false;
                                        isEnabled = true;
                                      });

                                      if (response != "Success") {
                                        final snackBar =
                                            SnackBar(content: Text(response));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    }
                                  },
                                  child: Text(isSignIn ? "Sign In" : "Sign Up"),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 30.0,
                    ),
                    if (!isAuthenticating)
                      InkWell(
                        onTap: () {
                          setState(() {
                            isSignIn = !isSignIn;
                            _firstNameController.clear();
                            _lastNameController.clear();
                            _emailController.clear();
                            _passwordController.clear();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            isSignIn
                                ? "Create an account?"
                                : "Already have an account?",
                            style: TextStyle(
                              color: Colors.purpleAccent,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
