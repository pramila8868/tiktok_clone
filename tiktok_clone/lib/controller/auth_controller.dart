// // logic relate to database
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/model/usermodel.dart';
import 'package:tiktok_clone/view/widgets/screens/auth_screen/login_screen.dart';

import '../view/widgets/screens/homescreen.dart';

// _ =private - one one can use except this class
class AuthController extends GetxController {
  // late Rx<User?> _user;
  // User get user => _user.value!;

  static AuthController instance = Get.find();

// how to select image from device
  File? proimg; // for globable
  void pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final img = File(image.path);
    this.proimg = img;
  }

//__________________________________________________________________________
  // user state persistance- once login we donot need to login or signup multiple times after login or signup
  late Rx<User?>
      _user; // _user -nadi (observe karni layak// user come from firebase authetication
  User get user => _user.value!;

  // _user.bindsteam - nadi me color dakho(  see authetication state / changes in authetication)
  // ever - coth to see river/ authentication and find chaneges and call setinitialview
  // method and pass argument as a user
  void onReady() {
    super.onReady(); // onready -it is call after create one frame
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    //Rx(me) see User changes done by firebaseauthentiacation(curentuser)changes by currentuser
    // rx(observal keyword)- countinulesly check the variable is change or not
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user,
        _setInitialView); // if changes then call this  ever function pass observable keyword
  }

  _setInitialView(User? user) {
    if (user == null) {
      Get.offAll(LoginScreen());
    } else {
      //Get.offAll(LoginScreen()); //(HomeScreen());
      Get.offAll(HomeScreen());
    }
  }
// user.bindstream(kya dakhraha haii)-Nadi ma color hera
// ever-contn to watch river, if any change in river then we can notice of
//changing then call method(setInitialView) and user ko as a argument pass garni

//_____________________________________________________________
// create method for user register
// sigin
  // ignore: non_constant_identifier_names
  Future<void> SignUp(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // userCredentials come under firebase

        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl = await _uploadProPic(image);

        myUser user = myUser(
            name: username,
            email: email,
            profilePhoto: downloadUrl,
            uid: credential.user!.uid);
        //upload user data
        await FirebaseFirestore.instance
            .collection("users")
            .doc(credential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar("Error occur", "Please eneter all the required field");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    }
  }

// ignore:
  Future<String> _uploadProPic(File image) async {
    // Reference is class under firebase
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("profilePics")
        .child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    snapshot.bytesTransferred; // kati transfer vayo
    String imageDwnUrl =
        await snapshot.ref.getDownloadURL(); // image download link
    return imageDwnUrl;
  }

//___________________________________________________________________________________
  // methods for login
  void login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar("Error Ligging in", "Please enter all the fields");
      }
    } catch (e) {
      Get.snackbar("Error Logging", e.toString());
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    Get.offAll(LoginScreen());
  }
}
