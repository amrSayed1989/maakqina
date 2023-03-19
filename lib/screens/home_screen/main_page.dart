// ignore_for_file: unused_import

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:maak/screens/barcode/barcode_scanner1.dart';

import 'package:maak/screens/barcode/url_launcher.dart';

import 'package:new_version/new_version.dart';
import 'package:get/get.dart';
import 'package:maak/screens/home_screen/pages/ads.dart';
import 'package:maak/screens/home_screen/pages/home.dart';
import 'package:maak/screens/home_screen/pages/jobs/jobs.dart';
import 'package:maak/screens/home_screen/pages/offers/offers.dart';
import 'package:maak/screens/home_screen/pages/places/places.dart';
import 'package:maak/screens/home_screen/pages/products/products.dart';
import 'package:maak/screens/home_screen/pages/search/ads.dart';
import 'package:maak/screens/home_screen/pages/search/jobs.dart';
import 'package:maak/screens/home_screen/pages/search/offers.dart';
import 'package:maak/screens/home_screen/pages/search/place.dart';
import 'package:maak/screens/home_screen/pages/search/products.dart';
import 'package:maak/screens/home_screen/pages/shopping_cart/controller/controller.dart';
import 'package:maak/screens/home_screen/pages/shopping_cart/views/shopping_cart.dart';
import 'package:maak/screens/menu/menu_layout.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/widgets/bottom_navigation_widget.dart';
import 'package:maak/utils/widgets/bottom_sheet.dart';
import 'package:maak/view_models/ads_by_admin.dart';
import 'package:maak/view_models/ads_by_users.dart';
import 'package:maak/view_models/home_page_viewmodel.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:maak/view_models/job_offers_view_model.dart';
import 'package:maak/view_models/jobs_view_model.dart';
import 'package:maak/view_models/offers_view_model.dart';
import 'package:maak/view_models/places_view_model.dart';
import 'package:maak/view_models/products_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../../main.dart';
import '../../my_app.dart';
import '../../utils/services/storage_services.dart';
import '../../utils/widgets/alert_deialog.dart';
import '../../view_models/account.dart';
import '../account/login_page.dart';
import '../menu/notifications.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({Key? key}) : super(key: key);

  @override
  _MainPageScreenState createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  int currentPage = 0;
  PageController _pageController = PageController();
  final homePage = HomePage();
  final placesPage = PlacesPage();
  List<String> titles = [
    'الرئيسية',
    'الاماكن',
    'التسوق',
    'العروض',
    'الوظائف',
    'الاعلانات',
  ];

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  ShoppingCartController shoppingCartController = Get.find();
  MainAppViewModel initAppViewModel = Get.find<MainAppViewModel>();

  @override
  void dispose() {
    // _pageController.a
    _pageController.dispose();

    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _checkVersion();
    _showVersionChecker(context);
  }

  @override
  Widget build(BuildContext context) {
    // initAppViewModel.openNotification();

    if (shoppingCartController.afterFinishShopping) {
      // shoppingCartController.clearShoppingCart();
      Future.delayed(Duration(milliseconds: 100), () {
        setState(() {});
      });
      shoppingCartController.afterFinishShopping = false;
    }

    return WillPopScope(
      onWillPop: () async {
        final result = await showDialog(
          builder: (context) => AlertDialog(
            title: Center(
              child: Text(
                "تنبية",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cairo'),
              ),
            ),
            content: Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "هل انت متاكد من الخروج من التطبيق",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Cairo'),
              ),
            ),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                child: Text(
                  'لا',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo'),
                ),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              // ignore: deprecated_member_use
              FlatButton(
                child: Text(
                  'نعم',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Cairo'),
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
          context: context,
        );
        return result;
      },
      child: SideMenu(
        key: _sideMenuKey,
        menu: MenuPage(
          sideMenuKey: _sideMenuKey,
        ),
        type: SideMenuType.slide,
        inverse: true,
        background: AppColors.mainOrange,
        child: Scaffold(
          appBar: AppBar(
            title: Text(titles[currentPage]),
            centerTitle: false,
            leading: InkWell(
                onTap: () {
                  final _state = _sideMenuKey.currentState;
                  if (_state!.isOpened)
                    _state.closeSideMenu(); // close side menu
                  else
                    _state.openSideMenu(); // open side menu
                },
                child: Icon(
                  Icons.menu,
                  color: Colors.white,
                )),
            actions: [
              currentPage == 0
                  ? InkWell(
                      onTap: () {
                        showMyBottomSheet(context,
                            title: 'المدن',
                            data: initAppViewModel.cities.data!
                                .map((e) => e.name!)
                                .toList(), onItemSelected: (index) async {
                          await initAppViewModel
                              .setCity(initAppViewModel.cities.data![index]);
                          // Go.off(context, MainPageScreen());
                        });
                      },
                      child: Container(
                        // color: Colors.red,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text('${initAppViewModel.cityName}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ),
                            SizedBox(
                              width: 0,
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        switch (currentPage) {
                          case 1:
                            Go.to(context, SearchPlacesPage());
                            break;

                          case 2:
                            Go.to(context, SearchProductsPage());
                            break;

                          case 3:
                            Go.to(context, SearchOffersPage());

                            break;

                          case 4:
                            Go.to(context, SearchJobsPage());

                            break;

                          case 5:
                            Go.to(context, SearchAdsPage());

                            break;

                          default:
                            return;
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
              initAppViewModel.isLogged
                  ? InkWell(
                      onTap: () {
                        Go.to(context, NotificationsPage());
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0.0),
                          child: Row(
                            children: [
                              Icon(Icons.notifications_on, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              // //start
              // InkWell(
              //   onTap: () {
              //     //UrlLauncher1Page
              //     // Go.to(context, BarcodeScanner1Page());
              //     Go.to(context, BarcodeScanner1Page());
              //     SizedBox();
              //   },

              //   //QrCodeScanner

              //   child: Container(
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 0.0),
              //       // color: Colors.red,
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           SizedBox(
              //             width: 1,
              //           ),
              //           Icon(
              //             Icons.qr_code,
              //             color: Colors.white,
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // //end
              SizedBox(),
              Obx(() => InkWell(
                    onTap: () {
                      MainAppViewModel mainApp = Get.find();

                      if (!mainApp.isLogged) {
                        Go.to(
                            context,
                            ChangeNotifierProvider(
                              create: (_) => AccountViewModel(),
                              child: LoginPage(
                                onLoginComplete: () {
                                  if (shoppingCartController.itemsCount > 0) {
                                    Go.to(context, ShoppingCartPage());
                                  } else {
                                    Get.snackbar('تنبيه', 'سلة التسوق فارغة',
                                        backgroundColor: Colors.redAccent,
                                        snackStyle: SnackStyle.FLOATING,
                                        colorText: Colors.white,
                                        messageText: Text(
                                          'سلة التسوق فارغة',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ));
                                  }
                                },
                              ),
                            ));
                        return;
                      }
                      if (shoppingCartController.itemsCount > 0) {
                        Go.to(context, ShoppingCartPage());
                      } else {
                        Get.snackbar('تنبيه', 'سلة التسوق فارغة',
                            backgroundColor: Colors.redAccent,
                            snackStyle: SnackStyle.FLOATING,
                            colorText: Colors.white,
                            messageText: Text(
                              'سلة التسوق فارغة',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ));
                      }
                    },
                    child: Badge(
                      showBadge: shoppingCartController.itemsCount > 0,
                      badgeContent: Text(
                        '${shoppingCartController.itemsCount}',
                        style: TextStyle(color: Colors.white),
                      ),
                      badgeColor: Colors.lightGreen,
                      position: BadgePosition.topStart(),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => HomePageViewModel()),
                    ChangeNotifierProvider(create: (_) => PlacesViewModel()),
                    ChangeNotifierProvider(create: (_) => OffersViewModel()),
                    ChangeNotifierProvider(create: (_) => ProductsViewModel()),
                    ChangeNotifierProvider(create: (_) => JobsViewModel()),
                    ChangeNotifierProvider(create: (_) => JobOffersViewModel()),
                    ChangeNotifierProvider(
                        create: (_) => AdsByAdminViewModel()),
                    ChangeNotifierProvider(
                        create: (_) => AdsByUsersViewModel()),
                  ],
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => currentPage = index);
                    },
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      HomePage(),
                      PlacesPage(), //services
                      ProductsPage(), //product page
                      OffersPage(),
                      JobsTabsPage(),
                      AdsPage(), //news page
                    ],
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationWidget(currentPage, (index) {
            setState(() {
              currentPage = index;
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
            });
          }),
        ),
      ),
    );
  }

  void _checkVersion() async {
    final newVersion = NewVersion(
      iOSId: 'com.yallservice.ashanak',
      androidId: "com.zakhoi.egyptian_ads_app",
    );
    newVersion.showAlertIfNecessary(context: context);
  }

  buildMenu() {
    return Container(
      color: Colors.red,
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

  //   // final status = await newVersion.getVersionStatus();
  //   // newVersion.showUpdateDialog(
  //   //   context: context,
  //   //   versionStatus: status!,
  //   //   dialogTitle: "UPDATE!!!",
  //   //   dismissButtonText: "Skip",
  //   //   dialogText: "Please update the app from " +
  //   //       "${status.localVersion}" +
  //   //       " to " +
  //   //       "${status.storeVersion}",
  //   //   dismissAction: () {
  //   //     SystemNavigator.pop();
  //   //   },
  //   //   updateButtonText: "Lets update",
  //   // );

  //   //print("DEVICE : " + status.localVersion);
  //   //print("STORE : " + status.storeVersion);
  // }

  // bool _screensDone = false;
  // setScreensDone() {
  //   println('------------------- screensDone $_screensDone');
  //   _screensDone = true;
  //   println('------------------- screensDone $_screensDone');
  //   //notifyListeners();
  //   TutorialHighlighterPage();
  // }

  // bool get screensDone {
  //   return _screensDone;
  // }
}
