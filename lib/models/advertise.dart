// ignore_for_file: unused_import

import 'package:maak/models/image.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

class Ads {
  List<AdItem> data = [];

  fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new AdItem.fromJson(v));
      });
    }
  }

  getAds(int cityId, onDone) {
    AppApiHandler.getData(
        url: '${AppUrl.ads}?city_id=$cityId',
        body: null,
        callback: (json) {
          this.fromJson(json);
          onDone();
        });
  }
}

class AdItem {
  int? id;

  List<AppImage> images = [];

  AdItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    if (json['images'] != null) {
      json['images'].forEach((v) {
        // println(v);
        images.add(new AppImage.fromJson(v));
      });
    }
  }

  String get imageUrl {
    // print('-----=-=-==-=-=->>> images l ${images[0].imageUrl}');
    return images[0].imageUrl;
  }
}
