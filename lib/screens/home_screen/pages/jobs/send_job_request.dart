// ignore_for_file: unused_import, unused_local_variable

import 'dart:io';

import 'package:file_picker/file_picker.dart' as file_picker;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_extend/share_extend.dart';
import 'package:maak/utils/consts/lunching_file.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../utils/consts/lunching_file.dart';
import '../../../../utils/widgets/custom_app_bar.dart';
import '../../../../utils/widgets/loading_widget.dart';

class SendingJobRequestPage extends StatefulWidget {
  final String titleOfJob;
  final String ownerPhoneNumber;
  const SendingJobRequestPage(
      {Key? key, required this.titleOfJob, required this.ownerPhoneNumber})
      : super(key: key);

  @override
  State<SendingJobRequestPage> createState() => _SendingJobRequestPageState();
}

class _SendingJobRequestPageState extends State<SendingJobRequestPage> {
  var sendingData = false;
  List<File> f = [];
  String choosingCategory = '';
  String choosingCity = '';

  List<File> imagePath = [];
  List<File> cvPath = [];

  TextEditingController nameController = new TextEditingController();
  TextEditingController aboutController = new TextEditingController();
  TextEditingController detailsController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController experienceController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController phoneNumberController = new TextEditingController();
/////////////////////// maybe some day it will not send data ///////////////////////
//   String dateOfAdding = intl.DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: CustomAppBar(
            title: 'التقديم علي الوظيفة',
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('ارسل السيرة الذاتية',
                            // textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Cairo')),
                        SizedBox(height: 10),
                        GestureDetector(
                            onTap: () async {
                              f = [];
                              file_picker.FilePickerResult? result =
                                  await file_picker.FilePicker.platform
                                      .pickFiles(
                                allowMultiple: false,
                                type: file_picker.FileType.custom,
                                allowedExtensions: ['pdf', 'doc', 'png', 'jpg'],
                              );

                              // if (result != null) {
                              //   print("result.paths  =  " + result.paths[0]!);
                              //   f = result.paths
                              //       .map((path) => File(path!))
                              //       .toList();
                              //   print("result.paths  =  " + f[0].path);
                              //   setState(() {});
                              // }
                            },
                            child: Container(
                              // height: 50,
                              width: 60,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.green, width: 2),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 50,
                                  color: Colors.green,
                                ),
                              ),
                            )),
                        SizedBox(height: 10),
                        f.length > 0
                            ? Text(f[0].path.split('/').last,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Cairo'))
                            : SizedBox(),
                      ],
                    ),
                  ),
                  // SizedBox(height: 30),
                  Divider(
                    color: Colors.grey,
                  ),
                  Column(
                    children: [
                      Text('او تعبئة حقول المعلومات',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Cairo')),
                      SizedBox(height: 30),
                      field(
                          name: 'الاسم',
                          height: 50.0,
                          hint: 'ادخل اسمك ',
                          controller: nameController),
                      SizedBox(height: 10),
                      field(
                          name: 'نبذة',
                          hint: 'اكتب رسالتك هنا',
                          height: 5.0 * 24.0,
                          controller: aboutController,
                          maxLines: 7),
                      SizedBox(height: 10),
                      field(
                        name: 'سنوات الخبرة',
                        hint: '5 سنوات',
                        height: 50.0,
                        isNumber: true,
                        controller: experienceController,
                      ),
                      SizedBox(height: 10),
                      field(
                        name: 'السن',
                        hint: '30 سنة',
                        height: 50.0,
                        isNumber: true,
                        controller: ageController,
                      ),
                      SizedBox(height: 10),
                      field(
                        name: 'رقم الهاتف',
                        height: 50.0,
                        hint: 'ادخل رقم الهاتف',
                        isPhone: true,
                        controller: phoneNumberController,
                      ),
                      SizedBox(height: 10),
                      field(
                        name: 'البريد الالكتروني',
                        height: 50.0,
                        hint: 'ادخل الايميل ',
                        controller: emailController,
                      ),
                      SizedBox(height: 10),
                      field(
                          name: 'تفاصيل اخرى',
                          hint: 'اكتب رسالتك هنا',
                          height: 5.0 * 24.0,
                          controller: detailsController,
                          maxLines: 7),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            // color: Color(0xffF15412)  , //Colors.whit
                            onPressed: () async {
                              // print('sending file ------------------');
                              //if (f.isNotEmpty) {
                              //   print(
                              //       'sending file ------------------${f[0].path}');
                              //   // launchWhatsAppForFile(phone: '+201008301711',message: f[0].path);
                              //   //ShareExtend.share(f[0].path, "file");

                              // }
                              if (nameController.text != '' &&
                                  aboutController.text != '' &&
                                  detailsController.text != '' &&
                                  emailController.text != '' &&
                                  experienceController.text != '' &&
                                  ageController.text != '' &&
                                  phoneNumberController.text != '') {
                                try {
                                  showCupertinoModalPopup<void>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CupertinoActionSheet(
                                      title: Text('تواصل الان'),
                                      message: Text('تواصل مع مقدم الوظيفة'),
                                      actions: <CupertinoActionSheetAction>[
                                        CupertinoActionSheetAction(
                                          child: Text('ارسال بريد الكتروني'),
                                          onPressed: () {
                                            String jobTitle =
                                                'التقديم علي وظيفة : ${widget.titleOfJob}';
                                            String name =
                                                "الاسم : ${nameController.text}";
                                            String about =
                                                "عني : ${aboutController.text}";
                                            String details =
                                                "التفاصيل : ${detailsController.text}";
                                            String experience =
                                                "الخبرة : ${experienceController.text}";
                                            String age =
                                                "العمر : ${ageController.text}";
                                            String email =
                                                "البريد الالكتروني : ${emailController.text}";
                                            String phoneNumber =
                                                "رقم الجوال : ${phoneNumberController.text}";

                                            // String text =
                                            //     "$jobTitle\n$name\n$about\n$details\n$experience\n$age\n$email\n$phoneNumber\n$f.path";

                                            _sendEmailWithSubject(
                                                'test@email.com',
                                                '$jobTitle\n$name\n$about\n$details\n$experience\n$age\n$email\n$phoneNumber\n$f.path');

                                            Fluttertoast.showToast(
                                                msg: '[جاري تنفيذ طلبك الان]',
                                                toastLength:
                                                    Toast.LENGTH_SHORT);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Text('اتصال واتساب'),
                                          onPressed: () {
                                            String jobTitle =
                                                'التقديم علي وظيفة : ${widget.titleOfJob}';
                                            String name =
                                                "الاسم : ${nameController.text}";
                                            String about =
                                                "عني : ${aboutController.text}";
                                            String details =
                                                "التفاصيل : ${detailsController.text}";
                                            String experience =
                                                "الخبرة : ${experienceController.text}";
                                            String age =
                                                "العمر : ${ageController.text}";
                                            String email =
                                                "البريد الالكتروني : ${emailController.text}";
                                            String phoneNumber =
                                                "رقم الجوال : ${phoneNumberController.text}";

                                            String text =
                                                "$jobTitle\n$name\n$about\n$details\n$experience\n$age\n$email\n$phoneNumber\n";

                                            launchWhatsApp(
                                                phone: widget.ownerPhoneNumber,
                                                message: text);
                                            Fluttertoast.showToast(
                                                msg:
                                                    'جاري تحويلك الان لارسال الرسالة',
                                                toastLength:
                                                    Toast.LENGTH_SHORT);
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ),
                                  );

                                  //

                                  // await launch(

                                  print('asdasdasdasdasdasdasdasdasdasadasd');
                                  // print('sending file ------------------');
                                  // print(
                                  //     'sending file ------------------${f[0].path}');

                                  // );
                                } catch (e) {
                                  print(e);
                                }

                                //     ));

                              } else {
                                print('you should enter all of these things');

                                showDialog(
                                    context: context,
                                    builder: (context) => new AlertDialog(
                                          title: new Text(
                                            "رسالة تنبية",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Cairo'),
                                          ),
                                          content: new Text(
                                            "يجب ادخال كل المعلومات المطلوبة او ارسال السيرة الذاتية",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Cairo'),
                                          ),
                                          actions: [
                                            Center(
                                                // ignore: deprecated_member_use
                                                child: FlatButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'رجوع',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontFamily: 'Cairo'),
                                                    )))
                                          ],
                                        ));
                              }
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
                ],
              ),
            ),
          ),
        ),
        sendingData
            ? Container(
                child: UpLoadingWidget(),
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.5),
              )
            : SizedBox()
      ],
    );
  }

  Widget field(
      {@required name,
      hint,
      height,
      @required controller,
      int maxLines = 1,
      isNumber = false,
      isPhone = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 24.0),
          child: Text(
            name,
            textAlign: TextAlign.start,
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
                keyboardType: isNumber
                    ? TextInputType.number
                    : isPhone
                        ? TextInputType.phone
                        : TextInputType.text,
                controller: controller,
                maxLines: maxLines,
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

//$jobTitle\n$name\n$about\n$details\n$experience\n$age\n$email\n$phoneNumber\n
  Future<void> _sendEmailWithSubject(String url, String subject) async {
    Uri emailLaunchUri =
        Uri(scheme: 'mailto', path: url, queryParameters: {'subject': subject});

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      throw 'Could not launch ' + emailLaunchUri.toString();
    }
  }
}
