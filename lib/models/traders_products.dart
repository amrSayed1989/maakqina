import '../utils/consts/urls.dart';
import '../utils/network/api.dart';
import 'color.dart';

class TradersWithProductsService {
  List<FilterTrader> data = <FilterTrader>[];

  TradersWithProductsService();

  fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {

      json['data'].forEach((v) {
        data.add(new FilterTrader.fromJson(v));
      });
    }
  }

  getTraders(onDone){
    AppApiHandler.getData(url: '${AppUrl.getTradersWithProducts}', body: null, callback: (json){
      this.fromJson(json);
      onDone();
    });
  }
}

