import 'package:flutter/material.dart';
import 'package:maak/models/job_offer.dart';

class RequestedJobViewModel extends ChangeNotifier{

  JobOffer job;

  RequestedJobViewModel(this.job);
}