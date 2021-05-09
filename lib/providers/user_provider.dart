import 'package:flutter/cupertino.dart';
import 'package:mobile_factory/helper/firebase_constant.dart';
import 'package:mobile_factory/models/user_data.dart';

class UserProvider with ChangeNotifier {
  UserData _user;

  UserData get user => _user;

  Future<void> fetchAndSetUser() async {
    UserData user;
    await userRef.doc(currentUser.uid).get().then((documentSnapshot) {
      user = UserData.fromMap(documentSnapshot.data());
    });
    _user = user;
    notifyListeners();
  }

  Future<void> updateUser(
      String firstName, String lastName, String phoneNo) async {
    UserData userUpdate = UserData(
      firstName: firstName,
      lastName: lastName,
      email: user.email,
      password: user.password,
      phoneNo: phoneNo,
    );
    await userRef.doc(currentUser.uid).set(userUpdate.toMap());
    _user = userUpdate;
    notifyListeners();
  }
}
