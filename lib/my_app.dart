// ignore_for_file: unused_import, unused_field, unused_local_variable

import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:maak/screens/home_screen/main_page.dart';
import 'package:maak/screens/home_screen/pages/ads/show_single_ad.dart';
import 'package:maak/screens/home_screen/pages/jobs/single_available_job.dart';
import 'package:maak/screens/home_screen/pages/offers/offer_page.dart';
import 'package:maak/screens/home_screen/pages/places/place_page.dart';
import 'package:maak/screens/home_screen/pages/products/single_product.dart';
import 'package:maak/screens/home_screen/pages/shopping_cart/controller/controller.dart';
import 'package:maak/screens/init_pages/init_page.dart';
import 'package:maak/screens/menu/notifications.dart';
import 'package:maak/utils/consts/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:maak/utils/consts/navigation.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/widgets/alert_deialog.dart';
import 'package:maak/view_models/available_job_view_model.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:maak/view_models/init_page_screen.dart';
import 'package:maak/view_models/offer_view_model.dart';
import 'package:maak/view_models/place_view_model.dart';
import 'package:maak/view_models/show_single_ad.dart';
import 'package:maak/view_models/single_product.dart';
import 'package:new_version/new_version.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'model_services/offer_controller.dart';
import 'model_services/product_service.dart';
import 'models/product.dart';

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;
  bool isNotifReceived = false;

  String _appBadgeSupported = 'Unknown';

  initPlatformState() async {
    String appBadgeSupported;
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
      } else {
        appBadgeSupported = 'Not supported';
      }
    } on PlatformException {
      appBadgeSupported = 'Failed to get badge support.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appBadgeSupported = appBadgeSupported;
    });
  }

  var mainApp = Get.put(MainAppViewModel());
  @override
  void initState() {
    super.initState();
    _checkVersion();
    initPlatformState();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // Future.delayed(Duration.zero,(){
        //   alertErrorDialog('-=-==--=-=-=->> notifications\n${message.data}.\n${message.notification?.title}\n${message.notification?.body}');
        //
        // });
        // mainApp.isNotifReceived = true;
        AppNotification notification = AppNotification(
            modelId: int.tryParse("${message.data['model_id']}"),
            modelType: message.data['model_type'],
            traderId: int.tryParse("${message.data['trader_id']}"));
        if (('${message.data['model_type']}').toLowerCase() == 'job') {
          Get.to(() => ChangeNotifierProvider(
                create: (_) =>
                    AvailableJobViewModel(jobId: notification.modelId ?? 0),
                child: SingleAvailableJobPage(),
              ));
        } else if ((('${message.data['model_type']}').toLowerCase() ==
            'offer')) {
          Get.to(() => ChangeNotifierProvider(
                create: (_) => OfferDetailsViewModel(OfferController(
                    offerId: notification.modelId ?? 0, offerName: '')),
                child: OfferPage(),
              ));
        } else if ((('${message.data['model_type']}').toLowerCase() ==
            'department')) {
          Get.to(() => ChangeNotifierProvider(
                create: (BuildContext context) {
                  return PlaceViewModel(notification.traderId ?? 0);
                },
                child: PlacePage(),
              ));
        } else if ((('${message.data['model_type']}').toLowerCase() ==
            'product')) {
          Get.to(() => ChangeNotifierProvider(
                create: (_) => SingleProductViewModel(
                    ProductService(Product(id: notification.modelId ?? 0)),
                    isFromNotif: true),
                child: SingleProductPage(),
              ));
        } else if ((('${message.data['model_type']}').toLowerCase() ==
            'news')) {
          Get.to(() => ChangeNotifierProvider(
                create: (_) => ShowSingleAdViewModel(notification.modelId ?? 0),
                child: ShowSingleAdPage(),
              ));
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? ios = message.notification?.apple;

      alertWith2OptionsDialog(
          title: notification?.title ?? '',
          middleText: notification?.body ?? '',
          confirmButton: 'فتح الاشعار',
          onConfirm: () {
            // mainApp.notification = AppNotification(
            //     modelId: int.tryParse(message.data['model_id']) ?? 0,
            //     modelType: message.data['model_type']
            // );
            mainApp.isNotifReceived = true;
            AppNotification notification = AppNotification(
                modelId: int.tryParse("${message.data['model_id']}"),
                modelType: message.data['model_type'],
                traderId: int.parse("${message.data['trader_id']}"));
            mainApp.openNotification(notification);
          });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      setState(() {});

      mainApp.isNotifReceived = true;
      AppNotification notifi = AppNotification(
          modelId: int.tryParse("${message.data['model_id']}"),
          modelType: message.data['model_type'],
          traderId: int.tryParse("${message.data['trader_id']}"));

      if (('${message.data['model_type']}').toLowerCase() == 'job') {
        Get.to(() => ChangeNotifierProvider(
              create: (_) => AvailableJobViewModel(jobId: notifi.modelId),
              child: SingleAvailableJobPage(),
            ));
      } else if ((('${message.data['model_type']}').toLowerCase() == 'offer')) {
        Get.to(() => ChangeNotifierProvider(
              create: (_) => OfferDetailsViewModel(
                  OfferController(offerId: notifi.modelId ?? 0, offerName: '')),
              child: OfferPage(),
            ));
      } else if ((('${message.data['model_type']}').toLowerCase() ==
          'department')) {
        Get.to(() => ChangeNotifierProvider(
              create: (BuildContext context) {
                return PlaceViewModel(notifi.traderId ?? 0);
              },
              child: PlacePage(),
            ));
      } else if ((('${message.data['model_type']}').toLowerCase() ==
          'product')) {
        Get.to(() => ChangeNotifierProvider(
              create: (_) => SingleProductViewModel(
                  ProductService(Product(id: notifi.modelId ?? 0)),
                  isFromNotif: true),
              child: SingleProductPage(),
            ));
      } else if ((('${message.data['model_type']}').toLowerCase() == 'news')) {
        Get.to(() => ChangeNotifierProvider(
              create: (_) => ShowSingleAdViewModel(notifi.modelId ?? 0),
              child: ShowSingleAdPage(),
            ));
      }

      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title ?? ''),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body ?? '')],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
        0,
        "Testing $_counter",
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                channelDescription: channel.description,
                importance: Importance.high,
                color: AppColors.mainOrange,
                playSound: true,
                icon: '@mipmap/ic_notif')));
  }

  void _checkVersion() async {
    final newVersion = NewVersion(
      iOSId: 'com.yallservice.ashanak',
      androidId: "com.zakhoi.egyptian_ads_app",
    );
    newVersion.showAlertIfNecessary(context: context);
  }

  @override
  Widget build(BuildContext context) {
    MainAppViewModel initAppViewModel = Get.find<MainAppViewModel>();
    ShoppingCartController shoppingCartController =
        Get.put(ShoppingCartController());
    initAppViewModel.initCity();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", ""), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("ar", ""),
      title: 'معاك',
      theme: ThemeData(
        primaryColor: AppColors.mainOrange,
        primarySwatch: MaterialColor(
          0xffFF4500, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
          const <int, Color>{
            50: const Color(0xffce5641), //10%
            100: const Color(0xffb74c3a), //20%
            200: const Color(0xffa04332), //30%
            300: const Color(0xff89392b), //40%
            400: const Color(0xff733024), //50%
            500: const Color(0xff5c261d), //60%
            600: const Color(0xff451c16), //70%
            700: const Color(0xff2e130e), //80%
            800: const Color(0xff170907), //90%
            900: const Color(0xff000000), //100%
          },
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedLabelStyle: TextStyle(
          fontFamily: 'Cairo',
        )),
        appBarTheme: AppBarTheme(
            color: AppColors.mainOrange,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            )),
        fontFamily: 'Cairo',
      ),

      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
      home: city == null
          ? ChangeNotifierProvider(
              create: (_) => InitPageScreenViewModel(),
              child: InitPageScreen(),
            )
          : MainPageScreen(),
    );
  }
}
