// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/style/text_input.dart';
import 'package:tiktok_clone/view/widgets/screens/auth_screen/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // GlithEffect(
              //child:
              const Text(
                "TikTok Clone",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              //),
              SizedBox(
                height: 10,
              ),
              TextInputField(
                controller: _emailController,
                myIcon: Icons.email,
                myLabelText: "Email",
                toHide: false,
              ),
              SizedBox(
                height: 20,
              ),
              TextInputField(
                controller: _passwordController,
                myIcon: Icons.lock,
                myLabelText: "Password",
                toHide: true,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    AuthController.instance
                        .login(_emailController.text, _passwordController.text);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Container(
                        // padding: ,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Center(child: const Text("Login"))),
                  )),
              TextButton(
                onPressed: () {
                  Get.to(SignUpScreen());
                },
                child: Text("New User? Click Here"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
