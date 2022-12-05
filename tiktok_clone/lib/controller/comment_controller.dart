import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/model/commentmodel.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value; // get method creat by comments
  // to acees comment from anywhere by creating public
  String _postID = ""; // videoid - postid same

  updatePostID(String id) {
    _postID = id;
    fetchComment(); // fetch-get
  }

//__________________________________________________
  fetchComment() async {
    _comments.bindStream(FirebaseFirestore.instance
        .collection("videos")
        .doc(_postID)
        .collection("comments")
        .snapshots()
        .map((QuerySnapshot query) {
      List<Comment> retVal = [];
      for (var element in query.docs) {
        retVal.add(Comment.fromSnap(element));
      }
      return retVal;
    }));
  }

// fetch data
  //_____________________________________________________
  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .get();
        var allDocs = await FirebaseFirestore.instance
            .collection("videos")
            .doc(_postID)
            .collection("comments")
            .get();
        int len = allDocs.docs.length;
// create comment data type
        Comment comment = Comment(
            // create datavariable to post directly firebase firestore like username,comment..
            username: (userDoc.data() as dynamic)['name'],
            comment: commentText.trim(),
            datePub: DateTime.now(),
            likes: [],
            profilePic: (userDoc.data() as dynamic)['profilePic'],
            uid: FirebaseAuth.instance.currentUser!.uid,
            id: 'Comment $len');

// comment upload
        await FirebaseFirestore.instance
            .collection("videos")
            .doc(_postID)
            .collection("comments")
            .doc('Comment $len')
            .set(comment.toJson());
// to post comment
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection('videos')
            .doc(_postID)
            .get();
        await FirebaseFirestore.instance
            .collection('videos')
            .doc(_postID)
            .update({
          'commentsCount': (doc.data() as dynamic)['commentsCount'] + 1,
        });
      } else {
        Get.snackbar(
            "Please Enter some content", "Please write something in comment");
      }
    } catch (e) {
      Get.snackbar("Error in sending comment", e.toString());
    }
  }

//__________________________________________________________________
  likeComment(String id) async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('videos')
        .doc(_postID)
        .collection("comments")
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postID)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postID)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
