import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    this.controller,
    this.labelText,
    this.prefixIcon,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText,
    this.enabled,
    this.maxLines,
    this.minLines,
    this.textCapitalization,
    this.errorText,
  });

  final TextEditingController controller;
  final String labelText;
  final Icon prefixIcon;
  final Widget suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final int minLines;
  final TextCapitalization textCapitalization;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 0.5, color: Colors.blue,),
            borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: Colors.blue,),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black87, fontSize: 20),
        focusColor: Colors.black,
        errorText: errorText ?? null,
      ),
      cursorWidth: 1,
      cursorColor: Colors.blue,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      enabled: enabled,
      maxLines: maxLines ?? 2,
      minLines: minLines ?? 1,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
    );
  }
}

    // .fromRGBO(26, 184, 182, 1)