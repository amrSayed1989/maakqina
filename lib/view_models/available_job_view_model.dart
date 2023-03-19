import 'package:flutter/material.dart';
import 'package:maak/models/job.dart';

import '../utils/consts/urls.dart';
import '../utils/network/api.dart';

class AvailableJobViewModel extends ChangeNotifier{

  Job? job;
  final int? jobId;
  bool loading = false;
  AvailableJobViewModel({this.job,this.jobId}){
    if(job == null){
      loading = true;
      getJobBId();
    }
  }

  getJobBId(){
    notifyListeners();
    AppApiHandler.getData(url: '${AppUrl.jobs}/$jobId',apiKind: 'jobs', callback: (json){
      job =  Job.fromJson(json['data']);
      // onDone();
      loading = false;
      notifyListeners();
    });
  }
}