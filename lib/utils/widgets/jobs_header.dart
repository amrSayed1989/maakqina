import 'package:flutter/material.dart';
import 'package:maak/models/city.dart';

class JobsHeaderWidget extends StatelessWidget {
  final City? city;
  final String? career;
  final Function() onChangeCity;
  final Function() onCareerChanged;

  JobsHeaderWidget(
      {Key? key,
      required this.city,
      required this.onChangeCity,
      required this.onCareerChanged,
      required this.career})
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
                    onTap: onCareerChanged,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white)),
                      child: Icon(
                        Icons.work,
                        color: Color(0xffF15412),
                        size: 25,
                      ),
                    ),
                  ),
                  Text(career ?? 'الكل',
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
