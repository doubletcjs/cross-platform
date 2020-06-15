import 'package:hksy_flutter/public/networking.dart';

class HomeApi {
  static getAppVersion(finish) {
    Networking.requestBase("getAppVersion", finish);
  }

  static getBanners(finish) {
    Networking.requestBase("getBanners", finish);
  }

  static getNotice(finish) {
    Networking.requestBase("getNotice", finish);
  }
}
