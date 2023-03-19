// ignore_for_file: unused_import, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maak/utils/consts/lunching_file.dart';
import 'package:maak/utils/widgets/custom_app_bar.dart';
// import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class SuggestionPage extends StatelessWidget {
  final TextEditingController n1controller = new TextEditingController();
  final TextEditingController n2controller = new TextEditingController();
  final TextEditingController n3controller = new TextEditingController();
  final TextEditingController n4controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'الشكاوي و الاقتراحات',
      ),
      body: Container(
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 20),
            field(
                name: 'الاسم',
                height: 55.0,
                hint: 'ادخل اسمك ',
                controller: n1controller),
            SizedBox(height: 10),
            field(
                name: 'رقم الهاتف',
                height: 55.0,
                hint: 'ادخل رقم الهاتف',
                controller: n2controller),
            SizedBox(height: 10),
            field(
                name: 'البريد الالكتروني',
                height: 55.0,
                hint: 'ادخل الايميل ',
                controller: n3controller),
            SizedBox(height: 10),
            field(
                name: 'الرسالة',
                hint: 'اكتب رسالتك هنا',
                height: 7.0 * 24.0,
                mmaxLines: 7,
                controller: n4controller),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 45,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  color: Color(0xffF15412),
                  onPressed: () async {
                    launchWhatsApp(
                        phone: "+201066691664",
                        message:
                            'name:${n1controller.text}\nphone:${n2controller.text}\nemail:${n3controller.text}\nmessage:${n4controller.text}');
                  },
                  child: Text(
                    'ارسال',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: 'Cairo'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget field(
      {@required name, hint, height, @required controller, mmaxLines = 1}) {
    Function controllerOnChanged;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Text(
            name,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'Cairo'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: controller,
                maxLines: mmaxLines,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.amber,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
