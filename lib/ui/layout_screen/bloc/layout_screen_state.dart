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
