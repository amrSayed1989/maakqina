import 'package:maak/models/news.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

class AddedNews {
  List<News> data = [];
  int countItems = 0;
  int countPage = 0;
  int? status;
  String? message;
  int? statusCode;





  fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {

      json['data'].forEach((v) {
        data.add(new News.fromJson(v));
      });
    }
    countItems = json['countItems'];
    countPage = json['countPage'];
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
  }

  getNews(Map<String,String> params,onDone) async {


    var queryParameters = '?';

    params.forEach((key, value) {
      queryParameters += '$key=$value&';
    });
    println(AppUrl.news);
    println(queryParameters);
    AppApiHandler.getData(url: '${AppUrl.news}/$queryParameters', body: null, callback: (json){
      println(json);
      this.fromJson(json);
      onDone();
    });

  }



}







