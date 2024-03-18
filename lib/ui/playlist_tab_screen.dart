import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaylistTabScreen extends StatefulWidget {
  const PlaylistTabScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistTabScreen> createState() => _PlaylistTabScreenState();
}

class _PlaylistTabScreenState extends State<PlaylistTabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 30,),
          itemplaylist('lib/theme/image/Group 19.png', 'New Playlist'),
          itemplaylist('lib/theme/image/Group 21.png', 'Recently Played'),
          itemplaylist('lib/theme/image/Group 22.png', 'Favorites'),
        ],
      ),
    );
  }

  Widget itemplaylist(String image, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        onTap: () {},
        leading: Image.asset(image, height: 23,),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }
}
