// ignore_for_file: unused_element

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:maak/model_services/offer_controller.dart';
import 'package:maak/screens/account/login_page.dart';
import 'package:maak/screens/home_screen/pages/places/place_page.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/navigation.dart';

import 'package:maak/utils/widgets/image_from_server.dart';
import 'package:maak/utils/widgets/loading_widget.dart';
import 'package:maak/utils/widgets/home_single_item_widget.dart';
import 'package:maak/utils/widgets/section_header.dart';
import 'package:maak/screens/home_screen/pages/offers/offer_page.dart';
import 'package:maak/view_models/account.dart';
import 'package:maak/view_models/home_page_viewmodel.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:maak/view_models/offer_view_model.dart';
import 'package:maak/view_models/place_view_model.dart';
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainAppViewModel initAppViewModel = Get.find<MainAppViewModel>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Get.find<MainAppViewModel>().openNotification();

    // @override
    // void dispose() {
    //   // _pageController.a
    //   super.dispose();
    // }

    @override
    initState() {
      super.initState();
      //_checkVersion();
      _showVersionChecker(context);
    }

    return Consumer<HomePageViewModel>(
      builder: (_, viewModel, child) {
        return SingleChildScrollView(
          child: viewModel.isLoading
              ? Center(
                  child: Container(
                      height: size.height - 100, child: LoadingWidget()),
                )
              : viewModel.noDataForMainPage
                  ? Center(
                      child: Container(
                          height: size.height - 100,
                          child: Center(
                              child: Text(
                            'لا توجد بيانات',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))),
                    )
                  : Container(
                      color: AppColors.greyBackground,
                      child: Column(
                        children: [
                          // AppCarousel(images: viewModel.homeSliderImages.data!,showGraduentUpper: false,height: 250,),
                          Container(
                            height: 190,
                            child: (viewModel
                                        .homeSliderImages.data?.isNotEmpty ??
                                    false)
                                ? CarouselSlider(
                                    options: CarouselOptions(
                                        height: 190,
                                        viewportFraction: 1,
                                        autoPlayInterval: Duration(seconds: 5),
                                        autoPlay: true,
                                        aspectRatio: 2),
                                    items: viewModel.homeSliderImages.data
                                        ?.map((e) {
                                      return imageFromServer(
                                          imageUrl: e.imageUrl,
                                          fit: BoxFit.cover);
                                    }).toList(),
                                  )
                                : Center(
                                    child: Text(
                                      'لا توجد اعلانات',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Container(
                            child: Column(
                              children: [
                                SectionHeaderWidget(
                                  titleHeader: tr('مشاريع جديدة'),
                                  onClick: () {},
                                ),
                                Container(
                                  width: double.infinity,
                                  // color: AppColors.greyBackground,
                                  height: 160,
                                  child: viewModel.places.places.isNotEmpty
                                      ? ListView(
                                          scrollDirection: Axis.horizontal,
                                          children:
                                              viewModel.places.places.map((e) {
                                            return InkWell(
                                              onTap: () {
                                                if (!initAppViewModel
                                                    .isLogged) {
                                                  Go.to(
                                                      context,
                                                      ChangeNotifierProvider(
                                                        create: (_) =>
                                                            AccountViewModel(),
                                                        child: LoginPage(
                                                          onLoginComplete: () {
                                                            Get.to(() =>
                                                                ChangeNotifierProvider(
                                                                  create: (BuildContext
                                                                      context) {
                                                                    return PlaceViewModel(
                                                                        e.traderId);
                                                                  },
                                                                  child:
                                                                      PlacePage(),
                                                                ));
                                                          },
                                                        ),
                                                      ));
                                                  return;
                                                }
                                                Get.to(() =>
                                                    ChangeNotifierProvider(
                                                      create: (BuildContext
                                                          context) {
                                                        return PlaceViewModel(
                                                            e.traderId);
                                                      },
                                                      child: PlacePage(),
                                                    ));
                                              },
                                              child: HomeSingleItemWidget(
                                                name: e.name,
                                                image: e.image,
                                              ),
                                            );
                                          }).toList(),
                                        )
                                      : Center(
                                          child: Text(
                                            'لا توجد مشاريع جديدة',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                SectionHeaderWidget(
                                  titleHeader: tr('عروض خاصة'),
                                  onClick: () {},
                                ),
                                Container(
                                  width: double.infinity,
                                  color: AppColors.greyBackground,
                                  height: 160,
                                  child: viewModel.offers.offers.isNotEmpty
                                      ? ListView(
                                          scrollDirection: Axis.horizontal,
                                          children:
                                              viewModel.offers.offers.map((e) {
                                            return InkWell(
                                              onTap: () {
                                                if (!initAppViewModel
                                                    .isLogged) {
                                                  Go.to(
                                                      context,
                                                      ChangeNotifierProvider(
                                                        create: (_) =>
                                                            AccountViewModel(),
                                                        child: LoginPage(
                                                          onLoginComplete: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ChangeNotifierProvider(
                                                                              create: (_) => OfferDetailsViewModel(OfferController(offerId: e.id, offerName: e.name)),
                                                                              child: OfferPage(),
                                                                            )));
                                                          },
                                                        ),
                                                      ));
                                                  return;
                                                }
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChangeNotifierProvider(
                                                              create: (_) => OfferDetailsViewModel(
                                                                  OfferController(
                                                                      offerId:
                                                                          e.id,
                                                                      offerName:
                                                                          e.name)),
                                                              child:
                                                                  OfferPage(),
                                                            )));
                                              },
                                              child: HomeSingleItemWidget(
                                                name: e.name,
                                                image: e.image,
                                              ),
                                            );
                                          }).toList(),
                                        )
                                      : Center(
                                          child: Text(
                                            'لا توجد عروض جديدة',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
        );
      },
    );
  }

  _showVersionChecker(BuildContext context) {
    try {
      NewVersion(
        iOSId: 'com.yallservice.ashanak', //dummy IOS bundle ID
        androidId: 'com.zakhoi.egyptian_ads_app', //dummy android ID
      ).showAlertIfNecessary(context: context);
    } catch (e) {
      debugPrint("error=====>${e.toString()}");
    }
  }
}

// void _checkVersion() async {
//   final newVersion = NewVersion(
//     iOSId: 'com.yallservice.ashanak',
//     androidId: "com.zakhoi.egyptian_ads_app",
//   );
//   newVersion.showAlertIfNecessary(context: context);
// }
