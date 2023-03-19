import 'package:maak/models/job_offer.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

class JobOffers {
  List<JobOffer> data = [];
  int countJobs = 0;
  int countPage = 0;
  int? status;
  String? message;
  int? statusCode;



  fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {

      json['data'].forEach((v) {

        println(v);
        data.add(new JobOffer.fromJson(v));
      });

    }
    countJobs = json['countJobs'];
    countPage = json['countPage'];
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
  }

  getJobOffers(Map<String,String> params,onDone) async {


    var queryParameters = '?';

    params.forEach((key, value) {
      queryParameters += '$key=$value&';
    });


    AppApiHandler.getData(url: '${AppUrl.jobOffers}/$queryParameters', body: null, callback: (json){
      this.fromJson(json);
      onDone();
    });



  }

}







