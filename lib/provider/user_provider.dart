import 'package:flutter/material.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/resources/resources.dart';

class UserProvider with ChangeNotifier {

User _user;
AuthMethods _repository = AuthMethods();

User get getUser=>_user;

Future<void> refreshUser()async{
  User user = await _repository.getUserDetails();
  _user = user;
  notifyListeners();
}

}