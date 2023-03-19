// ignore_for_file: unused_import

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:maak/models/cities.dart';
import 'package:maak/models/city.dart';
import 'package:maak/models/init_page.dart';
import 'package:maak/models/user.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/strings.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';
import 'package:maak/view_models/place_view_model.dart';
import 'package:maak/view_models/show_single_ad.dart';
import 'package:maak/view_models/single_product.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../model_services/offer_controller.dart';
import '../model_services/product_service.dart';
import '../models/product.dart';
import '../screens/home_screen/pages/ads/show_single_ad.dart';
import '../screens/home_screen/pages/jobs/single_available_job.dart';
import '../screens/home_screen/pages/offers/offer_page.dart';
import '../screens/home_screen/pages/places/place_page.dart';
import '../screens/home_screen/pages/products/single_product.dart';
import '../screens/menu/notifications.dart';
import '../utils/widgets/alert_deialog.dart';
import 'available_job_view_model.dart';
import 'offer_view_model.dart';

class MainAppViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String countryCode = '';
  var userService = UserService().obs;
  var _isLogged = false.obs;
  Cities cities = Cities();
  bool isNotifReceived = false;
  bool _signUp = false;
  var _cityName = ''.obs;
  // AppNotification? notification;

  void openNotification(AppNotification notification) {
    String type = notification.modelType ?? '';
    int id = notification.modelId ?? 0;

    Future.delayed(Duration.zero, () {
      if (isNotifReceived) {
        isNotifReceived = false;

        if ((type).toLowerCase() == 'job') {
          Get.to(() => ChangeNotifierProvider(
                create: (_) => AvailableJobViewModel(jobId: id),
                child: SingleAvailableJobPage(),
              ));
        } else if (((type).toLowerCase() == 'offer')) {
          Get.to(() => ChangeNotifierProvider(
                create: (_) => OfferDetailsViewModel(
                    OfferController(offerId: id, offerName: '')),
                child: OfferPage(),
              ));
        } else if (((type).toLowerCase() == 'department')) {
          Get.to(() => ChangeNotifierProvider(
                create: (BuildContext context) {
                  return PlaceViewModel(notification.traderId ?? 0);
                },
                child: PlacePage(),
              ));
        } else if (((type).toLowerCase() == 'product')) {
          Get.to(() => ChangeNotifierProvider(
                create: (_) => SingleProductViewModel(
                    ProductService(Product(id: id)),
                    isFromNotif: true),
                child: SingleProductPage(),
              ));
        } else if (((type).toLowerCase() == 'news')) {
          Get.to(() => ChangeNotifierProvider(
                create: (_) => ShowSingleAdViewModel(id),
                child: ShowSingleAdPage(),
              ));
        }

        // notification = null;
      }
    });
  }

  set signUp(value) {
    _signUp = value;

    update();
  }

  bool get signUp {
    return _signUp;
  }

  bool loading = true;
  var city = City().obs;
  MainAppViewModel() {
    retrieveCities();
    initCity();
  }

  Future deleteUseAccount() async {
    var Api = "https://m3akm3ak.com/api/v1/deleteMyAccount";
    // Method: "POST";
    // Body:"user bearer token";
    var body = {"user": userService.value.token};

    AppApiHandler.sendData(
        url: Api,
        body: body,
        callback: (json) {
          println(json);
          logoutUser();
        },
        onError: (code, error) {
          println(code);
          println(error);
          logoutUser();
        });
  }

  initCity() async {
    _isLogged.value = userService.value.token != null;
    city.value = (await Cities.getCityFromSF())!;
    _cityName.value = (city.value.name ?? '');
    update();
  }

  Future setCity(City city) async {
    await Cities.setCityToSF(city);
    city = city;
    _cityName.value = city.name ?? '';
    initCity();
    update();
  }

  String get cityName {
    return _cityName.value;
  }

  String get cityId {
    return '${city.value.id}';
  }

  retrieveCities() async {
    UserService? inUser = await UserService.savedUser();
    if (inUser != null) {
      userService.value = inUser;
    }
    AppApiHandler.getData(
        url: AppUrl.cities,
        body: null,
        callback: (json) {
          cities = Cities.fromJson(json);
          loading = false;
          initCity();
          update();
        });
  }

// log out
  Future logoutUser() async {
    try {
      await _auth.signOut();
      await userService.value.removeUser();
      _isLogged.value = false;
      update();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> registerPost(String phone, String name) async {
    println('--=-=-=-=-= city name = $cityName');
    println('--=-=-=-=-= city id = $cityId');

    var url = 'https://m3akm3ak.com/api/v1/register';
    // var url = 'https://m3akm3ak.com/api/v1/register?city_id=$countryId&phone_number=$phone&name=$name';
    Map data = {
      'city_id': cityId,
      'phone_number': phone,
      'name': name,
      'firebase_token': firebaseToken!,
    };

    println('0000000>>>>>>>> data');
    println(data);
    //encode Map to JSON
    // return 'user_exists';
    var body = json.encode(data);
    var response = await post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: body);

    var parsedCountryList = json.decode(response.body);

    if (response.statusCode == 200) {
      userService.value = UserService.fromRegisterJson(parsedCountryList);
      update();
      return 'registered';
    }

    update();
    return 'user_exists';
  }

  Future<String> logInPost(String phone) async {
    // final user = await FirebaseAuth.instance.currentUser.getIdToken();
    print('token = >>>>>> logInPost' + firebaseToken!);

    var url = 'https://m3akm3ak.com/api/v1/login';
    // var url = 'https://m3akm3ak.com/api/v1/login?phone_number=$phone&city_id=${city?.id}';
    Map data = {
      'city_id': "${city.value.id}",
      'phone_number': phone,
      'firebase_token': firebaseToken!,
    };
    println('0000000>>>>>>>> $data');

    var body = jsonEncode(data);
    var response = await post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          // "Content-Type": "application/x-www-form-urlencoded"
          // "Content-Length":"47"
        },
        body: body);

    var parsedCountryList = json.decode(response.body);

    if (response.statusCode == 200) {
      userService.value = UserService.fromJson(parsedCountryList);
      update();
      return parsedCountryList['token'];
    }

    return 'not';
  }

  String get userName {
    return !isLogged ? '' : userService.value.user?.name ?? '';
  }

  bool get isLogged {
    _isLogged.value = userService.value.token != null;

    return _isLogged.value;
  }

  set isLogged(value) => _isLogged.value = value;
}
