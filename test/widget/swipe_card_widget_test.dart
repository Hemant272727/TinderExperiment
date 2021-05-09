import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:tinder_task_2/widgets/swipe_card_widget.dart';

main() {
  SwipeCardWidget localSwipeCardWidget;
  List<Widget> localButtonList;
  MatchEngine localMatchEngine;
  int localSelectedIndex;
  List<SwipeItem> localSwipeItems;

  setUp(() {
    localButtonList = [];
    localMatchEngine = MatchEngine();
    localSelectedIndex = 0;
    localSwipeItems = [];

    localSwipeCardWidget = SwipeCardWidget(
      buttonList: localButtonList,
      matchEngine: localMatchEngine,
      selectedIndex: localSelectedIndex,
      swipeItems: localSwipeItems,
    );
  });

  test('Header data should be according to input', () {
    String result = localSwipeCardWidget.getHeaderString(1);
    expect(result, 'My name is');
  });

  test('Details data should be according to input', () {
    String result = localSwipeCardWidget.getDetailString(6, 0);
    expect(result, '');
  });
}
