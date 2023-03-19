// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/screens/account/login_page.dart';
import 'package:maak/screens/menu/contact_us.dart';
import 'package:maak/utils/consts/lunching_file.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/widgets/alert_deialog.dart';
import 'package:maak/utils/widgets/curved_shadow_container.dart';
import 'package:maak/utils/widgets/custom_app_bar.dart';
import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/view_models/account.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:maak/view_models/requested_job_view_model.dart';
import 'package:provider/provider.dart';

class RequestedJobPage extends StatelessWidget {
  const RequestedJobPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestedJobViewModel>(builder: (_, viewModel, child) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'تفاصيل المقدم علي وظيفة',
        ),
        body: Container(
          color: AppColors.greyBackground,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0.5,
                                    blurRadius: 1,
                                    offset: Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(100)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: imageFromServer(
                                    imageUrl: viewModel.job.imageUrl)),
                          ),
                        ),
                        CurvedShadowedContainer(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("الاسم" + " :",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.mainOrange,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text('${viewModel.job.nameOfPerson}',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Cairo')),
                                  )
                                ]),
                            Divider(),
                            // Container(width: double.infinity,height: 0.5,color: Colors.black.withOpacity(0.1),margin: const EdgeInsets.symmetric(vertical: 2.0) ,),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("الوظيفة" + " :",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.mainOrange,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    child: Text(viewModel.job.specialist,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Cairo')),
                                  ),
                                ]),
                            Divider(),
                            // Container(width: double.infinity,height: 0.5,color: Colors.black.withOpacity(0.1),margin: const EdgeInsets.symmetric(vertical: 2.0) ,),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("العمر" + " :",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.mainOrange,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(viewModel.job.age,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Cairo')),
                                  ),
                                ]),
                            // Container(width: double.infinity,height: 0.5,color: Colors.black.withOpacity(0.1),margin: const EdgeInsets.symmetric(vertical: 2.0) ,),
                            Divider(),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("سنوات الخبرة" + " :",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.mainOrange,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    child: Text(viewModel.job.yearsOfExperience,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Cairo')),
                                  ),
                                ]),
                            // Container(width: double.infinity,height: 0.5,color: Colors.black.withOpacity(0.1),margin: const EdgeInsets.symmetric(vertical: 2.0) ,),
                            Divider(),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("المدينة" + " :",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.mainOrange,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Text(viewModel.job.cityName,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Cairo')),
                                  ),
                                ])
                          ],
                        )),
                        SizedBox(
                          height: 1,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: CurvedShadowedContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('نبذة :',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.mainOrange,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Cairo')),
                                Padding(
                                  padding: const EdgeInsets.only(right: 18.0),
                                  child: Text(viewModel.job.about,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                ),
                                Divider(),
                                Text('تفاصيل اكثر :',
                                    style: TextStyle(
                                        // decoration: TextDecoration.underline,
                                        fontSize: 14,
                                        color: AppColors.mainOrange,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Cairo')),
                                Padding(
                                  padding: const EdgeInsets.only(right: 18.0),
                                  child: Text(viewModel.job.details,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Cairo')),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('تحميل الـسيرة الذاتية للمقدم',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.mainOrange,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Cairo')),
                      Spacer(),
                      GestureDetector(
                          onTap: () async {
                            MainAppViewModel mainApp = Get.find();
                            if (!mainApp.isLogged) {
                              Go.to(
                                  context,
                                  ChangeNotifierProvider(
                                    create: (_) => AccountViewModel(),
                                    child: LoginPage(
                                      onLoginComplete: () async {
                                        var done =
                                            await launchUrl(viewModel.job.cv);
                                        if (!done) {
                                          alertErrorDialog(
                                              'لا توجد سيرة ذاتية متاحة');
                                        }
                                      },
                                    ),
                                  ));
                            } else {
                              var done = await launchUrl(viewModel.job.cv);
                              if (!done) {
                                alertErrorDialog('لا توجد سيرة ذاتية متاحة');
                              }
                            }
                          },
                          child: Icon(
                            Icons.cloud_download,
                            size: 35,
                          )),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  // color: Color(0xffF15412)  , //Colors.whit
                  onPressed: () {
                    MainAppViewModel mainApp = Get.find();
                    if (!mainApp.isLogged) {
                      Go.to(
                          context,
                          ChangeNotifierProvider(
                            create: (_) => AccountViewModel(),
                            child: LoginPage(
                              onLoginComplete: () {},
                            ),
                          ));
                    } else {
                      alertPromptDialog(
                          errorMsg: 'تواصل الان مع طالب الوظيفة',
                          title: 'تواصل الان',
                          child: SizedBox(
                            // width: double.infinity,
                            child: Wrap(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                    launchEmailApp(
                                        toMailId: viewModel.job.email,
                                        subject: 'اكتب عنوان الرسالة هنا',
                                        body: 'اكتب رسالتك هنا');
                                  },
                                  child: Container(
                                    // width: double.infinity,
                                    child: Center(
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 45),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.email,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'ارسال بريد الكتروني',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ))),
                                    decoration: BoxDecoration(
                                      color: AppColors.mainOrange,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                  height: 6,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                    launchPhoneCall(
                                        '${viewModel.job.phoneNumber}');
                                  },
                                  child: Container(
                                    // width: double.infinity,
                                    child: Center(
                                        child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0, horizontal: 45),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'اتصال هاتفي',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ))),
                                    decoration: BoxDecoration(
                                      color: AppColors.mainOrange,
                                      // borderRadius: BorderRadius.only(
                                      //   topLeft: Radius.circular(15),
                                      //   topRight: Radius.circular(15),
                                      // ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                  height: 6,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    // width: double.infinity,
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3.0, horizontal: 45),
                                      child: Text(
                                        'إغلاق',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    }
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => AdsCVJobsAvailablePage( whatsApp : snapshot.data[7], email : snapshot.data[6] , titleOfJob :snapshot.data[0])));
                  },
                  child: Center(
                    child: Text(
                      'تواصل الان',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Cairo'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
