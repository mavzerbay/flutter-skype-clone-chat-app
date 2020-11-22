import 'package:flutter/material.dart';
import 'package:skype_clone/models/log.dart';
import 'package:skype_clone/resources/localdb/db/hive_methods.dart';

class LogRepository{
  static var dbObject;
  static bool isHive;

  static init({@required bool isHive}){
    dbObject = HiveMethods(); //isHive?HiveMethods():SqlLite();
    dbObject.init();
  }

  static addLogs(Log log)=>dbObject.addLogs(log);

  static deleteLog(int logId)=>dbObject.deleteLog(logId);

  static getLogs()=>dbObject.getLogs();

  static close()=>dbObject.close();
}