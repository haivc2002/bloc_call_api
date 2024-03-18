import 'dart:ui';

import 'package:bloc_call_api/theme/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bloc/ability_bloc.dart';

class AllTabScreen extends StatefulWidget {
  const AllTabScreen({Key? key}) : super(key: key);

  @override
  State<AllTabScreen> createState() => _AllTabScreenState();
}

class _AllTabScreenState extends State<AllTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      body: BlocProvider(
        create: (context) => DataBloc()..add(FetchData()),
        child: BlocBuilder<DataBloc, DataState>(
          builder: (context, state) {
            if(state is DataInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DataLoaded) {
              return SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                child: RefreshIndicator(
                  onRefresh: () async {
                    if (!BlocProvider.of<DataBloc>(context).isRefreshing) {
                      BlocProvider.of<DataBloc>(context).add(FetchData());
                      await Future.delayed(const Duration(seconds: 1));
                    }
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: BlocProvider.of<DataBloc>(context).scrollController,
                    itemCount: state.datas.length + (state.hasMoreData ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < state.datas.length) {
                        final data = state.datas[index];
                        return Container(
                          color: Colors.transparent,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${data.name != "     " ? data.name : 'null'}', style: const TextStyle(fontWeight: FontWeight.w500),),
                              Text('${data.country}', style: TextStyle(fontSize: 12.sp)),
                            ],
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    },
                  ),
                ),
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
      )
    );
  }

}
