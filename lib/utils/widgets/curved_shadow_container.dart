import 'package:flutter/material.dart';

class CurvedShadowedContainer extends StatelessWidget {

  final Widget child;
  CurvedShadowedContainer({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
        //   borderRadius: BorderRadius.circular(5),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius:0.5,
        //     blurRadius: 1,
        //     offset: Offset(0, 0), // changes position of shadow
        //   ),
        // ],
      ),
    );
  }
}
