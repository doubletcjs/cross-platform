import 'package:hksy_flutter/public/networking.dart';

class HomeApi {
  static getAppVersion(finish) {
    Networking.requestBase("getAppVersion", finish);
  }
}
