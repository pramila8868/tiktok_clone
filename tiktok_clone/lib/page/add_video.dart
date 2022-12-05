import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/style/constant.dart';
import 'package:tiktok_clone/page/addcaption_screen.dart';

class AddVideo extends StatelessWidget {
  const AddVideo({Key? key}) : super(key: key);
  videoPick(ImageSource src, BuildContext context) async {
//     // this function is used to pick the video
    final video = await ImagePicker().pickVideo(source: src);

    if (video != null) {
      Get.snackbar("Video Selected", video.path);
      Get.off(addCaption_Screen(
          videoFile: File(video.path), videoPath: video.path));

// use context because we need to pass context as parameter in navigator..
      //_____________________________ same as get.off(add...)
//       // ignore: use_build_context_synchronously
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => AddCaptionScreen(
//                   videoFile: File(video.path), videoPath: video.path)));
//       // AddCaptionScreen
//       // (videoFile: File(video.path), videoPath: video.path));
    } else {
      Get.snackbar(
          "Error In Selecting Video", "Please choose a different Video file");
    }
  }

  showDialogOpt(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(children: [
              SimpleDialogOption(
                  onPressed: () {
                    videoPick(ImageSource.gallery, context);
                  },
                  child: const Text("Gallery")),
              SimpleDialogOption(
                  onPressed: () {
                    videoPick(ImageSource.camera, context);
                  },
                  child: const Text("Camera")),
              SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Close"))
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
        onTap: (() {
          showDialogOpt(context);
        }),
        child: Container(
          width: 190,
          height: 50,
          decoration: BoxDecoration(color: buttonColor),
          // ignore: prefer_const_constructors
          child: Center(
            child: const Text(
              "Add Video",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      )),
    );
  }
}
// class addVideoScreen extends StatelessWidget {
//   addVideoScreen({Key? key}) : super(key: key);
//   videoPick(ImageSource src, BuildContext context) async {
//     final video = await ImagePicker().pickVideo(source: src);
//     if (video != null) {
//       Get.snackbar("Video Selected", video.path);
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => addCaption_Screen(
//                   videoFile: File(video.path), videoPath: video.path)));
//     } else {
//       Get.snackbar(
//           "Error In Selecting Video", "Please Choose A Different Video File");
//     }
//   }

//   showDialogOpt(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (context) => SimpleDialog(
//               children: [
//                 SimpleDialogOption(
//                   onPressed: () => videoPick(ImageSource.gallery, context),
//                   child: Text("Gallery"),
//                 ),
//                 SimpleDialogOption(
//                   onPressed: () => videoPick(ImageSource.camera, context),
//                   child: Text("Camera"),
//                 ),
//                 SimpleDialogOption(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text("Close"),
//                 )
//               ],
//             ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: InkWell(
//           onTap: () => showDialogOpt(context),
//           child: Container(
//             width: 190,
//             height: 50,
//             decoration: BoxDecoration(color: buttonColor),
//             child: Center(
//               child: Text(
//                 "Add Video",
//                 style: TextStyle(
//                     fontSize: 25,
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
