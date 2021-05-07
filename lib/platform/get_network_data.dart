import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/tider_profile_model.dart';
import '../screens/swipe/bloc/tinder_states.dart';

abstract class GetNetworkData {
  Future<TinderProfileModel> getTinderProfile();
}

class TinderNetworkData implements GetNetworkData {
  //
  static const _baseUrl = 'https://randomuser.me/api/0.4/?randomapi';

  @override
  Future<TinderProfileModel> getTinderProfile() async {
    try {
      var uri = Uri.parse(_baseUrl);
      var response = await http.get(uri);
      final responseJson = jsonDecode(response.body);
      return TinderProfileModel.fromJson(responseJson);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
