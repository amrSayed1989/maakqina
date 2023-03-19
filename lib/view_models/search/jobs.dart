
import 'package:get/get.dart';
import 'package:maak/model_services/job_offers.dart';
import 'package:maak/model_services/jobs.dart';
import 'package:maak/models/advertise.dart';
import 'package:maak/models/city.dart';
import 'package:maak/utils/consts/print_utils.dart';

class SearchJobsViewModel extends GetxController{

  String currentJobPage = 'وظائف خالية';

  var loading = false.obs;
  int page = 0;
  City? city;
  var subLoading = false.obs;
  var jobs = Jobs().obs;
  var ads = Ads().obs;
  var jobsOffers = JobOffers().obs;
  String details = '';

  bool get isEmptyData{
    if(currentJobPage == 'وظائف خالية'){
      return jobs.value.data.isEmpty;
    }else{
      return jobsOffers.value.data.isEmpty;
    }
  }



  int get dataLength{
    if(currentJobPage == 'وظائف خالية'){
      return jobs.value.data.length;
    }else{
      return jobsOffers.value.data.length;
    }
  }

  int get countPage{
    if(currentJobPage == 'وظائف خالية'){
      return jobs.value.countPage;
    }else{
      return jobsOffers.value.countPage;
    }
  }

  String get cityName{
    return city == null ? 'كل المدن' : '${city?.name}';
  }

  _retrieveJobsOffers() async {

    update();
    jobsOffers.value.getJobOffers({
      'city_id':'${city?.id}',
      "page": '$page',
      'details' : details
    },(){

      if(loading.value){
        ads.value.data.clear();
        ads.value.getAds(city?.id ?? 1, (){
          loading.value = false;
          update();
        });
      }

      subLoading.value = false;
      update();
    });
  }

  _searchResualts(){
    if(currentJobPage == 'وظائف خالية'){
      _retrieveJobs();
    }else{
      _retrieveJobsOffers();
    }
  }
  _retrieveJobs() async {
    //'وظائف خالية'
    update();
    jobs.value.getJobs({
      'city_id':'${city?.id}',
      "page": '$page',
      'details' : details
    },(){

      if(loading.value){
        ads.value.data.clear();
        ads.value.getAds(city?.id ?? 1, (){
          loading.value = false;
          update();
        });
      }
      // loading = false;
      subLoading.value = false;
      update();
    });
  }

  searchData(String value){
    println('----------------------- mfkmvkmkmfv $value');
    details = value;
    loading.value = true;
    page = 0;
    jobs.value.data.clear();
    _searchResualts();
  }

  loadMore(){
    subLoading.value = true;
    page += 1;
    _searchResualts();
  }

  clearData(){
    jobs.value.data.clear();
    jobsOffers.value.data.clear();
    page = 0;
  }

}