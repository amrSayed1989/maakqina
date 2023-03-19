import 'package:flutter/material.dart';

class Go{
static to(BuildContext context,Widget page){
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              page));
}

static off(BuildContext context,Widget page){
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) =>
          page),(Route<dynamic> route) => false);
}
}