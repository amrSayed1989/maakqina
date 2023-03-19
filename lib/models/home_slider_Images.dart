// ignore_for_file: unused_import

import 'package:maak/models/slider_item.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

import 'city.dart';

class HomeSliderImages {
  List<SliderItem>? data;

  fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(new SliderItem.fromJson(v));
      });
    }
  }

  getHomeSlider(Map<String, String> params, onDone) async {
    var queryParameters = '?';

    params.forEach((key, value) {
      queryParameters += '$key=$value&';
    });

    AppApiHandler.getData(
        url: '${AppUrl.slideImagesInHome}/$queryParameters',
        body: null,
        callback: (json) {
          this.fromJson(json);
          onDone();
        });
  }
}
