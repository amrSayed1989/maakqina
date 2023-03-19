import 'package:flutter/material.dart';

class SectionHeaderWidget extends StatelessWidget {

  final String titleHeader;
  final Function ()onClick;

  const SectionHeaderWidget({Key? key,
    required this.titleHeader,
    required this.onClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:8),
              child: Text(titleHeader,style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Spacer(),
            // InkWell(
            //   onTap: onClick,
            //   child: Row(
            //     children: [
            //       Text(tr('more'),style: TextStyle(
            //           fontSize: 15,
            //           fontWeight: FontWeight.bold
            //       ),),
            //       Icon(Icons.arrow_forward_ios),
            //     ],
            //   ),
            // )

          ],
        ),
      ),
    );
  }
}
