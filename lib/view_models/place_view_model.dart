// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:maak/model_services/place_service.dart';
import 'package:maak/model_services/trader_service.dart';
import 'package:maak/models/cities.dart';
import 'package:maak/models/city.dart';
import 'package:maak/utils/consts/print_utils.dart';

class PlaceViewModel extends ChangeNotifier {
  TraderService traderService = TraderService();

  bool isLoading = true;
  City? city;
  bool gridSelected = true;

  PlaceViewModel(int traderId) {
    retrievePlaceData(traderId);
  }

  retrievePlaceData(int traderId) async {
    println('=======================traderId $traderId');
    city = await Cities.getCityFromSF();
    traderService.getPlaces(traderId, () {
      isLoading = false;
      notifyListeners();
    });
  }

  void setGridOrList(bool value) {
    gridSelected = value;
    notifyListeners();
  }
}
