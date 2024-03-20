part of 'layout_screen_bloc.dart';

abstract class ContainerEvent {}

class ExpandContainer extends ContainerEvent {}

class ShrinkContainer extends ContainerEvent {}

class ComboES extends ContainerEvent {}

abstract class NextScreenPageEvent {}

class NextScreenTabBarEvent extends NextScreenPageEvent {}

class TabbarChangeColorEvent extends NextScreenPageEvent {}

abstract class MusicEvent {}

class TogglePlayPauseEvent extends MusicEvent {}

abstract class ExploreTabEvent {}

class ListItemTappedEvent extends ExploreTabEvent {
  final String uri;

  ListItemTappedEvent(this.uri);
}