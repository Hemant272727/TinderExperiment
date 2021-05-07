import 'package:tinder_task_2/constants/string_constants.dart';
import 'package:tinder_task_2/models/tider_profile_model.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkUtils {
  Future<TinderProfileModel> getTinderProfile() async {
    final requestURL = Uri.parse(StringConst.endPoint);
    final response = await http.get(requestURL);
    final responseJson = jsonDecode(response.body);
    return TinderProfileModel.fromJson(responseJson);
  }
}
