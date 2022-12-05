// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/style/text_input.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _setpasswordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        margin: const EdgeInsets.only(top: 100),
        alignment: Alignment.center,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            // GlithEffect(
            //child:
            const Text(" welcome to TikTok "),
            //),
            const SizedBox(
              height: 10,
            ),

            InkWell(
              onTap: () {
                AuthController.instance.pickImage();
                //AuthController().pickImage();
              },
              child: Stack(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://www.pngitem.com/pimgs/m/421-4212341_default-avatar-svg-hd-png-download.png"),
                    //backgroundColor: Colors.deepPurpleAccent,
                    radius: 50,
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.black,
                          )))
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              //margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                myIcon: Icons.email,
                myLabelText: "Email",
                toHide: false,
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            TextInputField(
              controller: _setpasswordController,
              myIcon: Icons.lock,
              myLabelText: " Set Password",
              toHide: true,
            ),
            const SizedBox(
              height: 30,
            ),

            TextInputField(
              controller: _confirmpasswordController,
              myIcon: Icons.lock,
              myLabelText: " Confirm Password",
              toHide: true,
            ),
            const SizedBox(
              height: 30,
            ),

            TextInputField(
              controller: _usernameController,
              myIcon: Icons.person,
              myLabelText: " Username",
              toHide: true,
            ),

            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  //AuthController.instance.SignUp(
                  AuthController().SignUp(
                      _usernameController.text,
                      _emailController.text,
                      _setpasswordController.text,
                      AuthController.instance.proimg);
                  //   AuthController().proimg);
                },
                child: Container(
                    // padding: ,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Center(child: const Text("SignUp"))))
          ],
        ),
      ),
    );
  }
}
