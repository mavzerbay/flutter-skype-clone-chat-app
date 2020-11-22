import 'package:skype_clone/models/log.dart';
import 'package:skype_clone/resources/localdb/interface/log_interface.dart';

class HiveMethods implements LogInterface {
  @override
  addLogs(Log log) {
    print("add hive db");
    return null;
  }

  @override
  close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  deleteLog(int logId) {
    // TODO: implement deleteLog
    throw UnimplementedError();
  }

  @override
  Future<List<Log>> getLogs() {
    // TODO: implement getLogs
    throw UnimplementedError();
  }

  @override
  init() {
    print("initiliazed hive");
    return null;
  }
}
