part of 'layout_screen_bloc.dart';

class ContainerState {
  final bool isExpanded;

  ContainerState({this.isExpanded = false});

  ContainerState copyWith({bool? isExpanded, bool? isCombo}) {
    return ContainerState(
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}

class NextScreenPageState {
  final PageController pageController;
  int selectedIndex;

  NextScreenPageState({this.selectedIndex = 0, required this.pageController});

  NextScreenPageState copyWith(
      {int? selectedIndex, PageController? pageController}) {
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

class ExploreTabState {
  final String selectedUri;
  late final bool isPlaying;
  final AudioPlayer player;
  late final Duration duration;
  late final Duration position;
  final bool isExpanded;

  ExploreTabState({
    required this.selectedUri,
    required this.isPlaying,
    required this.player,
    required this.duration,
    required this.position,
    this.isExpanded = false
  });

  ExploreTabState copyWith({
    String? selectedUri,
    bool? isPlaying,
    AudioPlayer ? player,
    Duration? duration,
    Duration? position,
    bool? isExpanded
  }) {
    return ExploreTabState(
      selectedUri: selectedUri ?? this.selectedUri,
      isPlaying: isPlaying ?? this.isPlaying,
      player: player ?? this.player,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}

