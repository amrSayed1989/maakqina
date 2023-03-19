// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/cities.dart';
import 'package:maak/models/city.dart';
import 'package:maak/models/offers.dart';
import 'package:maak/models/services.dart';

import '../models/advertise.dart';
import '../utils/consts/print_utils.dart';
import 'init_app_viewmodel.dart';

class OffersViewModel extends ChangeNotifier {
  Offers offers = Offers();
  bool isLoading = true;
  int page = 0;
  City? city;
  bool subLoading = false;
  Ads ads = Ads();
  Service? services;

  String? commercial;
  String? service;
  MainAppViewModel initApp = Get.find();

  OffersViewModel() {
    this.city = initApp.city.value;
    initApp.city.listen((city) {
      this.city = city;
      println('-=-=-=- we listen to in offers ${city.name} ${city.id}');
      reloadData();
    });
    _retrieveOffers();
  }
  String get cityName {
    return city == null ? 'كل المدن' : '${city?.name}';
  }

  _retrieveOffers() async {
    var params = {
      'city_id': city == null ? '' : '${city?.id}',
      "page": '$page',
      "show_in_main_offers_page": "1"
      // 'category_id': categoryId,
      // "sub_category_id[0]": subCategoryId,
    };

    if (services != null) {
      if (services!.id == -2) {
        int i = 0;
        for (var ser in services!.subCategories) {
          if (ser.id != -1) {
            params.addAll({'sub_category_id[$i]': '${ser.id}'});
            i++;
          }
        }
      } else {
        params.addAll({'category_id': '${services!.id}'});
        int i = 0;
        for (var ser in services!.subCategories) {
          if (ser.selected) {
            params.addAll({'sub_category_id[$i]': '${ser.id}'});
            i++;
          }
        }
      }
    }
    if (!isLoading) {
      subLoading = true;
      // page += 1;

    }
    notifyListeners();
    offers.getOffers(params, () {
      if (isLoading) {
        ads.getAds(city?.id ?? 1, () {
          isLoading = false;
          notifyListeners();
        });
      }
      subLoading = false;
      notifyListeners();
    });
  }

  reloadData() {
    isLoading = true;
    page = 0;
    offers.offers.clear();
    _retrieveOffers();
  }

  loadMore() {
    subLoading = true;
    page += 1;
    _retrieveOffers();
  }

  String get serviceType {
    return service ?? 'عروض خدمية';
  }

  String get commercialType {
    return commercial ?? 'عروض تجارية';
  }
}
