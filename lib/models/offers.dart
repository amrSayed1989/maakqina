
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

import 'offer.dart';

class Offers {
  List<Offer> offers = [];
  int countData = 0;
  int countPage = 0;
  int? status;
  String? message;
  int? statusCode;
  Offers();

 fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        offers.add(new Offer.fromJson(v));
      });
    }
    countData = json['countData'];
    countPage = json['countPage'];
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
  }

  getOffers(Map<String,String> params,onDone) async {


    var queryParameters = '?';

    params.forEach((key, value) {
      queryParameters += '$key=$value&';
    });

    println('--------------->>>>>>>>>>>>>>>>>. url');
    println('${AppUrl.offers}/$queryParameters');
    println('--------------->>>>>>>>>>>>>>>>>. url');
    AppApiHandler.getData(url: '${AppUrl.offers}/$queryParameters', body: null, callback: (json){
     println(json);
      this.fromJson(json);
      onDone();
    });



  }

}








