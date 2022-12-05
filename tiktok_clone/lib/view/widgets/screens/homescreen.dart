import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_clone/style/constant.dart';

import '../../../style/custom_add_icon.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, //define fixed width
          backgroundColor: backgroundColor,
          currentIndex: pageIdx,
          onTap: (index) {
            setState(() {
              pageIdx = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                // icon: CustomAddIcon(),
                icon: Icon(
                  Icons.home,
                  size: 25,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 25,
                ),
                label: "Search"),
            BottomNavigationBarItem(icon: CustomAddIcon(), label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.message,
                  size: 25,
                ),
                label: "Message"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 25,
                ),
                label: "Profile"),
          ],
        ),
        // body: Center(
        //     child: pageIndex[
        //         pageIdx]) // already by default written in text//Text(pageIndex[pageIdx])),
        body: Center(
          child: pageIndex[pageIdx],
        ));
  }
}
