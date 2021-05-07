import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:tinder_task_2/widgets/loading_widget.dart';
import '../../../widgets/icon_button_widget.dart';
import '../../../widgets/text_widget.dart';
import '../../../widgets/swipe_card.dart';

import '../bloc/tinder_bloc.dart';
import '../bloc/tinder_events.dart';
import '../bloc/tinder_states.dart';

class TinderPage extends StatefulWidget {
  @override
  _TinderPageState createState() => _TinderPageState();
}

class _TinderPageState extends State<TinderPage> {
  SharedPreferences _sharedProfile;
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine _matchEngine;
  int _selectedIndex = 1;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTinder();
  }

  _loadTinder() async {
    context.read<TinderBloc>().add(TinderEvents.fetchFirstTinder);
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
      body: BlocBuilder<TinderBloc, TinderState>(
        builder: (BuildContext context, TinderState state) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Stack(
              children: [
                Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                ),
                if (state is TinderProfileLoaded)
                  SwipeCard(
                    buttonList: buttonList,
                    matchEngine: MatchEngine(swipeItems: state.swipeItems),
                    selectedIndex: _selectedIndex,
                    swipeItems: state.swipeItems,
                  ),
                if (state is TinderLoading) LoadingWidget(),
                if (state is TinderListError) TextWidget(text: state.error)
              ],
            ),
          );
        },
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
