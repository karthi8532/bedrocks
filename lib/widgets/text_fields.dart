import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class custom_TextField extends StatelessWidget {
  final String text;
  String hintText;
  final Color backGround;
  final Color color;
  final TextEditingController controller;
  final IconData icon;
  bool? isreadonly;
  bool? isnumbers;
  custom_TextField(
      {super.key,
      required this.text,
      required this.backGround,
      required this.color,
      required this.controller,
      required this.icon,
      this.isreadonly = false,
      this.hintText = "",
      this.isnumbers = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: false,
      textAlign: TextAlign.start,
      // inputFormatters: isnumbers == true
      //     ? <TextInputFormatter>[
      //         FilteringTextInputFormatter.allow(RegExp("[0-9].")),
      //       ]
      //     : <TextInputFormatter>[
      //         FilteringTextInputFormatter.allow(
      //           RegExp("[a-z A-Z á-ú Á-Ú 0-9]"),
      //         )
      //       ],
      readOnly: isreadonly ?? true,
      maxLines: 1,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          color: Colors.black),
      decoration: InputDecoration(
        labelText: text,
        labelStyle: const TextStyle(color: Colors.white),
        hintText: hintText ?? "",
        hintStyle: const TextStyle(color: Colors.white),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFFffc700), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFFffc700), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Color(0xFFffc700), width: 1),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        prefixIcon: Icon(icon, color: const Color(0xFFffc700), size: 24),
      ),
    );
  }
}
