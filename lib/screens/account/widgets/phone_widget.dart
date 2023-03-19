// ignore_for_file: unused_import

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:provider/provider.dart';

class PhoneWidget extends StatelessWidget {
  final TextEditingController phoneController;
  const PhoneWidget({Key? key, required this.phoneController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainAppViewModel initAppViewModel = Get.find();
    return Row(
      children: [
        Container(
          height: 55,
          // width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(color: Colors.grey, spreadRadius: 1),
            ],
          ),
          child: Container(
            child: CountryCodePicker(
              onInit: (value) {
                initAppViewModel.countryCode = value.toString();
              },
              onChanged: (value) {
                // sharedData.countryCode = value.toString();
                initAppViewModel.countryCode = value.toString();
              },
              // padding: EdgeInsets.symmetric(horizontal: 4),
              textStyle: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              initialSelection: 'EG',
              favorite: ['EG'],
            ),
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Container(
            height: 55,
            child: TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: Colors.grey)),
                filled: true,
                fillColor: Colors.grey[100],
                hintText: "ادخل رقمك",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              controller: phoneController,
            ),
          ),
        ),
      ],
    );
  }
}
