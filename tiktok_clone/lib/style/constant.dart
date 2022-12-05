import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/page/add_video.dart';
import 'package:tiktok_clone/page/profilePage.dart';
import 'package:tiktok_clone/search/searchscreen.dart';

import '../page/display_video.screen.dart';

// controller- it contains logic
//MVC-use for code reusable (Model View Controller)
const backgroundColor = Colors.black;
var buttonColor = Colors.red;
const borderColor = Colors.grey;

var pageIndex = [
  DisplayVideo_Screen(),
  //const Text("Search"),
  SearchScreen(),
  //AddVideoScreen(),
  const AddVideo(),
  //Text("Add Video"),
  //Text("Upload Video"),
  const Text("Message"),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];

getRandomColor() => [
      Colors.accents,
      Colors.amber,
      Colors.greenAccent,
    ][Random().nextInt(3)];
