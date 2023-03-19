import 'package:flutter/material.dart';

class CircularWidget extends StatelessWidget {

  final double width;
  final Widget child;
   CircularWidget({Key? key, required this.child,required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: SizedBox(
            width: width,
            height: width,
            child: child
        ),
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius:0.5,
              blurRadius: 1,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
          border: Border.all(color: Colors.white,width: 2),
          borderRadius: BorderRadius.circular(width)),

    );
  }
}
