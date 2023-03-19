// ignore_for_file: unused_import

import 'package:maak/models/image.dart';
import 'package:maak/models/trader.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

import '../models/category.dart';
import '../models/city.dart';
import '../models/offer_details.dart';

class OfferController {
  OfferDetails? _data;
  final int offerId;
  final String offerName;

  OfferController({required this.offerId, required this.offerName});

  fromJson(Map<String, dynamic> json) {
    _data =
        json['data'] != null ? new OfferDetails.fromJson(json['data']) : null;
  }

  OfferDetails get offerDetail {
    return _data ?? OfferDetails();
  }

  retrieveOffer(onDone) {
    AppApiHandler.getData(
        url: '${AppUrl.offers}/$offerId',
        body: null,
        callback: (json) {
          this.fromJson(json);
          onDone();
        });
  }
}
