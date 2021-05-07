// event, state => new state => update UI.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:tinder_task_2/constants/string_constants.dart';
import 'package:tinder_task_2/models/tider_profile_model.dart';
import 'package:tinder_task_2/platform/exceptions.dart';
import 'package:tinder_task_2/platform/get_local_data.dart';
import 'package:tinder_task_2/platform/get_network.dart';
import 'package:tinder_task_2/platform/get_network_data.dart';
import 'package:tinder_task_2/screens/swipe/bloc/tinder_events.dart';
import 'package:tinder_task_2/screens/swipe/bloc/tinder_states.dart';

class TinderBloc extends Bloc<TinderEvents, TinderState> {
  final GetLocalData getLocalData;
  final GetNetworkData getNetworkData;
  final GetNetwork getNetwork;
  List<SwipeItem> swipeItems;

  TinderBloc({
    this.getNetworkData,
    this.getLocalData,
    this.getNetwork,
  }) : super(TinderInitState());

  @override
  Stream<TinderState> mapEventToState(TinderEvents event) async* {
    switch (event) {
      case TinderEvents.fetchFirstTinder:
        yield TinderLoading();
        try {
          if (await getNetwork.isConnected) {
            getNetworkData.getTinderProfile().then((value) async* {
              print(value);
              if (value != null) {
                print('Got Data');
                addToSwipeItems(value);
                yield TinderProfileLoaded(swipeItems: swipeItems);
              } else {
                print('No Got Data');
                yield TinderListError(
                  error: UnknownException('Unknown Error'),
                );
              }
            });
          } else {}
        } on SocketException {
          print('No Internet');
          yield TinderListError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          print('No Service Found');
          yield TinderListError(
            error: NoServiceFoundException('No Service Found'),
          );
        } on FormatException {
          print('Invalid Response format');
          yield TinderListError(
            error: InvalidFormatException('Invalid Response format'),
          );
        } catch (e) {
          print('Unknown Error');
          yield TinderListError(
            error: UnknownException('Unknown Error'),
          );
        }

        break;
    }
  }

  addToSwipeItems(TinderProfileModel value) {
    swipeItems.add(
      SwipeItem(
        content: value,
        likeAction: getNewSaveProfileData,
        nopeAction: getNewProfileData,
        superlikeAction: getNewSaveProfileData,
      ),
    );
  }

  getNewProfileData() async {
    getNetworkData.getTinderProfile().then((value) {
      addToSwipeItems(value);
    });
  }

  getNewSaveProfileData() async {
    getNetworkData.getTinderProfile().then((value) {
      addToSwipeItems(value);
      getLocalData.setLocalStringList(value);
    });
  }
}
