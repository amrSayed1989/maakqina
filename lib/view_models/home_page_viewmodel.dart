// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/advertise.dart';
import 'package:maak/models/cities.dart';
import 'package:maak/models/city.dart';
import 'package:maak/models/home_slider_Images.dart';
import 'package:maak/models/offers.dart';
import 'package:maak/model_services/places.dart';

import '../utils/consts/print_utils.dart';
import 'init_app_viewmodel.dart';

class HomePageViewModel extends ChangeNotifier {
  Places places = Places();
  Offers offers = Offers();
  HomeSliderImages homeSliderImages = HomeSliderImages();

  bool placesLoading = true;
  bool offersLoading = true;
  bool homeSliderLoading = true;
  City? city;
  static int count = 0;

  bool get isLoading {
    return placesLoading || offersLoading || homeSliderLoading;
  }

  bool get noDataForMainPage {
    return (homeSliderImages.data?.isEmpty ?? false) &&
        (places.places.isEmpty) &&
        (offers.offers.isEmpty);
  }

  MainAppViewModel initApp = Get.find();

  HomePageViewModel() {
    this.city = initApp.city.value;
    Future.delayed(Duration(milliseconds: 500), () {
      initApp.city.listen((city) {
        places = Places();
        offers = Offers();
        homeSliderImages = HomeSliderImages();

        this.city = city;
        // println()
        println('-=-=-=- we listen to in home ${city.name} ${city.id}');
        retrievePlaces();
      });
    });
    retrievePlaces();
  }

  retrievePlaces() async {
    // City? city = await Cities.getCityFromSF();
    placesLoading = true;
    offersLoading = true;
    homeSliderLoading = true;
    places.places.clear();
    offers.offers.clear();
    homeSliderImages.data?.clear();
    count++;
    println('-------->>>>>>>   count in main = $count');
    notifyListeners();

    places.getPlaces({
      'city_id': '${city?.id}',
      'show_in_main_page': '1',
    }, () {
      placesLoading = false;
      notifyListeners();
    });

    offers.getOffers({'city_id': '${city?.id}', 'show_in_main_page': '1'}, () {
      offersLoading = false;
      notifyListeners();
    });

    homeSliderImages.getHomeSlider(
        {'city_id': '${city?.id}', 'show_in_main_page': '1'}, () {
      homeSliderLoading = false;
      notifyListeners();
    });
  }
}
