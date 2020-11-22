import 'package:flutter/material.dart';
import 'package:skype_clone/models/log.dart';
import 'package:skype_clone/resources/localdb/repository/log_repository.dart';
import 'package:skype_clone/utilities/universal_variables.dart';

class LogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: Center(
        child: FlatButton(onPressed: (){
          LogRepository.init(isHive: true);
          LogRepository.addLogs(Log());
        }, child: Text("Bas Benee")),
      ),
    );
  }
}