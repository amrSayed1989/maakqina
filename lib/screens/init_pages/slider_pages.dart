// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:maak/models/init_page.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:maak/view_models/init_page_screen.dart';
import 'package:provider/provider.dart';

class SliderPagesWidget extends StatelessWidget {
  final InitPageScreenViewModel initPageViewModel;
  final List<Slide> mySlides = [];
  SliderPagesWidget({Key? key, required this.initPageViewModel})
      : super(key: key) {
    for (InitPage initPage in initPageViewModel.screens) {
      mySlides.add(
        new Slide(
          /// title
          marginTitle: EdgeInsets.only(top: 0),
          widgetTitle: Center(
            child: Column(
              children: [
                Container(
                  height: 55,
                  child: Text(
                    initPage.title ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 30,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  initPage.subTitle ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),

          /// description
          marginDescription: EdgeInsets.only(top: 5, left: 15, right: 15),
          description: initPage.desc ?? '',
          styleDescription: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600),

          /// image
          pathImage: initPage.image ?? '',
          widthImage: 300,
          heightImage: 300,
          backgroundColor: Colors.white,

          // backgroundColor: Colors.blueGrey,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IntroSlider(
        colorSkipBtn: AppColors.mainOrange,
        nameSkipBtn: "تخطي".tr(),
        styleSkipBtn: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textSliderButtons, // Color(0xffF15412)  ,
            fontFamily: 'Cairo'),
        // styleNameSkipBtn

        colorPrevBtn: AppColors.mainOrange,

        namePrevBtn: "التالي".tr(),
        stylePrevBtn: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textSliderButtons, // Color(0xffF15412)  ,
            fontFamily: 'Cairo'),

        // styleNamePrevBtn

        nameNextBtn: "التالي".tr(),
        // renderNextBtn:,

        colorDoneBtn: AppColors.mainOrange,
        nameDoneBtn: "انتهى".tr(),
        styleDoneBtn: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textSliderButtons, // Color(0xffF15412)  ,
            fontFamily: 'Cairo'),
        // styleNameDoneBtn

        showNextBtn: true,
        showPrevBtn: true,

        slides: this.mySlides,
        onDonePress: () async {
          initPageViewModel.setScreensDone();
        },
      ),
    );
  }
}
