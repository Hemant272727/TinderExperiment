import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:tinder_task_2/constants/font_constants.dart';

class SwipeCardWidget extends StatelessWidget {
  final MatchEngine matchEngine;
  final int selectedIndex;
  final List<Widget> buttonList;
  final List<SwipeItem> swipeItems;
  const SwipeCardWidget(
      {@required this.matchEngine,
      @required this.selectedIndex,
      @required this.buttonList,
      @required this.swipeItems});

  @override
  Widget build(BuildContext context) {
    return SwipeCards(
      matchEngine: matchEngine,
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    color: Colors.grey[100],
                    width: double.maxFinite,
                    height: double.maxFinite,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: Column(
                        children: [
                          Expanded(child: Container()),
                          Text(
                            getHeaderString(selectedIndex),
                            style: TextStyle(
                              fontFamily: FontConst.lato,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            getDetailString(selectedIndex, index),
                            style: TextStyle(
                              fontFamily: FontConst.lato,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.03,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: buttonList,
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01),
                      child: Container(
                        padding: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[400],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                                MediaQuery.of(context).size.width * 0.2),
                          ),
                        ),
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.2,
                          backgroundImage: NetworkImage(swipeItems[index]
                              .content
                              .results[0]
                              .user
                              .picture),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
      onStackFinished: () {},
    );
  }

  String getHeaderString(int menuIndex) {
    if (menuIndex == 1) {
      return 'My name is';
    } else if (menuIndex == 2) {
      return 'My DOB is';
    } else if (menuIndex == 3) {
      return 'My address is';
    } else if (menuIndex == 4) {
      return 'My phone is';
    } else {
      return 'My password is';
    }
  }

  String getDetailString(int menuIndex, int index) {
    if (menuIndex == 1) {
      return '${swipeItems[index].content.results[0].user.name.first} ${swipeItems[index].content.results[0].user.name.last}';
    } else if (menuIndex == 2) {
      return '${swipeItems[index].content.results[0].user.dob}';
    } else if (menuIndex == 3) {
      return '${swipeItems[index].content.results[0].user.location.street}';
    } else if (menuIndex == 4) {
      return '${swipeItems[index].content.results[0].user.phone}';
    } else if (menuIndex == 5) {
      return '${swipeItems[index].content.results[0].user.password}';
    } else {
      return '';
    }
  }
}
