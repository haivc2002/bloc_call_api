import 'dart:ui';
import 'package:flutter/widgets.dart';

class ColorPalette {
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color pinkColor = Color(0xFFF92457);
}

class ColorPaletteProvider extends InheritedWidget {
  final ColorPalette colorPalette;

  const ColorPaletteProvider({
    Key? key,
    required Widget child,
    required this.colorPalette,
  }) : super(key: key, child: child);

  static ColorPaletteProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorPaletteProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
