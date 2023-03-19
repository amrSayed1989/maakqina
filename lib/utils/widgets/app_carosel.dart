// ignore_for_file: unnecessary_import

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maak/models/image.dart';

import 'image_from_server.dart';

class AppCarousel extends StatefulWidget {
  final List<AppImage> images;
  final double height = 250;
  final bool showGradientUpper;
  final bool autoPlay;

  AppCarousel(
      {Key? key,
      required this.images,
      this.showGradientUpper = false,
      this.autoPlay = true})
      : super(key: key);

  @override
  State<AppCarousel> createState() => _AppCarouselState();
}

class _AppCarouselState extends State<AppCarousel> {
  int currentIndex = 0;
  CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: controller,
          options: CarouselOptions(
              height: widget.height,
              initialPage: currentIndex,
              viewportFraction: 1,
              autoPlayInterval: Duration(seconds: 5),
              autoPlay: widget.autoPlay,
              aspectRatio: 2,
              onPageChanged: (index, pagedChange) {
                currentIndex = index;
                setState(() {});
              }),
          items: widget.images.map((e) {
            return Container(
                height: widget.height,
                child:
                    imageFromServer(imageUrl: e.imageUrl, fit: BoxFit.cover));
          }).toList(),
        ),
        Container(
          width: double.infinity,
          height: widget.showGradientUpper ? 100 : 0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
              colors: <Color>[
                Colors.black,
                Colors.transparent
              ], // red to yellow
              tileMode: TileMode.clamp, // repeats the gradient over the canvas
            ),
            boxShadow: [
              // BoxShadow(
              //   color: AppColors.mainOrrrange.withOpacity(1),
              //   spreadRadius: 5,
              //   blurRadius: 7,
              //   offset: Offset(0, 3), // changes position of shadow
              // ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.images.map((e) {
                  int index = widget.images.indexOf(e);
                  return InkWell(
                    onTap: () {
                      controller.jumpToPage(index);
                      currentIndex = index;
                      setState(() {});
                    },
                    child: AnimatedContainer(
                        height: currentIndex == index ? 25 : 35,
                        width: currentIndex == index ? 25 : 35,
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        duration: Duration(milliseconds: 300),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: imageFromServer(
                                imageUrl: e.imageUrl, fit: BoxFit.cover))),
                  );
                }).toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
