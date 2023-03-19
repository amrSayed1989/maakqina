// ignore_for_file: unused_import

import 'package:maak/utils/services/storage_services.dart';

import '../utils/consts/print_utils.dart';

class UserService {
  AppUser? user;
  String? token;

  UserService({this.user, this.token});

  UserService.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new AppUser.fromJson(json['user']) : null;
    token = json['token'];
    SharedData.getInstance.saveMap(map: json, key: 'user');
  }

  UserService.fromRegisterJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new AppUser.fromJson(json['user']) : null;
    token = json['token']['accessToken'];
    SharedData.getInstance.saveMap(map: this.toJson(), key: 'user');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }

  static Future<UserService?> savedUser() async {
    print('-------========----------??????? savedUser()');
    var json = await SharedData.getInstance.getMap(key: 'user');
    print('->>>>>> user json $json');
    if (json != null) {
      UserService userService = UserService();
      userService.user =
          json['user'] != null ? new AppUser.fromJson(json['user']) : null;
      userService.token = json['token'];
      return userService;
    }
    return null;
  }

  Future removeUser() async {
    user = null;
    token = null;
    await SharedData.getInstance.removeData('user');
  }
}

class AppUser {
  int? id;
  String? name;
  String? phoneNumber;
  dynamic cityId;

  AppUser({
    this.id,
    this.name,
    this.phoneNumber,
    this.cityId,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    phoneNumber = json['phone_number'];
    cityId = json['city_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    data['phone_number'] = this.phoneNumber;
    data['city_id'] = this.cityId;

    return data;
  }
}
