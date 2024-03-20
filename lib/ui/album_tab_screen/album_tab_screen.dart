import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../all_tab_screen/bloc/ability_bloc.dart';

class AlbumTabScreen extends StatefulWidget {
  const AlbumTabScreen({Key? key}) : super(key: key);

  @override
  State<AlbumTabScreen> createState() => _AlbumTabScreenState();
}

class _AlbumTabScreenState extends State<AlbumTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Explore The Album', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700)),
            ),
            BlocProvider(
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1/1.2,
                                ),
                                itemBuilder: (context, index) {
                                  if (index < state.datas.length) {
                                    final data = state.datas[index];
                                    return Column(
                                      children: [
                                        Expanded(child: Container(
                                          margin: const EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0, 3),
                                                ),
                                              ]
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(10),
                                                child: Image.network('${data.favicon}', fit: BoxFit.cover,)
                                            ),
                                          ),
                                        )),
                                        Text('${data.name != "     " ? data.name : 'null'}', style: const TextStyle(fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,),
                                      ],
                                    );
                                  } else {
                                    return const Center(child: CircularProgressIndicator(),);
                                  }
        
                                }
                            ),
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
          ],
        ),
      )
    );
  }
}
