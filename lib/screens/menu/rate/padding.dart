import 'package:flutter/material.dart';

class DPadding extends StatelessWidget {
  final double val;
  final Widget child;
  const DPadding({this.val = .02, required this.child});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double horizontal = size.width * val;
    return Padding(
      padding: EdgeInsets.all(horizontal),
      child: child,
    );
  }
}

class SPadding extends StatelessWidget {
  final double h, v;
  final Widget child;
  const SPadding({required this.h, required this.v, required this.child});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double horizontal = size.width * h;
    double vertical = size.width * v;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: child,
    );
  }
}
