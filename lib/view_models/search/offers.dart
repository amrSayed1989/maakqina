// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/models/city.dart';
import 'package:maak/models/offers.dart';
import 'package:maak/utils/consts/print_utils.dart';

class SearchOffersViewModel extends GetxController {
  var offers = Offers().obs;
  var isLoading = false.obs;
  int page = 0;
  City? city;
  var subLoading = false.obs;
  String description = '';

  SearchOffersViewModel(this.city) {
    println('-------ggdgd- ${city?.name}');
  }
  String get cityName {
    return city == null ? 'كل المدن' : '${city?.name}';
  }

  _retrieveOffers() async {
    update();
    offers.value.getOffers({
      'city_id': city == null ? '' : '${city?.id}',
      "page": '$page',
      "description": description
    }, () {
      isLoading.value = false;
      subLoading.value = false;
      update();
    });
  }

  searchOffers(String value) {
    isLoading.value = true;
    description = value;
    page = 0;
    offers.value.offers.clear();
    _retrieveOffers();
  }

  loadMore() {
    subLoading.value = true;
    page += 1;
    _retrieveOffers();
  }
}
