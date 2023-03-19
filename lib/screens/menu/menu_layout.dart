// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:maak/models/color.dart';
import 'package:maak/screens/account/login_page.dart';

import 'package:maak/screens/menu/complains.dart';
import 'package:maak/screens/menu/policy.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/view_models/account.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:maak/screens/menu/rate_us.dart';
import 'package:provider/provider.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:get/get.dart';
import 'about.dart';
import 'contact_us.dart';
import 'notifications.dart';

class MenuPage extends StatelessWidget {
  MenuPage({Key? key, required this.sideMenuKey}) : super(key: key);
  final GlobalKey<SideMenuState> sideMenuKey;
  @override
  Widget build(BuildContext context) {
    MainAppViewModel initAppViewModel = Get.find();

    return Container(
      child: Obx(() => Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.white,
                    ),
                  )),

              Text(
                'مرحبا بكم',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                initAppViewModel.userName,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (initAppViewModel.isLogged) {
                      if (await initAppViewModel.logoutUser()) {
                        await initAppViewModel.userService.value.removeUser();
                        // initAppViewModel.isLogged = false;
                      }
                    } else {
                      Go.to(
                          context,
                          ChangeNotifierProvider(
                            create: (_) => AccountViewModel(),
                            child: LoginPage(
                              onLoginComplete: () {},
                            ),
                          ));
                    }
                    sideMenuKey.currentState!.closeSideMenu();
                  },
                  child: Text(
                    initAppViewModel.isLogged ? 'تسجيل خروج' : 'تسجيل الدخول',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              initAppViewModel.isLogged
                  ? InkWell(
                      onTap: () async {
                        await initAppViewModel.deleteUseAccount();
                        sideMenuKey.currentState!.closeSideMenu();
                        Get.snackbar("حذف الحساب", "سوف يتم حذف حسابك");
                      },
                      child: Text(
                        'حذف الحساب',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  : SizedBox(),
              SizedBox(
                height: 0,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 8.0),
              //   child: Divider(
              //     color: Colors.white.withOpacity(0.5),
              //     thickness: 0,
              //   ),
              // ),
              // initAppViewModel.isLogged ? InkWell(
              //   onTap: (){
              //     Go.to(context, NotificationsPage());
              //     sideMenuKey.currentState!.closeSideMenu();
              //   },
              //   child: Container(
              //     color: Colors.white10.withOpacity(0.15),
              //     child: Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: Row(
              //         children: [
              //           Icon(Icons.notifications,color: Colors.white),
              //           SizedBox(
              //             width: 16,
              //           ),
              //           Text(
              //             'الاشعارات',
              //             style: TextStyle(
              //                 fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              //           ),
              //         ],
              //       ),
              //     ),
              //
              //   ),
              // ) : SizedBox(),
              initAppViewModel.isLogged
                  ? SizedBox(
                      height: 8,
                    )
                  : SizedBox(),
              InkWell(
                onTap: () {
                  Go.to(context, ContactUsPage());
                  sideMenuKey.currentState!.closeSideMenu();
                },
                child: Container(
                  color: Colors.white10.withOpacity(0.15),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(Icons.email, color: Colors.white),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'تواصل معنا',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  Go.to(context, SuggestionPage());
                  sideMenuKey.currentState!.closeSideMenu();
                },
                child: Container(
                  color: Colors.white10.withOpacity(0.15),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(Icons.assignment, color: Colors.white),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'الشكاوى والإقتراحات',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  Go.to(context, PrivacyPolicy());
                  sideMenuKey.currentState!.closeSideMenu();
                },
                child: Container(
                  color: Colors.white10.withOpacity(0.15),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(Icons.policy, color: Colors.white),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'سياسة الاستخدام',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  Go.to(context, AboutTheApp());
                  sideMenuKey.currentState!.closeSideMenu();
                },
                child: Container(
                  color: Colors.white10.withOpacity(0.15),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(Icons.info, color: Colors.white),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'عن التطبيق',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: () {
                  Go.to(context, RateUs());
                  sideMenuKey.currentState!.closeSideMenu();
                },
                child: Container(
                  color: Colors.white10.withOpacity(0.15),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(Icons.rate_review, color: Colors.white),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'قيمنا',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              // //
              // InkWell(
              //   onTap: () {
              //     Go.to(context, RateUs());
              //     sideMenuKey.currentState!.closeSideMenu();
              //   },
              //   child: Container(
              //     color: Colors.white10.withOpacity(0.15),
              //     child: Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: Row(
              //         children: [
              //           Icon(Icons.read_more, color: Colors.white),
              //           SizedBox(
              //             width: 16,
              //           ),
              //           Text(
              //             'علمني',
              //             style: TextStyle(
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.bold,
              //                 color: Colors.white),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 8,
              // ),
              //تحديثات
              SizedBox(
                height: 110,
              ),
              Container(
                child: Text(
                  "Version 7.7.8",
                  style: TextStyle(
                    color: AppColors.textSliderButtons,
                    fontSize: 13,
                  ),
                ),
              ),
              Container(
                child: Text(
                  "© 2018 - 2022 Bramj",
                  style: TextStyle(
                    color: AppColors.textSliderButtons,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
