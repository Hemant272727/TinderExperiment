import 'package:connectivity/connectivity.dart';
import 'package:tinder_task_2/constants/string_constants.dart';

class ServiceUtil {
  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print(StringConst.onlineString);
      return true;
    } else {
      print(StringConst.offlineString);
      return false;
    }
  }
}
