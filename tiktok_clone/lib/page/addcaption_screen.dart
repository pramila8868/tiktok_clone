import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tiktok_clone/controller/upload_video_controller.dart';
import 'package:tiktok_clone/style/text_input.dart';
import 'package:video_player/video_player.dart';
import "package:get/get.dart";

// ignore: must_be_immutable
// class AddCaptionScreen extends StatefulWidget {
//   File videoFile;
//   String videoPath;

//   AddCaptionScreen({Key? key, required this.videoFile, required this.videoPath})
//       : super(key: key);

//   @override
//   State<AddCaptionScreen> createState() => _AddCaptionScreenState();
// }

// class _AddCaptionScreenState extends State<AddCaptionScreen> {
//   late VideoPlayerController videoPlayerController;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       videoPlayerController = VideoPlayerController.file(widget().videoFile);
//       // videoPlayerController=Video
//     });
//     videoPlayerController.initialize();
//     videoPlayerController.play();
//     videoPlayerController.setLooping(true);
//     videoPlayerController.setVolume(0.7);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height / 1.5,
//             width: MediaQuery.of(context).size.width,
//             child: VideoPlayer(videoPlayerController),
//           )
//         ],
//       ),
//     );
//   }
// }
class addCaption_Screen extends StatefulWidget {
  File videoFile;
  String videoPath;

  addCaption_Screen(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<addCaption_Screen> createState() => _addCaption_ScreenState();
}

class _addCaption_ScreenState extends State<addCaption_Screen> {
  // ignore: avoid_types_as_parameter_names

  late VideoPlayerController videoPlayerController;
  videoUploadController videouploadcontroller =
      Get.put(videoUploadController());
  TextEditingController songNameController = new TextEditingController();
  TextEditingController captionController = new TextEditingController();

  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(0.7);
  }

  Widget UploadContent = Text("Upload");
  uploadVid() {
    UploadContent = Text("Please Wait");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.4,
        child: VideoPlayer(videoPlayerController),
      ),
      Padding(
        padding: const EdgeInsets.all(11.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height / 1,
          child: Column(
            children: [
              TextInputField(
                controller: songNameController,
                myIcon: Icons.music_note,
                myLabelText: "Song name",
                toHide: false,
              ),
              SizedBox(
                height: 10,
              ),
              TextInputField(
                controller: captionController,
                myIcon: Icons.closed_caption,
                myLabelText: "Caption",
                toHide: false,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  uploadVid();
                  videouploadcontroller.uploadVideo(songNameController.text,
                      captionController.text, widget.videoPath);
                },
                child:
                    //"upload",
                    UploadContent,
              ),
            ],
          ),
        ),
      )
    ])));
  }
}
