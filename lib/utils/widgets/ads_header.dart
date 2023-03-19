// ignore_for_file: unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:maak/models/ads/ad_sub_category.dart';
import 'package:maak/models/city.dart';

import '../../models/ads/ad_category.dart';

class AdsHeaderWidget extends StatelessWidget {
  City? city;
  // AdSubCategory? selectedAdSubCategory;
  AdCategory? selectedCategory;
  final Function() onChangeCity;
  final Function() onCategoryChanged;

  AdsHeaderWidget(
      {Key? key,
      required this.selectedCategory,
      required this.city,
      required this.onChangeCity,
      required this.onCategoryChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80,
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  InkWell(
                    onTap: onChangeCity,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)),
                      child: Icon(
                        Icons.location_city,
                        // color: Colors.white,
                        color: Color(0xffF15412),

                        size: 25,
                      ),
                    ),
                  ),
                  Text(city?.name ?? 'كل المدن',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Cairo')),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  InkWell(
                    onTap: onCategoryChanged,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)),
                      child: Icon(
                        Icons.campaign,
                        color: Color(0xffF15412),
                        size: 25,
                      ),
                    ),
                  ),
                  Text(selectedCategory?.name ?? 'تصنيف الاعلانات',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Cairo')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
