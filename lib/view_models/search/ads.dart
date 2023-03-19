// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/model_services/added_news.dart';
import 'package:maak/models/advertise.dart';
import 'package:maak/models/city.dart';
import 'package:maak/utils/consts/print_utils.dart';

class SearchAdsViewModel extends GetxController {
  var loading = false.obs;
  var page = 0;
  City? _city;
  var subLoading = false.obs;
  var addedNews = AddedNews().obs;
  Ads ads = Ads();
  String name = '';
  SearchAdsViewModel();
  // AdsByAdminViewModel(this.city){
  //   _retrieveNews();
  // }

  _retrieveNews() async {
    addedNews.value.getNews({
      'city_id': '${_city?.id}',
      "page": '$page',
      // "added_by_admin":"1",
      "details": name
    }, () {
      println('-------- _retrieveNews2 $name');
      if (loading.value) {
        ads.data.clear();
        ads.getAds(_city?.id ?? 1, () {
          loading.value = false;
          update();
        });
      }

      subLoading.value = false;
      update();
    });
  }

  set city(value) {
    _city = value;
    update();
  }

  searchForAd(String value) {
    loading.value = true;
    name = value;
    page = 0;
    println('-------- searchForAd $value');
    addedNews.value.data.clear();
    _retrieveNews();
  }

  loadMore() {
    subLoading.value = true;
    page += 1;
    _retrieveNews();
  }
}
