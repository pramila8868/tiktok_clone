// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';

class myUser {
  String name;
  String profilePhoto;
  String email;
  String uid;
  myUser(
      {required this.name,
      required this.email,
      required this.profilePhoto,
      required this.uid});
// App to fitebase(firebase accept map but map and json is same) sent data
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "profilePic": profilePhoto,
      "email": email,
      "uid": uid
    };
  }
  // same as upper it is another way no need to use return
  // Map<String, dynamic> toJson()=> {

  //   "name": name,
  //   "profilePic": profilePhoto,
  //   "email": email,
  //   "uid": uid
  // };

// static we can acess directly ,no need to use usedr model
  // ignore: dead_code
  // Firebase(Map format)to App( convet to User data type)
  // ignore: dead_code
  static myUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return myUser(
      email: snapshot["email"],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      name: snapshot['name'],
    );
  }
}
