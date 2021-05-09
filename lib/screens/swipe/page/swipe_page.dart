import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:tinder_task_2/constants/font_constants.dart';
import 'package:tinder_task_2/constants/string_constants.dart';
import 'package:tinder_task_2/utils/service_util.dart';
import 'package:tinder_task_2/widgets/icon_button_widget.dart';
import 'package:tinder_task_2/widgets/swipe_card_widget.dart';

import '../../../models/tider_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/network_utils.dart';

class SwipePage extends StatefulWidget {
  @override
  _SwipePageState createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  SharedPreferences _sharedProfile;
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine _matchEngine;
  int _selectedIndex = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _matchEngine = MatchEngine(swipeItems: _swipeItems);
    });
    getTinderProfileData();
  }

  addToSwipeItems(TinderProfileModel value) {
    _swipeItems.add(
      SwipeItem(
        content: value,
        likeAction: getNewSaveProfileData,
        nopeAction: getNewProfileData,
        superlikeAction: getNewSaveProfileData,
      ),
    );
  }

  getNewProfileData() async {
    NetworkUtils().getTinderProfile().then((value) {
      addToSwipeItems(value);
    });
  }

  getNewSaveProfileData() async {
    NetworkUtils().getTinderProfile().then((value) {
      addToSwipeItems(value);
      if (_sharedProfile.getStringList(StringConst.swipeCacheKey) != null) {
        final dataList =
            _sharedProfile.getStringList(StringConst.swipeCacheKey);
        dataList.add(jsonEncode(value));
        print(dataList.length);
        _sharedProfile.setStringList(StringConst.swipeCacheKey, dataList);
      } else {
        final userData = jsonEncode(value);
        _sharedProfile.setStringList(StringConst.swipeCacheKey, [userData]);
      }
    });
  }

  getStoredProfileData() async {
    if (_sharedProfile.getStringList(StringConst.swipeCacheKey) != null) {
      final dataList = _sharedProfile.getStringList(StringConst.swipeCacheKey);
      for (var i = 0; i < dataList.length; i++) {
        addToSwipeItems(TinderProfileModel.fromJson(jsonDecode(dataList[i])));
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  getTinderProfileData() async {
    _sharedProfile = await SharedPreferences.getInstance();
    setState(() {
      _swipeItems.clear();
      _isLoading = true;
    });
    if (await ServiceUtil.checkInternetConnection()) {
      NetworkUtils().getTinderProfile().then((value) {
        addToSwipeItems(value);
        NetworkUtils().getTinderProfile().then((value) {
          addToSwipeItems(value);
          NetworkUtils().getTinderProfile().then((value) {
            addToSwipeItems(value);
            NetworkUtils().getTinderProfile().then((value) {
              addToSwipeItems(value);
              setState(() {
                _isLoading = false;
              });
            });
          });
        });
      });
    } else {
      getStoredProfileData();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttonList = [];
    for (var i = 0; i < 5; i++) {
      buttonList.add(IconButtunWidget(
        icon: getIcon(i),
        onPressed: () {
          setState(() {
            _selectedIndex = i + 1;
          });
        },
        index: _selectedIndex,
        value: i + 1,
      ));
    }

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
            ),
            Align(
              alignment: Alignment.center,
              child: _isLoading || _swipeItems.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SwipeCardWidget(
                      buttonList: buttonList,
                      matchEngine: _matchEngine,
                      selectedIndex: _selectedIndex,
                      swipeItems: _swipeItems,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  IconData getIcon(int index) {
    if (index == 0) {
      return CupertinoIcons.person;
    } else if (index == 1) {
      return CupertinoIcons.calendar;
    } else if (index == 2) {
      return CupertinoIcons.map;
    } else if (index == 3) {
      return CupertinoIcons.phone;
    } else if (index == 4) {
      return CupertinoIcons.lock;
    } else {
      return CupertinoIcons.person;
    }
  }
}
