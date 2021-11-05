import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'community_tab_event.dart';
part 'community_tab_state.dart';

class CommunityTabBloc extends Bloc<CommunityTabEvent, CommunityTabState> {
  final TabController tabController;
  CommunityTabBloc(this.tabController) : super(CommunityTabFeedState()) {
    on<CommunityTabEvent>((event, emit) {
      if (event is TabChangedEvent) {
        tabController.animateTo(event.tabIndex);
      }
    });
  }
}
