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
    on<ComboES>((event, emit) {
      emit(state.copyWith(isCombo: !state.isCombo));
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