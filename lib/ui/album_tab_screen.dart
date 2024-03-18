import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'all_tab_screen/bloc/ability_bloc.dart';

class AlbumTabScreen extends StatefulWidget {
  const AlbumTabScreen({Key? key}) : super(key: key);

  @override
  State<AlbumTabScreen> createState() => _AlbumTabScreenState();
}

class _AlbumTabScreenState extends State<AlbumTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      if (index < state.datas.length) {
                        final data = state.datas[index];
                        return Container(
                          color: Colors.transparent,
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network('${data.favicon}'),
                              Text('${data.name != "     " ? data.name : 'null'}', style: const TextStyle(fontWeight: FontWeight.w500),),
                            ],
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    }
                  )
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
