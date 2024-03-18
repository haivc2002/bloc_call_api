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

  final player = AudioPlayer();
  bool isPlaying = false;
  bool isDurationLoaded = false;
  double _currentSliderValue = 0;
  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;
  Timer? timer;

  void initState() {
    super.initState();
    player.onDurationChanged.listen((Duration duration) {
      setState(() {
        totalDuration = duration;
        isDurationLoaded = true;
      });
    });

    player.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.playing) {
        setState(() {
          isPlaying = true;
        });
        startTimer(); // Bắt đầu hàm định thời khi bắt đầu phát nhạc
      } else {
        setState(() {
          isPlaying = false;
        });
        stopTimer(); // Dừng hàm định thời khi dừng phát nhạc
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (totalDuration.inSeconds > 0) {
        // Tránh chia cho 0 bằng cách kiểm tra nếu totalDuration > 0
        setState(() {
          currentPosition += Duration(seconds: 1);
          _currentSliderValue = currentPosition.inSeconds.toDouble();
        });
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  Future<void> playAudioFromUrl(String url) async {
    await player.play(UrlSource(url));
  }

  Future<void> stopAudio() async {
    await player.stop();
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
          // Slider(
          //   value: position.inSeconds.toDouble(),
          //   min: 0,
          //   max: duration.inSeconds.toDouble(),
          //   inactiveColor: const Color(0xFFDFDFDF),
          //   activeColor: ColorPalette.pinkColor,
          //   onChanged: (value) {
          //     // setState(() {
          //     //   _currentSliderValue = value;
          //     // });
          //     final position = Duration(seconds: value.toInt());
          //     player.seek(position);
          //     player.resume();
          //   },
          // ),

          Slider(
            value: _currentSliderValue,
            min: 0,
            max: totalDuration.inSeconds.toDouble(),
            inactiveColor: const Color(0xFFDFDFDF),
            activeColor: ColorPalette.pinkColor,
            onChanged: (value) {
              setState(() {
                _currentSliderValue = value;
              });
              final position = Duration(seconds: value.toInt());
              player.seek(position);
            },
          ),

          Text(
            '${currentPosition.inMinutes.remainder(60).toString().padLeft(2, '0')}:${currentPosition.inSeconds.remainder(60).toString().padLeft(2, '0')}',
          ),

          Row(
            children: [
              const Spacer(),
              bntfunstion(Icons.skip_previous),
              const Spacer(),
              BlocBuilder<ContainerBloc, ContainerState>(
                  builder: (BuildContext context, ContainerState state) {
                    return GestureDetector(
                      onTap: () {
                        context.read<ContainerBloc>().add(ComboES());
                        state.isCombo ? player.stop() : playAudioFromUrl('https://stream.funradio.sk:8000/fun128.mp3');
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
