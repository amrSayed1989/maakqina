import 'package:flutter/material.dart';

class AccountViewModel extends ChangeNotifier {
  bool _signUp = false;
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  set signUp(value) {
    _signUp = value;
    notifyListeners();
  }

  bool get signUp {
    return _signUp;
  }
}
