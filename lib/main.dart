// ignore_for_file: unused_import, unused_element, body_might_complete_normally_nullable

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as local;
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/services/storage_services.dart';
import 'package:new_version/new_version.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:maak/utils/network/connectivity_provider.dart';
import 'package:maak/view_models/init_app_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';
import 'models/cities.dart';
import 'models/city.dart';
import 'my_app.dart';
import 'dart:io';
import 'package:flutter_phoenix/flutter_phoenix.dart';

City? city;
String? firebaseToken;

retrieveSavedCity() async {
  city = await Cities.getCityFromSF();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// Add dark mode and light mode
// let darkMode = false;

// // Create a function to toggle between dark and light mode
// function toggleMode() {
//   if (darkMode === false) {
//     document.body.style.backgroundColor = '#000';
//     document.body.style.color = '#fff';
//     darkMode = true;
//   } else {
//     document.body.style.backgroundColor = '#fff';
//     document.body.style.color = '#000';
//     darkMode = false;  }
// }
// FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  FlutterAppBadger.updateBadgeCount(1);
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

String selectedNotificationPayload = '';

FirebaseMessaging messaging = FirebaseMessaging.instance;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await local.EasyLocalization.ensureInitialized();
  await retrieveSavedCity();
  HttpOverrides.global = new MyHttpOverrides();
  Get.put(MainAppViewModel());
  // await _configureLocalTimeZone();

  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  // String initialRoute = MyApp.routeName;
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload = notificationAppLaunchDetails?.payload ?? '';
    // initialRoute = MyApp.routeName;
  }

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_notif');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          onDidReceiveLocalNotification: (
            int id,
            String? title,
            String? body,
            String? payload,
          ) async {
            didReceiveLocalNotificationSubject.add(
              ReceivedNotification(
                id: id,
                title: title!,
                body: body!,
                payload: payload!,
              ),
            );
          });
  const MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
    macOS: initializationSettingsMacOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    if (payload != null) {}
    selectedNotificationPayload = payload ?? '';
    selectNotificationSubject.add(payload ?? '');
  });

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   // systemNavigationBarColor: Colors.blue, // navigation bar color
  //   statusBarColor: AppColors.lightGrey, // status bar color
  // ));

  // var topicSubscription = messaging.subscribeToTopic('zinco_notification');
  // topicSubscription.whenComplete(() {});
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   if (message.notification != null) {}
  // });
  setNotifications();

  runApp(Phoenix(
      child: local.EasyLocalization(
          supportedLocales: [Locale('ar', '')],
          path:
              'assets/translations', // <-- change the path of the translation files
          startLocale: Locale('ar', ''),
          child: FutureProvider<MainAppViewModel?>(
            create: (BuildContext context) {
              MainAppViewModel();
            },
            initialData: MainAppViewModel(),
            child: MediaQuery(
              data: new MediaQueryData(),
              child: ChangeNotifierProvider(
                create: (_) => ConnectivityProvider(),
                child: MyApp(),
              ),
            ),
          ))));
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = tz.TimeZone.UTC.abbreviation;
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

setNotifications() async {
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  } else {}

  messaging.getToken().then((token) {
    println("================>>>>>>>>>> tokren");
    println('->> token: $token');
    println("================>>>>>>>>>> tokren");
    firebaseToken = token;
    println(token);
  });
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
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
