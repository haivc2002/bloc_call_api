import 'package:bloc_call_api/theme/color_palette.dart';
import 'package:bloc_call_api/ui/layout_screen/bloc/layout_screen_bloc.dart';
import 'package:bloc_call_api/ui/layout_screen/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ContainerBloc()),
          BlocProvider(create: (context) => ExploreTabBloc()),
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return ColorPaletteProvider(
      colorPalette: ColorPalette(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_ , child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: child,
          );
        },
        child: const LayoutScreen(),
      ),
    );
  }
}

