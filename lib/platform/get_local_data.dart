import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/tider_profile_model.dart';

abstract class GetLocalData {
  Future<List<String>> getLocalStringList();
  Future<bool> setLocalStringList(TinderProfileModel item);
}

class TinderLocalData implements GetLocalData {
  static const String swipeCacheKey = 'CACHED_SWIPED_DATA';
  SharedPreferences preferences;

  @override
  Future<List<String>> getLocalStringList() async {
    preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(swipeCacheKey);
  }

  @override
  Future<bool> setLocalStringList(TinderProfileModel item) async {
    preferences = await SharedPreferences.getInstance();

    if (preferences.getStringList(swipeCacheKey) != null) {
      final dataList = preferences.getStringList(swipeCacheKey);
      dataList.add(jsonEncode(item));
      print('Saving data if part');
      print(dataList.length);
      return preferences.setStringList(swipeCacheKey, dataList);
    } else {
      final userData = jsonEncode(item);
      print('Saving data else part');
      return preferences.setStringList(swipeCacheKey, [userData]);
    }
  }
}
