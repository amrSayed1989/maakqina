import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maak/model_services/jobs.dart';
import 'package:maak/models/advertise.dart';
import 'package:maak/models/city.dart';
import 'package:maak/models/specialization.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

import '../utils/consts/print_utils.dart';
import 'init_app_viewmodel.dart';

class JobsViewModel extends ChangeNotifier{

  bool loading = true;
  int page = 0;
  City? city;
  bool subLoading = false;
  Jobs jobs = Jobs();
  Ads ads = Ads();
  Specialization? specialization;
  List<Specialization> specializations = [];
  MainAppViewModel initApp = Get.find();

  String get cityName{
    return city == null ? 'كل المدن' : '${city?.name}';
  }

  JobsViewModel(){
    this.city = initApp.city.value;
    initApp.city.listen((city){
      this.city = city;
      println('-=-=-=- we listen to in offers ${city.name} ${city.id}');
      reloadData();
    });
    retrieveJobFields();
    _retrieveJobs();
  }

  _retrieveJobs() async {

    notifyListeners();
    var params = {
      'city_id':city == null ? '' : '${city?.id}',
      "page": '$page',
      // "specialization_id[0]": (specialization == null || specialization!.id == -1) ? "" : '${specialization!.id}'
    };

    if(specializations.length > 0 && !specializations[0].selected){
      int i = 0;
      for(var d in specializations){
        if(d.selected){
          params.addAll({"specialization_id[$i]":'${d.id}'});
          i++;
        }
      }
    }


    jobs.getJobs(params,(){

      if(loading){
        ads.data.clear();
        ads.getAds(city?.id ?? 1, (){
          loading = false;
          notifyListeners();
        });
      }

      subLoading = false;
      notifyListeners();
    });
  }

  reloadData(){
    loading = true;
    page = 0;
    jobs.data.clear();
    _retrieveJobs();
  }

  loadMore(){
    subLoading = true;
    page += 1;
    _retrieveJobs();
  }

  retrieveJobFields() {
    AppApiHandler.getData(
        url: AppUrl.specializations,
        body: null,
        callback: (json) {
          if (json['data'] != null) {
            specializations.add(new Specialization(id: -1,name: 'الكل'));
            json['data'].forEach((v) {
              specializations.add(new Specialization.fromJson(v));
            });
          }
          notifyListeners();
        });
  }

}