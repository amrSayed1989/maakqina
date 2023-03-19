import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_scale.dart';

class WTextB5 extends StatelessWidget {
  final String text;

  const WTextB5(this.text);
  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .047,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ));
  }
}

class BTextB4 extends StatelessWidget {
  final String text;
  const BTextB4(this.text);
  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        Text(text,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .04,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )));
  }
}

class BText4 extends StatelessWidget {
  final String text;

  const BText4(this.text);
  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        Text(text,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .04,
              color: Colors.black,
            )));
  }
}

class BTextB3 extends StatelessWidget {
  final String text;

  const BTextB3(this.text);
  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        Text(text,
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .03,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )));
  }
}

class BTextB8 extends StatelessWidget {
  final String text;

  const BTextB8(this.text);
  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .07,
              fontWeight: FontWeight.bold,
              color: cLogoColor),
        ));
  }
}

class WTextB8 extends StatelessWidget {
  final String text;

  const WTextB8(this.text);
  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .07,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ));
  }
}

class BTextB6 extends StatelessWidget {
  final String text;

  const BTextB6(this.text);
  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .06,
              fontWeight: FontWeight.bold,
              color: cLogoColor),
        ));
  }
}

class WTextB6 extends StatelessWidget {
  final String text;

  const WTextB6(this.text);
  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .06,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ));
  }
}

class WTextB4 extends StatelessWidget {
  final String text;

  const WTextB4(this.text);
  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .04,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade100),
        ));
  }
}

class YTextB5 extends StatelessWidget {
  final String text;

  const YTextB5(this.text);
  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .05,
              fontWeight: FontWeight.bold,
              color: Colors.yellow),
        ));
  }
}

class GTextB5 extends StatelessWidget {
  final String text;

  const GTextB5(this.text);
  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .05,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent),
        ));
  }
}

class RTextB4 extends StatelessWidget {
  final String text;

  const RTextB4(this.text);
  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .05,
              fontWeight: FontWeight.bold,
              color: Colors.yellow),
        ));
  }
}

class BTextB5 extends StatelessWidget {
  final String text;

  const BTextB5(this.text);
  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        Text(
          text,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .05,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          textAlign: TextAlign.justify,
        ));
  }
}

class BText5 extends StatelessWidget {
  final String text;

  const BText5(this.text);
  @override
  Widget build(BuildContext context) {
    return textScale(
        context,
        Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .05,
              color: Colors.black),
        ));
  }
}

class RTextB5 extends StatelessWidget {
  final String text;

  const RTextB5(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * .047,
          fontWeight: FontWeight.bold,
          color: cLogoColor),
    );
  }
}
