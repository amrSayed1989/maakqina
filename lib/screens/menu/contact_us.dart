// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/lunching_file.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'تواصل معنا',
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.greyBackground,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Spacer(),
              Text(
                'يمكنكم التواصل معنا من خلال',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      println('lklklklklklklk----------------------');
                      const url =
                          'https://www.facebook.com/%D9%85%D8%B9%D8%A7%D9%83-107257051580331';
                      // if (await canLaunch(url)) {
                      await launch(url);
                      // } else {
                      //   throw 'Could not launch $url';
                      // }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => AppColors.mainOrange)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'assets/images/f_icon.png',
                        color: Colors.white,
                        height: 35,
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      launch(('tel://+201066691664'));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.red)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                        size: 35,
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      launchWhatsApp(
                          phone: '+201066691664',
                          message: 'مرحبا، اريد مساعدتكم!');
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.green)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'assets/images/whatsapp.png',
                        color: Colors.white,
                        height: 35,
                      ),
                    )),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/poweredBy.png',
                    height: 35,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text('Powered by Bramj'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
