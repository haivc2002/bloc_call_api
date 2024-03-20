part of 'layout_screen_bloc.dart';

class ContainerState {
  final bool isExpanded;
  final bool isCombo;

  ContainerState({this.isExpanded = false, this.isCombo = false});

  ContainerState copyWith({bool? isExpanded, bool? isCombo}) {
    return ContainerState(
      isExpanded: isExpanded ?? this.isExpanded,
      isCombo: isCombo ?? this.isCombo,
    );
  }
}

class NextScreenPageState {
  final PageController pageController;
  int selectedIndex;

  NextScreenPageState({this.selectedIndex = 0, required this.pageController});

  NextScreenPageState copyWith({int? selectedIndex, PageController? pageController}) {
    return NextScreenPageState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      pageController: pageController ?? this.pageController,
    );
  }
}

class MusicState {
  final String selectedUri;
  final AudioPlayer audioPlayer;
  final bool isPlaying;

  MusicState({
    required this.audioPlayer,
    required this.isPlaying,
    required this.selectedUri,
  });

  MusicState copyWith({
    AudioPlayer? audioPlayer,
    bool? isPlaying,
    String? selectedUri,
  }) {
    return MusicState(
      selectedUri: selectedUri ?? this.selectedUri,
      audioPlayer: audioPlayer ?? this.audioPlayer,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

abstract class ExploreTabState {}

class ExploreTabInitialState extends ExploreTabState {}

class SelectedUriLoadedSate extends ExploreTabState {
  final String selectedUri;

  SelectedUriLoadedSate(this.selectedUri);
}