import 'package:maak/utils/consts/app_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'city.dart';

class Cities {
  List<City>? data;

  Cities({this.data});

  Cities.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new City.fromJson(v));
      });
    }
  }

  static Future setCityToSF(City city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(AppSharedKeys.cityKey, [city.id.toString(), city.name ?? '']);
  }

  static Future<City?> getCityFromSF() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List? savedCity = prefs.getStringList(AppSharedKeys.cityKey);
    if(savedCity != null){
      return City(id: int.tryParse(savedCity[0]),name: savedCity[1]);
    }
    return null;
  }
}


