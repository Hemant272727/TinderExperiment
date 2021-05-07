import 'package:equatable/equatable.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:tinder_task_2/models/tider_profile_model.dart';

abstract class TinderState extends Equatable {
  @override
  List<Object> get props => [];
}

class TinderInitState extends TinderState {}

class TinderLoading extends TinderState {}

class TinderProfileLoaded extends TinderState {
  final List<SwipeItem> swipeItems;
  TinderProfileLoaded({this.swipeItems});
}

class TinderListError extends TinderState {
  final error;
  TinderListError({this.error});
}
