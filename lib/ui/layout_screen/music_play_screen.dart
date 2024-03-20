import 'package:audioplayers/audioplayers.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/color_palette.dart';
import '../all_tab_screen/bloc/ability_bloc.dart';
import 'bloc/layout_screen_bloc.dart';

class MusicPlayScreen extends StatefulWidget {

  // final BuildContext context;
  // final ContainerState state;
  final String ? uri;


  const MusicPlayScreen({Key? key, required this.uri}) : super(key: key);

  @override
  State<MusicPlayScreen> createState() => _MusicPlayScreenState();
}

class _MusicPlayScreenState extends State<MusicPlayScreen> {



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
              viewportFraction: 0.6,
              itemCount: state.datas.length,
              itemBuilder: (context, index) {
                final ui = state.datas[index];
                return Center(
                  child: Container(
                    height: 180.w,
                    width: 180.w,
                    child: Center(
                      child: Container(
                        height: 160.w,
                        width: 160.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage('${ui.favicon}'),
                            fit: BoxFit.cover
                          )
                        ),
                      )
                    ),
                  ),
                );
              },
            ));
          } else if (state is DataError) {
            return const Spacer();
          } else {
            return Container();
          }


        },
      ),
    );
  }


  double _currentSliderValue = 0;


  Widget funstionbutton() {
    return SizedBox(
      height: 180.h,
      child: Column(
        children: [
          Slider(
            value: _currentSliderValue,
            min: 0,
            max: 100,
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),

          // BlocBuilder<MusicBloc, MusicState>(
          //   builder: (context, state) {
          //     return Text(
          //       '${state.position.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(state.position.inSeconds.remainder(60)).toString().padLeft(2, '0')}',
          //       style: TextStyle(fontSize: 16.sp),
          //     );
          //   },
          // ),

          Row(
            children: [
              const Spacer(),
              bntfunstion(Icons.skip_previous),
              const Spacer(),


              //BlocBuilder<MusicBloc, MusicState>(
              //   builder: (context, state) {
              //     return IconButton(
              //       icon: Icon(state.isPlaying ? Icons.play_arrow : Icons.pause),
              //       onPressed: () {
              //         context.read<MusicBloc>().add(TogglePlayPauseEvent());
              //        },
              //     );
              //   },
              // ),
              ElevatedButton(
                onPressed: () async {
                  final player = AudioPlayer();
                  await player.play(AssetSource('${widget.uri}'));
                },
                child: Text('sd')
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
