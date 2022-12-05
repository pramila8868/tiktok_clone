import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_clone/style/constant.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController
      controller; //final donot chnage but only for widget
  final IconData myIcon;
  final String myLabelText;
  final bool toHide;
  const TextInputField({
    Key? key,
    required this.controller,
    required this.myIcon,
    required this.myLabelText,
    required this.toHide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: toHide,
      controller: controller,
      decoration: InputDecoration(
        // border: InputDecoration,
        icon: Icon(myIcon),
        labelText: myLabelText,
        // enabledBorder: OutlineInputBorder(
        border: OutlineInputBorder(
          // focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: borderColor),
        ),
        //focusedErrorBorder:
      ),
    );
  }
}
