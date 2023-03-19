// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/news.dart';
import 'package:maak/screens/home_screen/pages/ads/show_single_ad.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/view_models/show_single_ad.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screens/account/login_page.dart';
import '../../view_models/account.dart';
import '../../view_models/init_app_viewmodel.dart';
import '../consts/navigation.dart';
import '../consts/share.dart';
import 'image_from_server.dart';

class AdsItemWidget extends StatelessWidget {
  final News news;
  AdsItemWidget({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          MainAppViewModel mainApp = Get.find();
          if (!mainApp.isLogged) {
            Go.to(
                context,
                ChangeNotifierProvider(
                  create: (_) => AccountViewModel(),
                  child: LoginPage(
                    onLoginComplete: () {
                      Get.to(() => ChangeNotifierProvider(
                            create: (_) => ShowSingleAdViewModel(news.id),
                            child: ShowSingleAdPage(),
                          ));
                    },
                  ),
                ));
            return;
          }
          Get.to(() => ChangeNotifierProvider(
                create: (_) => ShowSingleAdViewModel(news.id),
                child: ShowSingleAdPage(),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
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
                          child: imageFromServer(imageUrl: news.firstImage)),
                    )),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(news.name,
                            style: TextStyle(
                                color: AppColors.mainOrange,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Cairo')),
                        Text(news.price + " ج.م ",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Cairo')),
                        Text(news.dateOffAdding,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Cairo')),
                        Text(news.cityName,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Cairo')),
                      ],
                    )),
                Container(
                  height: 105,
                  padding: const EdgeInsets.only(
                      left: 4, top: 4, bottom: 4, right: 4),
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
                                      Get.to(() => ChangeNotifierProvider(
                                            create: (_) =>
                                                ShowSingleAdViewModel(news.id),
                                            child: ShowSingleAdPage(),
                                          ));
                                    },
                                  ),
                                ));
                            return;
                          }
                          print('sddasdasd');
                          shareContentWith(
                              title: news.name,
                              about: news.details,
                              phone: news.phoneNumber,
                              city: news.cityName);
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
                                      Get.to(() => ChangeNotifierProvider(
                                            create: (_) =>
                                                ShowSingleAdViewModel(news.id),
                                            child: ShowSingleAdPage(),
                                          ));
                                    },
                                  ),
                                ));
                            return;
                          }

                          launch("tel://${news.phoneNumber}");
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
        ));
  }
}
