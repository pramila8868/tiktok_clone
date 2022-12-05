import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

import '../model/videomodel.dart';
import '../view/widgets/screens/homescreen.dart';

class videoUploadController extends GetxController {
  static videoUploadController instance = videoUploadController();
  var uuid = Uuid();

// main Video upload
// video to storage
// video compress
// video thumb gen
// video thumb to storage
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      // get user document from firestore
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();

// generate unique id of video to set document name

      String id = uuid.v1();
      String videoUrl = await _uploadVideoToStorage(id, videoPath);
      String thumbnail = await _uploadVideoThumbToStorage(id, videoPath);
      Video video = Video(
        uid: uid,
        username: (userDoc.data()! as Map<String, dynamic>)['name'],
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        songName: songName,
        shareCount: 0,
        commentsCount: 0,
        likes: [],
        profilePic: (userDoc.data()! as Map<String, dynamic>)['profilePic'],
        caption: caption,
        id: id,
      );
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(id)
          .set(video.toJson());
      Get.snackbar(
          "Video Uploaded Successfully", "Thank You Sharing Your Content");
      //  Get.back();
      Get.to(HomeScreen());
    } catch (e) {
      print(e);
      Get.snackbar("Error Uploading Video", e.toString());
    }
  }

  Future<String> _uploadVideoThumbToStorage(String id, String videoPath) async {
    // videopath is required to compress video
    // videoid- to set video name during uploading  video files
    Reference reference =
        FirebaseStorage.instance.ref().child("thumbnail").child(id);

    UploadTask uploadTask = reference.putFile(await _getThumb(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<File> _getThumb(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  Future<String> _uploadVideoToStorage(String videoID, String videoPath) async {
    // first to access the folder
    Reference reference =
        FirebaseStorage.instance.ref().child("videos").child(videoID);

    UploadTask uploadTask = reference.putFile(await _compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }
}
