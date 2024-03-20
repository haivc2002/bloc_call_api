import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/model.dart';
import '../layout_screen/bloc/layout_screen_bloc.dart';
import '../layout_screen/music_play_screen.dart';

class ExplporeTabScreen extends StatefulWidget {
  final Function(String) onTap;
  const ExplporeTabScreen({Key? key, required this.onTap}) : super(key: key);
  @override
  State<ExplporeTabScreen> createState() => _ExplporeTabScreenState();
}

class _ExplporeTabScreenState extends State<ExplporeTabScreen> {

  static List<AudioList> listmusic = [
    AudioList(uri: 'music/angelbaby.mp3'),
    AudioList(uri: 'music/test.mp3'),
  ];

  void onTapListItem(String uri) {
    widget.onTap(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: listmusic.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              onTapListItem(listmusic[index].uri.toString());
            },
            title: Text('${listmusic[index].uri}'),
          );
        },
      ),
    );
  }
}
