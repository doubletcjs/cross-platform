import 'package:ideaclass/public/networking.dart';

class ActivityApi {
  getActivityIndex(Function finish) {
    Networking.requestBase(
      "/app/index/getActivityIndex",
      finish,
    );
  }

  getAreaId(String areaName, Function finish) {
    Networking.requestBase(
      "/app/index/getAreaId",
      finish,
      params: {"areaName": areaName},
    );
  }

  getNearbyAvtivityIndex(String areaId, Function finish) {
    Networking.requestBase(
      "/app/index/getNearbyAvtivityIndex",
      finish,
      params: {"areaId": areaId},
    );
  }

  getActivityList(currPage, pageSize, title, Function finish) {
    Networking.requestBase(
      "/app/course/getActivityList",
      finish,
      params: {
        "currPage": currPage,
        "pageSize": pageSize,
        "title": title,
      },
    );
  }

  getExcellentActivityList(currPage, pageSize, Function finish) {
    Networking.requestBase(
      "/app/course/getExcellentActivityList",
      finish,
      params: {
        "currPage": currPage,
        "pageSize": pageSize,
      },
    );
  }
}
