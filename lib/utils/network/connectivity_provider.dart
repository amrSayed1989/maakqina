
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectivityProvider extends ChangeNotifier{

  ConnectivityProvider(){
    startMonitoring();
  }

  Connectivity _connectivity = Connectivity();

  bool _isOnline = false;

  bool get isOnline => _isOnline;

  startMonitoring() async{
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen((status) async {
      if(status == ConnectivityResult.none){
        _isOnline = false;
        notifyListeners();
      }else{
        await updateConnectionStatus().then((bool isConnected)  {
          _isOnline = isConnected;
          notifyListeners();
        });
      }
    });
  }

  Future<void> initConnectivity() async{
    try {
      var status = await _connectivity.checkConnectivity();
      if(status == ConnectivityResult.none){
        _isOnline = false;
        notifyListeners();
      }else{
        _isOnline = true;
        notifyListeners();
      }
    } on PlatformException catch (e){
      print(e.toString());
      _isOnline = false;
      notifyListeners();
    }
  }


  Future<bool> updateConnectionStatus() async{
    bool isConnected = false;

    try{
      final List<InternetAddress> result = await InternetAddress.lookup('www.google.com');
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        isConnected = true;
      }
    } on SocketException catch(e){
      print(e.toString());
      isConnected = false;
    }

    return isConnected;
  }
}