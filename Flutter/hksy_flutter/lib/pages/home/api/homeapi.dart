import 'package:hksy_flutter/public/networking.dart';

class HomeApi {
  //更新公告
  static getAppVersion(finish) {
    Networking.requestBase("getAppVersion", finish);
  }

  //banner
  static getBanners(finish) {
    Networking.requestBase("getBanners", finish);
  }

  //消息公告
  static getNotice(finish) {
    Networking.requestBase("getNotice", finish);
  }

  //资产、产品推荐
  static getMyAssetsDetail(userId, finish) {
    Networking.requestBase("getMyAssetsDetail", finish, params: {
      "userId": userId,
    });
  }

  //弹窗公告
  static pushMsgInterface(userId, finish) {
    Networking.requestBase("pushMsgInterface", finish, params: {
      "userId": userId,
    });
  }
}
