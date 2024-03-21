part of 'layout_screen_bloc.dart';

abstract class ContainerEvent {}

class ExpandContainer extends ContainerEvent {}

class ShrinkContainer extends ContainerEvent {}

abstract class NextScreenPageEvent {}

class NextScreenTabBarEvent extends NextScreenPageEvent {}

class TabbarChangeColorEvent extends NextScreenPageEvent {}

abstract class MusicEvent {}

class TogglePlayPauseEvent extends MusicEvent {}

///////////////////////

abstract class ExploreTabEvent {}

class ExploreTabSelectedEvent extends ExploreTabEvent {
  final String selectedUri;

  ExploreTabSelectedEvent(this.selectedUri);
}

class ClickPlayPauseMusicEvent extends ExploreTabEvent {}

class OpenPlayNowScreenEvent extends ExploreTabEvent{}

class ClosePlayNowScreenEvent extends ExploreTabEvent{}

class PositionEvent extends ExploreTabEvent {}

class DurationEvent extends ExploreTabEvent {}





