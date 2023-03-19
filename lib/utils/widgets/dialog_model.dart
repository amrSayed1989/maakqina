// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../consts/app_colors.dart';

class DialogModel extends StatelessWidget {
  final String buttonRightText;
  final String buttonLeftText;
  final String title;
  final Function() buttonRightOnPress;
  final Function() buttonLeftOnPress;
  final Widget content;
  final double height;

  DialogModel({
    required this.content,
    required this.title,
    required this.buttonLeftOnPress,
    required this.buttonLeftText,
    required this.buttonRightOnPress,
    required this.buttonRightText,
    this.height = 400,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: content,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  onPressed: buttonRightOnPress,
                  child: Text(
                    buttonRightText,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                FlatButton(
                  onPressed: buttonLeftOnPress,
                  child: Text(
                    buttonLeftText,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class AlertModel extends StatelessWidget {
  final String title;
  final String text;
  final Function() onPressed;

  AlertModel({
    required this.onPressed,
    required this.text,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        actions: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.topLeft,
              child: FlatButton(
                onPressed: onPressed,
                child: Text(
                  'حسنا',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.mainOrange,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo'),
                ),
              ),
            ),
          ),
        ],
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cairo'),
        ),
        content: Text(
          text,
          style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: 'Cairo'),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
