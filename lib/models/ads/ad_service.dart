import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

import 'ad_category.dart';

class AdCategoriesService {
  List<AdCategory> categories = [];


  fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {

      json['data'].forEach((v) {
        println(json['data']);
        categories.add(new AdCategory.fromJson(v));
      });
    }
  }


  getAdsCategories({onDone}) async {

    AppApiHandler.getData(url: '${AppUrl.newsCategories}', body: null, callback: (json){
      this.fromJson(json);
      onDone();
    });

  }

}


