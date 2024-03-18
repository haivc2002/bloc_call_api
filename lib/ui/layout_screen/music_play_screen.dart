import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/color_palette.dart';
import '../all_tab_screen/bloc/ability_bloc.dart';
import 'bloc/layout_screen_bloc.dart';

class MusicPlayScreen extends StatefulWidget {

  final BuildContext context;
  final ContainerState state;

  const MusicPlayScreen({Key? key, required this.context, required this.state}) : super(key: key);

  @override
  State<MusicPlayScreen> createState() => _MusicPlayScreenState();
}

class _MusicPlayScreenState extends State<MusicPlayScreen> {


  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
     setState(() {
       duration = newDuration;
     });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        duration = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.3,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('lib/theme/image/Group 18.png'),
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
              ),
              slider(),
              funstionbutton()
        
            ],
          ),
        ),
      )
    );
  }

  Widget slider() {
    return BlocProvider(
      create: (context) => DataBloc()..add(FetchData()),
      child: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          if(state is DataInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DataLoaded) {
            return Expanded(child: Swiper(
              viewportFraction: 0.5,
              itemCount: state.datas.length,
              itemBuilder: (context, index) {
                final ui = state.datas[index];
                return Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Image.network('${ui.favicon}'))
                    ],
                  ),
                );
              },
            ));
          } else if (state is DataError) {
            return const Center(
              child: Text(
                'Hãy quay lại vào ngày mai !',
                style: TextStyle(
                    color: Colors.grey
                ),
              ),
            );
          } else {
            return Container();
          }


        },
      ),
    );
  }



  Widget funstionbutton() {
    return SizedBox(
      height: 180.h,
      child: Column(
        children: [

          Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await audioPlayer.seek(position);
              await audioPlayer.resume();
            }
          ),

          Text(
            formatTime(position),
          ),

          Row(
            children: [
              const Spacer(),
              bntfunstion(Icons.skip_previous),
              const Spacer(),
              BlocBuilder<ContainerBloc, ContainerState>(
                  builder: (BuildContext context, ContainerState state) {
                    return GestureDetector(
                      onTap: () async {
                        context.read<ContainerBloc>().add(ComboES());
                        // state.isCombo ? player.stop() : playAudioFromUrl('https://stream.funradio.sk:8000/fun128.mp3');
                        if(isPlaying) {
                          await audioPlayer.pause();
                        } else {
                          String url = 'https://stream.funradio.sk:8000/fun128.mp3';
                          await audioPlayer.play(UrlSource(url));
                        }
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
                            state.isCombo ? Icons.pause : Icons.play_arrow,
                            size: 40.sp, color: Colors.pink,),
                        ),
                      ),
                    );
                  }
              ),
              const Spacer(),
              bntfunstion(Icons.skip_next),
              const Spacer(),
            ],
          )
        ],
      ),
    );
  }

  Widget bntfunstion(IconData icon) {
    return Icon(icon, size: 50, color: ColorPalette.pinkColor,);
  }

}
