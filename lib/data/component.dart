import 'package:bloc_call_api/data/home.dart';
import 'package:bloc_call_api/theme/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Component extends StatefulWidget {
  const Component({Key? key}) : super(key: key);

  @override
  State<Component> createState() => _ComponentState();
}

class _ComponentState extends State<Component> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: ColorPalette.backgroundColor,
          appBar: AppBar(
            title: search(),
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  text: 'All',
                ),
                Tab(
                  text: 'Album',
                ),
                Tab(
                  text: 'Playlist',
                ),
                Tab(
                  text: 'Artist',
                ),
                Tab(
                  text: 'Explpore',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Home(),
              Home(),
              Home(),
              Home(),
              Home(),
            ],
          ),

        ),
      ),
    );
  }

  Widget search() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
          filled: true,
          fillColor: const Color(0xFFF4F4F4),
          hintText: 'Search music',
          hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
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
      ),
    );
  }
}
