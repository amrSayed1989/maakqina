// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/model_services/added_news.dart';
import 'package:maak/models/ads/ad_category.dart';
import 'package:maak/models/ads/ad_service.dart';
import 'package:maak/models/ads/ad_sub_category.dart';
import 'package:maak/models/advertise.dart';
import 'package:maak/models/cities.dart';
import 'package:maak/models/city.dart';
import 'package:maak/utils/consts/print_utils.dart';

import 'init_app_viewmodel.dart';

class AdsByAdminViewModel extends ChangeNotifier {
  bool loading = true;
  int page = 0;
  City? city;
  bool subLoading = false;
  AddedNews addedNews = AddedNews();
  Ads ads = Ads();

  AdCategory? selectedCategory;
  // AdSubCategory? selectedAdSubCategory;
  MainAppViewModel initApp = Get.find();
  bool loadingCats = true;

  AdsByAdminViewModel() {
    // retrieveCategories();
    this.city = initApp.city.value;
    initApp.city.listen((city) {
      this.city = city;
      println('-=-=-=- we listen to in offers ${city.name} ${city.id}');
      reloadData();
    });
    _retrieveNews();
  }

  _retrieveNews() async {
    var params = {
      'city_id': city == null ? '' : '${city?.id}',
      "page": '$page',
      "added_by_admin": "1",
    };

    if (selectedCategory != null) {
      params.addAll({'news_category_id': '${selectedCategory?.id}'});
      int i = 0;
      for (var sub in selectedCategory!.subCategories) {
        if (sub.selected) {
          params.addAll({'news_sub_category_id[$i]': '${sub.id}'});
          i++;
        }
      }
    }

    println('------------- news');
    println(params);

    notifyListeners();
    addedNews.getNews(params, () {
      if (loading) {
        ads.data.clear();
        ads.getAds(city?.id ?? 1, () {
          loading = false;
          notifyListeners();
        });
      }

      subLoading = false;
      notifyListeners();
    });
  }

  reloadData() {
    loading = true;
    page = 0;
    addedNews.data.clear();
    _retrieveNews();
  }

  loadMore() {
    subLoading = true;
    page += 1;
    _retrieveNews();
  }
}
