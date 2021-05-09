import 'package:flutter/material.dart';
import 'package:mobile_factory/constants/style.dart';

class NoInternetWidget extends StatelessWidget {
  final String title;
  const NoInternetWidget({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: defaultPadding,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.wifi_off,
                size: 40.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Oops! We lost you there',
                style: productDetailsTitleStyle,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Please check your network connection and try again',
                style: addressBodyStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
