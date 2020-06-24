import 'package:hksy_flutter/public/networking.dart';

class StorageApi {
  static getPerformanceDatas(userId, finish) {
    Networking.requestBase("getPerformanceDatas", finish, params: {
      "userId": userId,
    });
  }

  static getPerformanceDatasList(userId, page, limit, finish) {
    Networking.requestBase(
      "getPerformanceDatasList",
      finish,
      params: {
        "page": page,
        "limit": limit,
        "userId": userId,
      },
    );
  }

  static vipminerInfo(userId, page, limit, finish) {
    Networking.requestBase(
      "vipminerInfo",
      finish,
      params: {
        "page": page,
        "limit": limit,
        "userId": userId,
      },
    );
  }
}
