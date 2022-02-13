// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CustomSigninButton extends StatelessWidget {
  String? title;
  IconData? iconData;
  bool? isIcon;
  String? imagePath;
  Color? color;
  Color? textColor;
  final void Function()? onTap;
  CustomSigninButton({
    Key? key,
    @required this.title,
    this.iconData,
    @required this.isIcon,
    this.imagePath,
    this.onTap,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 48.0, right: 48.0, top: 16.0),
      child: InkWell(
        onTap: () {
          onTap!();
        },
        child: Material(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          color: color,
          elevation: 8,
          child: Container(
            height: 48,
            width: double.infinity,
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              color: color,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 8, left: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isIcon == true
                      ? Icon(
                          iconData!,
                          color: textColor,
                        )
                      : Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(32),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(imagePath!),
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      title!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textColor!,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
