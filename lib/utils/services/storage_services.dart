import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedData{
  late SharedPreferences _sharedPreferences ;

  static final SharedData _sharedData = SharedData._internal();
  static SharedData get getInstance{
    return _sharedData;
  }
  SharedData._internal(){
    init();
  }
  init() async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

   Future saveMap({required Map<String, dynamic> map,required String key}) async{
    var values = json.encode(map);
    _sharedPreferences = await SharedPreferences.getInstance();
    return await _sharedPreferences.setString(key, values);
  }

  Future<Map<String, dynamic>?> getMap({required String key})async{
    _sharedPreferences = await SharedPreferences.getInstance();
    var values = _sharedPreferences.getString(key);
    if(values != null){
      var data = json.decode(values);
      return data;
    }
    return null;
  }

  Future<bool> removeData(String key)async{
    _sharedPreferences = await SharedPreferences.getInstance();
    return await _sharedPreferences.remove(key);
  }
}