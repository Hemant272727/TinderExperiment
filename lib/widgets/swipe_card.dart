import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'swipe_card_widget.dart';

class SwipeCard extends StatelessWidget {
  final List<Widget> buttonList;
  final MatchEngine matchEngine;
  final int selectedIndex;
  final List<SwipeItem> swipeItems;

  SwipeCard({
    @required this.buttonList,
    @required this.matchEngine,
    @required this.selectedIndex,
    @required this.swipeItems,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SwipeCardWidget(
        buttonList: buttonList,
        matchEngine: matchEngine,
        selectedIndex: selectedIndex,
        swipeItems: swipeItems,
      ),
    );
  }
}
