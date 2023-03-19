// ignore_for_file: unused_import

import 'package:maak/models/image.dart';
import 'package:maak/models/job.dart';
import 'package:maak/utils/consts/print_utils.dart';
import 'package:maak/utils/consts/urls.dart';
import 'package:maak/utils/network/api.dart';

class Jobs {
  List<Job> data = [];
  int countJobs = 0;
  int countPage = 0;
  int status = 0;
  String? message;
  int? statusCode;

  fromJson(Map<String, dynamic> json, String spec) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new Job.fromJson(v));
      });
    }
    countJobs = json['countJobs'];
    countPage = json['countPage'];
    status = json['status'];
    message = json['message'];
    statusCode = json['statusCode'];
  }

  getJobs(Map<String, String> params, onDone) async {
    var queryParameters = '?';

    params.forEach((key, value) {
      queryParameters += '$key=$value&';
    });

    AppApiHandler.getData(
        url: '${AppUrl.jobs}/$queryParameters',
        apiKind: 'jobs',
        callback: (json) {
          this.fromJson(json, '${params['specializations']}');
          onDone();
        });
  }
}
