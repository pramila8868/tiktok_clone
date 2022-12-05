import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/comment/comment_screen.dart';
import 'package:tiktok_clone/controller/videocontroller.dart';
import 'package:tiktok_clone/page/profilePage.dart';

import '../style/constant.dart';
import 'addcaption_screen.dart';
import 'albumrotator.dart';
import 'profilebutton.dart';
import 'tiktok_videiplayer.dart';

class DisplayVideo_Screen extends StatelessWidget {
  DisplayVideo_Screen({Key? key}) : super(key: key);

  final VideoController videoController = Get.put(VideoController());

  Future<void> share(String vidId) async {
    await FlutterShare.share(
      title: 'Download Tiktok',
      text: 'Watch short video in tiktok',
      //  linkUrl: 'https://flutter.dev/',
      // chooserTitle: 'Example Chooser Title'
    );
    videoController.shareVideo(vidId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
            scrollDirection: Axis.vertical,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            itemCount: videoController.videoList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onDoubleTap: () {
                  videoController
                      .likedVideo(videoController.videoList[index].id);
                },
                child: Stack(
                  children: [
                    TikTokVideoPlayer(
                        videoUrl:
                            videoController.videoList[index].videoUrl //"aaa",
                        ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10, left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            videoController.videoList[index].username,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          Text(videoController.videoList[index].caption),
                          Text(
                            videoController.videoList[index].songName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height - 350,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3,
                            right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(ProfileScreen(
                                  uid: videoController.videoList[index].uid,
                                ));
                              },
                              child: ProfileButton(
                                profilePhotoUrl:
                                    videoController.videoList[index].profilePic,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                videoController.likedVideo(
                                    videoController.videoList[index].id);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                    size: 45,
                                    color: videoController
                                            .videoList[index].likes
                                            .contains(FirebaseAuth
                                                .instance.currentUser!.uid)
                                        ? Colors.pinkAccent
                                        : Colors.white,
                                  ),
                                  Text(
                                    videoController
                                        .videoList[index].likes.length
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                share(videoController.videoList[index].id);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.reply,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    videoController.videoList[index].shareCount
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(CommentScreen(
                                      id: videoController.videoList[index].id,
                                    ));
                                  },
                                  child: Icon(
                                    Icons.comment,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  videoController.videoList[index].commentsCount
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    AlbumRotator(
                                        profilePicUrl: videoController
                                            .videoList[index].profilePic)
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            });
      }),
    );
  }
}
