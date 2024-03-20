import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../all_tab_screen/bloc/ability_bloc.dart';

class ArtistTabScreen extends StatefulWidget {
  const ArtistTabScreen({Key? key}) : super(key: key);

  @override
  State<ArtistTabScreen> createState() => _ArtistTabScreenState();
}

class _ArtistTabScreenState extends State<ArtistTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            headerpage(),
            listmusicintabartist()
          ],
        ),
      ),
    );
  }

  Widget headerpage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('favorite Artist Musics', style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700
          ),),
          Stack(
            children: [
              Image.asset('assets/MaskGroup.png',),
              Column(
                children: [
                  SizedBox(height: 60.h,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset('assets/Rectangle16.png', height: 80.h,),
                      SizedBox(width: 20.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Baseera Media', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),),
                          const Text('Islamic'),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget listmusic() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            leading: Container(
              margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
              height: 29.h,
              width: 37.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red,
              ),
            ),
            title: Text('fefe', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),),
            subtitle: Text('fwhefh', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400)),
            trailing: IconButton(icon: const Icon(Icons.more_vert), onPressed: () {},),
          );
        },
      ),
    );
  }

  Widget listmusicintabartist() {
    return BlocProvider(
      create: (context) => DataBloc()..add(FetchData()),
      child: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          if(state is DataInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DataLoaded) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.datas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {},
                  leading: Container(
                    margin: EdgeInsets.fromLTRB(20.w, 0, 0, 0),
                    height: 29.h,
                    width: 37.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage('${state.datas[index].favicon}'),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  title: Text('${state.datas[index].name}', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),),
                  subtitle: Text('${state.datas[index].country}', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400)),
                  trailing: IconButton(icon: const Icon(Icons.more_vert), onPressed: () {},),
                );
              },
            );
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
}
