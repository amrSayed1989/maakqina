import 'package:flutter/material.dart';
import 'package:maak/models/news.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

class ShowSingleAdViewModel extends ChangeNotifier {

  int adId;
  bool loading = true;
  News? singleAd;
  bool openedDetails = true;

   ShowSingleAdViewModel(this.adId){
     getSingleNews();
   }




     getSingleNews(){
       println('--------------------------- $adId');
       AppApiHandler.getData(url: '${AppUrl.news}/$adId', body: null, callback: (json){
         singleAd = json['data'] != null ? new News.fromJson(json['data']) : null;
         println('--------------------------- json');
         loading = false;
         notifyListeners();
       });
     }

     toggleOpenedDetails(){
       openedDetails = !openedDetails;
       notifyListeners();
     }

}
