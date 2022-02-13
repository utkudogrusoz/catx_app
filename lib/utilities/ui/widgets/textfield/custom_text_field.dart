// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  String? value;
  final TextEditingController? textEditingController;
  final bool? obscureTextField;
  final bool? visible;
  final Function? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  CustomTextField(
      {Key? key,
      @required this.textEditingController,
      @required this.obscureTextField,
      @required this.validator,
      @required this.visible,
      @required this.prefixIcon,
      @required this.suffixIcon,
      @required this.labelText,
      @required this.hintText,
      @required this.value})
      : super(key: key);
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 48.0, right: 48.0, top: 16.0),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            autofocus: false,
            controller: widget.textEditingController,
            obscureText: widget.obscureTextField!,
            onChanged: (value) {
              widget.value = value;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xff8C8C8C),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              prefixIcon: Visibility(visible: true, child: widget.prefixIcon!),
              suffixIcon: widget.visible == true ? widget.suffixIcon : null,
              labelText: widget.labelText,
              hintText: widget.hintText,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xff7f39fb),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xff8C8C8C),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintStyle: TextStyle(
                color: const Color(0xff8C8C8C),
              ),
              floatingLabelStyle: TextStyle(
                color: const Color(0xff7f39fb),
              ),
              labelStyle: TextStyle(
                color: const Color(0xff8C8C8C),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
