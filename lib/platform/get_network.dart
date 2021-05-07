import 'package:data_connection_checker/data_connection_checker.dart';

abstract class GetNetwork {
  Future<bool> get isConnected;
}

class NetworkData implements GetNetwork {
  @override
  Future<bool> get isConnected => DataConnectionChecker().hasConnection;
}
