part of 'community_tab_bloc.dart';

abstract class CommunityTabEvent extends Equatable {
  const CommunityTabEvent();
}

class TabChangedEvent extends CommunityTabEvent {
  final int tabIndex;

  const TabChangedEvent(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
