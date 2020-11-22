import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Im;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skype_clone/enum/user_state.dart';

class Utils {
  static String getUserName(String email) {
    return "live:${email.split("@")[0]}";
  }

  static String getInitials(String name) {
    List<String> nameSplit = name.split(" ");
    String firstNameInitials = nameSplit[0][0];
    String lastNameInitials = nameSplit[1][0];
    return firstNameInitials + lastNameInitials;
  }

  static Future<File> pickImage({@required ImageSource source}) async {
    PickedFile file = await ImagePicker().getImage(
        source: source, maxWidth: 500, maxHeight: 500, imageQuality: 85);
    if (file == null) {
      return null;
    }
    File selectedImage = File(file.path);
    return compressImage(selectedImage);
  }

  static Future<File> compressImage(File imageToCompress) async {
    final tempDir = await getTemporaryDirectory();

    final path = tempDir.path;

    int random = Random().nextInt(1000);

    Im.Image image = Im.decodeImage(imageToCompress.readAsBytesSync());
    Im.copyResize(image, width: 500, height: 500);

    return File('$path/img_$random.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image, quality: 85));
  }

  static int stateToNum(UserState userState) {
    switch (userState) {
      case UserState.Offline:
        return 0;
      case UserState.Online:
        return 1;

      default:
        return 2;
    }
  }

  static UserState numtoState(int number) {
    switch (number) {
      case 0:
        return UserState.Offline;
      case 1:
        return UserState.Online;
      default:
        return UserState.Waiting;
    }
  }

  static String formatDateString(String dateString){
    DateTime dateTime = DateTime.parse(dateString);
    var formatter =DateFormat("dd/MM/yyyy");
    return formatter.format(dateTime);

  }
}
