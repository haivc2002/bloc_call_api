import 'package:audioplayers/audioplayers.dart';
import 'package:bloc_call_api/theme/color_palette.dart';
import 'package:bloc_call_api/ui/artist_tab_screen/artist_tab_screen.dart';
import 'package:bloc_call_api/ui/explpore_tab_screen/explpore_tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../album_tab_screen/album_tab_screen.dart';
import '../all_tab_screen/all_tab_screen.dart';
import '../playlist_tab_screen/playlist_tab_screen.dart';
import 'bloc/layout_screen_bloc.dart';
import 'music_play_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalette.backgroundColor,
        body: BlocProvider(
          create: (context) => NextScreenPageBloc(),
          child: BlocBuilder<NextScreenPageBloc, NextScreenPageState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Container(height: 120.h),
                        Expanded(child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: state.pageController,
                          children: [
                            const AllTabScreen(),
                            const AlbumTabScreen(),
                            const PlaylistTabScreen(),
                            const ArtistTabScreen(),
                            ExplporeTabScreen(
                              onTap: (String uri) {
                                context.read<ExploreTabBloc>().add(ExploreTabSelectedEvent(uri));
                              },
                            ),
                          ],
                        )),
                        Container(height: MediaQuery.of(context).size.height*0.18),
                      ],
                    ),
                  ),
                  appbarcustom(context, state),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: BlocBuilder<ExploreTabBloc, ExploreTabState>(
                      builder: (context, state) {
                        return playnowbottom(context, state);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ),
    );
  }

  Widget appbarcustom(BuildContext context, NextScreenPageState state) {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFA0A0A0).withOpacity(0.5)
          )
        )
      ),
      child: Column(
        children: [
          search(),
          Expanded(
            child: Center(
              child: SizedBox(
                height: 30.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(width: 20.w,),
                    bntappbar('All', 0, context, state),
                    bntappbar('Album', 1, context, state),
                    bntappbar('Playlist', 2, context, state),
                    bntappbar('Artist', 3, context, state),
                    bntappbar('Explpore', 4, context, state),
                  ],
                ),
              )
            )
          )
        ],
      ),
    );
  }

  Widget search() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 13),
                  filled: true,
                  fillColor: const Color(0xFFF4F4F4),
                  hintText: 'Search music',
                  hintStyle: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w400),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    color: Colors.grey,
                    onPressed: () {},
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.blue,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onChanged: (text) {},
              )
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert)
          )
        ],
      ),
    );
  }

  Widget bntappbar(String text, int index, BuildContext context, NextScreenPageState state) {
    Color colorbox = state.selectedIndex == index ? ColorPalette.pinkColor : const Color(0xFFE5E5E5);
    Color colortext = state.selectedIndex == index ? Colors.white : Colors.black;
    return GestureDetector(
      onTap: () {
        setState(() {
          state.selectedIndex = index;
          state.pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colorbox,
          ),
          duration: const Duration(milliseconds: 150),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Center(child: Text(text, style: TextStyle(color: colortext),)),
          ),
        ),
      ),
    );
  }

  Widget playnowbottom(BuildContext context, ExploreTabState state) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: state.isExpanded ? MediaQuery.of(context).size.height : 150.w,
      width: double.infinity,
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: ColorPalette.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, -10),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: !state.isExpanded ? formplaynow(context, state) : MusicPlayScreen(context: context, state: state),
        )
      ),
    );
  }


  bool isPlaying = false;
  final player = AudioPlayer();
  Duration duration = const Duration();
  Duration position = const Duration();

  late final ExploreTabBloc exploreTabBloc;

  @override
  void initState() {
    super.initState();
    player.onDurationChanged.listen((Duration d) {
      setState(() {
        duration = d;
      });
    });

    player.onPositionChanged.listen((Duration p) {
      setState(() {
        position = p;
      });
    });
    context.read<ExploreTabBloc>().add(DurationEvent());
    context.read<ExploreTabBloc>().add(PositionEvent());
  }


  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
  String formatDuration(Duration d) {
    return d.toString().split('.').first.padLeft(8, "0");
  }

  Widget formplaynow(BuildContext context, ExploreTabState state) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.1.h,
            width: MediaQuery.of(context).size.height*0.1.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      context.read<ExploreTabBloc>().add(OpenPlayNowScreenEvent());
                    },
                    child: Text(
                      state.selectedUri.isEmpty ? 'không có bài hát nào' : state.selectedUri,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.symmetric(vertical: 10),
                //   height: 5.h,
                //   child: Slider(
                //     value: state.position.inSeconds.toDouble(),
                //     min: 0.0,
                //     max: state.duration.inSeconds.toDouble(),
                //     onChanged: (double value) {
                //       context.read<ExploreTabBloc>().add(SeekMusicEvent(Duration(seconds: value.toInt())));
                //     },
                //   ),
                // ),
                Text('${formatDuration(state.position)}/${formatDuration(state.duration)}')
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              context.read<ExploreTabBloc>().add(ClickPlayPauseMusicEvent());
            },
            child: Container(
              height: MediaQuery.of(context).size.width*0.15,
              width: MediaQuery.of(context).size.width*0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xFFF4F4F4),
              ),
              child: Center(
                child: Icon(
                  // state.isCombo ? Icons.pause : Icons.play_arrow,
                  state.isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 40.sp, color: Colors.pink,),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget playnowscreen(BuildContext context, ExploreTabState state) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/theme/image/Group18.png'),
                  fit: BoxFit.cover
                )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.read<ContainerBloc>().add(
                            ShrinkContainer());
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back_ios, size: 18, color: Colors.white,),
                          Text('Back', style: TextStyle(color: Colors.white, fontSize: 20.sp),),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text('Now Playing', style: TextStyle(color: Colors.white, fontSize: 26.sp, fontWeight: FontWeight.bold),),
                    const Spacer(),
                    SizedBox(height: 30.h,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
