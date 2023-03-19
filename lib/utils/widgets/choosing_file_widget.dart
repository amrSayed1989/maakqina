import 'package:flutter/material.dart';
import 'package:maak/utils/consts/app_colors.dart';

Widget choosingFieldWidget(String text,{bool loading = false}) {
  return Container(
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontFamily: 'Cairo'),
          ),
        ),
        Spacer(),
        Container(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child:loading ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white)) : Text(
              'اضغط هنا',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Cairo'),
            ),
          ),
          decoration: BoxDecoration(color: AppColors.mainOrange),
        ),
      ],
    ),
    decoration: BoxDecoration(
        border: Border.all(color: AppColors.mainOrange, width: 1),
        borderRadius: BorderRadius.circular(5)),
  );
}