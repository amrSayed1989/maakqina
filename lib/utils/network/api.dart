import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../consts/print_utils.dart';

class AppApiHandler {

  static void getData({@required String? url, Map<String, String>? header,String? apiKind, Map<String, dynamic>? body, @required callback, onError}) async {

    println('------?>> url');
    println(url);
    println('------?>> url');
    var uri = Uri.parse(url!);

    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.getUrl(uri);


    HttpClientResponse response = await request.close();
    // println('********************** jsonBody');
    // println(response.transform(utf8.decoder));
    // println('********************** jsonBody');
    String jsonBody = await response.transform(utf8.decoder).join();
    if (response.statusCode == 200) {

      var json = jsonDecode(jsonBody);
      callback(json);
    }
    else if (response.statusCode != 500) {
      Map<String, dynamic> json = jsonDecode(jsonBody);
      onError(response.statusCode, json);
    }
    else onError(response.statusCode, null);
  }

  static void sendData({@required String? url, @required dynamic body, Map<String, String>? header, @required callback,@required onError}) async {
    var uri = Uri.parse(url!);
    final response = await http.post(uri, body: body, headers: header);
    pintHttpStatus(response);
    String jsonBody = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200||response.statusCode == 201) {
      final json = jsonDecode(jsonBody);
      callback(json);
    }
    else if (response.statusCode != 500) {
      // var json = jsonDecode(jsonBody);
      onError(response.statusCode, jsonBody);
    }
    else onError(response.statusCode, null);

  }

  static void putData({@required String? url, @required dynamic body, Map<String, String>? header, @required callback, @required onError}) async {
    var uri = Uri.parse(url!);
    final response = await http.put(uri, body: body, headers: header);
    pintHttpStatus(response);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      callback(json);
    }
    else if (response.statusCode != 500) {
      var json = jsonDecode(response.body);
      onError(response.statusCode, json[0]);
    }
    else onError(response.statusCode, null);
  }

  static void sendDatajsonEncode({@required String? url, @required dynamic body, Map<String, String>? header, @required callback, @required onError}) async {
    var uri = Uri.parse(url!);
    final response = await http.post(uri, body: jsonEncode(body), headers: header);
    pintHttpStatus(response);
    body = utf8.decode(response.bodyBytes);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(body);
      callback(json);
    }
    else if (response.statusCode != 500) {
      Map<String, dynamic> json = jsonDecode(response.body);
      onError(response.statusCode, json);
    }
    else onError(response.statusCode, null);
  }

  static void sendDataWithConType({@required String? url, @required dynamic body, required Map<String, String> header, @required callback}) async {
    var uri = Uri.parse(url!);
    final response = await http.post(uri, body: body, headers: {"Content-Type": "application/json"});
    pintHttpStatus(response);
    final json = jsonDecode(response.body);
    callback(json);
  }

  static void pintHttpStatus(http.Response response) {
    // print('--------------------------\n');
    // print(response.request!.url);
    // print(response.request!.headers);
    // print(response.statusCode);
    // print(response.body);
    // print('--------------------------\n');
  }

}
