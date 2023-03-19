// ignore_for_file: unused_import

import 'package:get/get.dart';
import 'package:maak/utils/consts/print_utils.dart';

import '../../../../../../models/offer.dart';
import '../../../../../../utils/consts/urls.dart';
import '../../../../../../utils/network/api.dart';

class OffersController extends GetxController {
  // var offers = <Offer>[].obs;
  var traderOffers = TraderOffers().obs;
  var loading = true.obs;

  retrieveOffer(int traderId) {
    AppApiHandler.getData(
        url: '$apiVersion/getTraderOffersById/$traderId?show_in_trader_page=1',
        body: null,
        callback: (json) {
          traderOffers.value.fromJson(json);
          loading.value = false;
          ;
        });
  }
}

class TraderOffers {
  List<Offer> offers = [];
  int? countPage;
  int? status;
  String? message;
  int? statusCode;

  TraderOffers();

  fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        offers.add(new Offer.fromJson(v));
      });
    }
    countPage = json['countPage'];
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
  }
}
