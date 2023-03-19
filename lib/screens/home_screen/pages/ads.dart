// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/screens/account/login_page.dart';
import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/view_models/account.dart';
import 'package:maak/view_models/add_new_ad.dart';
import 'package:maak/view_models/ads_by_admin.dart';
import 'package:maak/view_models/ads_by_users.dart';
import 'package:maak/view_models/search/ads.dart';
import 'package:provider/provider.dart';

import '../../../view_models/init_app_viewmodel.dart';
import 'ads/add_new_ad.dart';
import 'ads/ads_by_admin.dart';
import 'ads/ads_by_users.dart';

class AdsPage extends StatefulWidget {
  AdsPage({Key? key}) : super(key: key);

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  Color _color1 = Color(0xFFe75f3f);
  Color _color2 = Color.fromARGB(255, 255, 250, 250);
  int currentPage = 0;

  PageController _pageController = PageController();
  SearchAdsViewModel viewModel = Get.put(SearchAdsViewModel());
  @override
  Widget build(BuildContext context) {
    // Get.find<MainAppViewModel>().openNotification();

    return Container(
      //end
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      currentPage = 0;
                    });
                    _pageController.animateToPage(0,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('إعلانات بيع',
                          //_color1 : _color2
                          style: TextStyle(
                              fontSize: 16,
                              color: (currentPage == 0 ? _color1 : _color2),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo')),
                    ),
                  ),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    setState(() {
                      currentPage = 1;
                    });
                    _pageController.animateToPage(1,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut);
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('طلبات شراء',
                          style: TextStyle(
                              fontSize: 16,
                              color: (currentPage == 0 ? _color2 : _color1),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo')),
                    ),
                  ),
                )),
              ],
            ),
            color: Colors.black,
          ),
          Container(color: Colors.white, height: 2),
          Expanded(
            child: Consumer<AdsByAdminViewModel>(
              //JobsViewModel
              builder: (_, jobsViewModel, child) {
                return Consumer<AdsByUsersViewModel>(
                    builder: (_, jobsOfferViewModel, child) {
                  //JobOffersViewModel
                  return PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      // setState(() => currentPage = index);
                    },
                    children: <Widget>[
                      AdsByUsersPage(),
                      AdsByAdminPage(),
                    ],
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
