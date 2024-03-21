import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'layout_screen_event.dart';
part 'layout_screen_state.dart';

class ContainerBloc extends Bloc<ContainerEvent, ContainerState> {
  ContainerBloc() : super(ContainerState(isExpanded: false)) {
    on<ExpandContainer>((event, emit) {
      emit(state.copyWith(isExpanded: true,));
    });
    on<ShrinkContainer>((event, emit) {
      emit(state.copyWith(isExpanded: false,));
    });
  }
}

class NextScreenPageBloc extends Bloc<NextScreenPageEvent, NextScreenPageState> {
  NextScreenPageBloc() : super(NextScreenPageState(pageController: PageController())) {
    on<NextScreenTabBarEvent>((event, emit) {
      emit(state.copyWith(selectedIndex: 0));
    });
    on<TabbarChangeColorEvent>((event, emit) {
      final newController = PageController();
      emit(state.copyWith(pageController: newController));
    });
  }
}

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicBloc() : super(MusicState(audioPlayer: AudioPlayer(), isPlaying: false, selectedUri: '')) {
    on<MusicEvent>((event, emit) {
      final audioPlayer = state.audioPlayer;
      final selectedUri = state.selectedUri;
      if (event is TogglePlayPauseEvent) {
        if (!state.isPlaying) {
          audioPlayer.play(AssetSource(selectedUri));
        } else {
          audioPlayer.pause();
        }
        emit(state.copyWith(isPlaying: !state.isPlaying));
      }
    });
  }
}

class ExploreTabBloc extends Bloc<ExploreTabEvent, ExploreTabState> {
  ExploreTabBloc()
      : super(ExploreTabState(
      selectedUri: '',
      isPlaying: false,
      player: AudioPlayer(),
      isExpanded: false,
      duration: Duration.zero,
      position: Duration.zero)) {
    on<ExploreTabSelectedEvent>((event, emit) {
      emit(state.copyWith(selectedUri: event.selectedUri));
    });

    on<ClickPlayPauseMusicEvent>((event, emit) async {
      if (state.isPlaying) {
        await state.player.pause();
      } else {
        await state.player.play(AssetSource(state.selectedUri));
      }
      emit(state.copyWith(isPlaying: !state.isPlaying));
    });

    on<OpenPlayNowScreenEvent>((event, emit) {
      emit(state.copyWith(isExpanded: true,));
    });
    on<ClosePlayNowScreenEvent>((event, emit) {
      emit(state.copyWith(isExpanded: false,));
    });

    on<DurationEvent>((event, emit) {
      state.player.onDurationChanged.listen((Duration d) {
        emit(state.copyWith(duration: state.duration = d));
      });
    });

    on<PositionEvent>((event, emit) {
      state.player.onPositionChanged.listen((Duration p) {
        emit(state.copyWith(position: state.position = p));
      });
    });
  }
}
