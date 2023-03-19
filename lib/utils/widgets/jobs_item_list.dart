// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:maak/models/job.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../consts/share.dart';
import 'image_from_server.dart';
//

import 'package:get/get.dart';

import 'package:maak/screens/home_screen/pages/jobs/single_requested_job.dart';

import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/view_models/requested_job_view_model.dart';
import 'package:provider/provider.dart';

import '../../screens/account/login_page.dart';
import '../../view_models/account.dart';
import '../../view_models/init_app_viewmodel.dart';

class JobItemWidget extends StatelessWidget {
  final Job job;
  final Function() onClick;
  JobItemWidget({Key? key, required this.job, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                  child: Container(
                      height: 105,
                      child: imageFromServer(imageUrl: job.jobImage)),
                )),
            SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job.titleOfJob,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: AppColors.mainOrange,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Cairo')),
                  Text(job.nameOfSpecialist,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Cairo')),
                  Text(job.dateOfAddingJob,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Cairo')),
                  Text(job.cityName,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Cairo')),
                ],
              ),
            ),
            Container(
              height: 105,
              padding:
                  const EdgeInsets.only(left: 4, top: 4, bottom: 4, right: 4),
              decoration: BoxDecoration(
                color: AppColors.mainOrange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      MainAppViewModel mainApp = Get.find();
                      if (!mainApp.isLogged) {
                        Go.to(
                            context,
                            ChangeNotifierProvider(
                              create: (_) => AccountViewModel(),
                              child: LoginPage(
                                onLoginComplete: () {
                                  Go.to(
                                      context,
                                      ChangeNotifierProvider(
                                        create: (BuildContext context) {
                                          return;
                                        },
                                        child: RequestedJobPage(),
                                      ));
                                },
                              ),
                            ));
                        return;
                      }
                      shareJobWith(
                          email: '',
                          title: job.titleOfJob,
                          phone: job.whatsappNumber,
                          city: job.cityName,
                          about: job.details,
                          nameOfSpecialist: job.nameOfSpecialist);

                      // Share.share(' title Of Job : ${snapshot.data[0][index].titleOfJob} \n '
                      //     'details Of Job  : ${snapshot.data[0][index].detailsOfJob} \n '
                      //     'email  : ${snapshot.data[0][index].email} \n '
                      //     'city : ${snapshot.data[0][index].city}  \n'
                      //     'nameOfSpecialist : ${snapshot.data[0][index].nameOfSpecialist}  \n'
                      //     ' phoneNumber : ${snapshot.data[0][index].phoneNumberWhatsUp} \n\n\n'
                      //     'link of the app on google play :          https://play.google.com/store/apps/details?id=com.zakhoi.egyptian_ads_app\n\n'
                      //     'link of the app on app store :   https://apps.apple.com/us/app/id1573237241');
                    },
                    child: ClipOval(
                      child: Container(
                        width: 30,
                        height: 30,
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.share,
                          // color: Colors.grey,
                          color: Color(0xffF15412), //Colors.whit

                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      MainAppViewModel mainApp = Get.find();
                      if (!mainApp.isLogged) {
                        Go.to(
                            context,
                            ChangeNotifierProvider(
                              create: (_) => AccountViewModel(),
                              child: LoginPage(
                                onLoginComplete: () {
                                  Go.to(
                                      context,
                                      ChangeNotifierProvider(
                                        create: (BuildContext context) {
                                          return;
                                        },
                                        child: RequestedJobPage(),
                                      ));
                                },
                              ),
                            ));
                        return;
                      }

                      launch("tel://${job.whatsappNumber}");
                    },
                    child: ClipOval(
                      child: Container(
                        width: 30,
                        height: 30,
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.phone,
                          // color: Colors.grey,
                          color: Color(0xffF15412), //Colors.whit

                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
