import 'package:flutter/material.dart';
import 'package:maak/utils/consts/app_colors.dart';

class LoadingWidget extends StatelessWidget {

  final Color color;
   LoadingWidget({Key? key,this.color =  AppColors.mainOrange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(color)));
  }
}

class UpLoadingWidget extends StatelessWidget {

  final Color color;
  UpLoadingWidget({Key? key,this.color =  AppColors.mainOrange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(color)),
        ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15)
      ),
            
    ));
  }
}
