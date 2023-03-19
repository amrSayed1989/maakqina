import 'package:flutter/material.dart';

import 'image_from_server.dart';

class HomeSingleItemWidget extends StatelessWidget {

  final String image;
  final String name;
  const HomeSingleItemWidget({Key? key,required this.image,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      width: 140,
      child: Column(
        children: [
          Expanded(child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft:  Radius.circular(10),
            ),
              child: imageFromServer(imageUrl: image,fit: BoxFit.cover))),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(this.name,style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15
            ),),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
