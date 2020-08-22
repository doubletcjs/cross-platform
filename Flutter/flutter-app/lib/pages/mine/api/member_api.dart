import 'package:dio/dio.dart';

import '../../../public/networking.dart';

class MemberApi {
  // 添加喜欢的人
  /*
  id	integer 喜欢人的id
  */
  static addLove(userId, finish) {
    Networking.requestBase("/api/v1/user/love", finish, method: "PUT", params: {
      "id": userId,
    });
  }

  // 删除我喜欢的人
  /*
  love_user_ids	[string] 喜欢的人的id数组
  */
  static deleteLove(userIds, finish) {
    Networking.requestBase("/api/v1/user/love", finish,
        method: "DELETE",
        params: {
          "love_user_ids": userIds,
        });
  }

  // 添加黑名单
  /*
  id	integer 用户id
  */
  static shieldSave(userId, finish) {
    Networking.requestBase("/api/v1/user/shield/save", finish, params: {
      "id": userId,
    });
  }

  // 删除黑名单的人
  /*
  id	integer 用户id
  */
  static shieldDelete(userId, finish) {
    Networking.requestBase("/api/v1/user/shield/delete", finish, params: {
      "id": userId,
    });
  }

  //举报
  /*
  report_user_id	integer 被举报人id 
  type	integer 举报类型id 1.低速骚扰 2.广告营销 3.虚假信息 4.其他   
  "色情" "诈骗" "广告骚扰" "敏感信息" "其他"
  content	string 举报内容 
  img	[string] 举报图片
  */
  static report(Map<String, Object> params, finish) {
    Networking.requestBase("/api/v1/report", finish, params: params);
  }

  // 查看联系方式接口
  /*
  id	integer 用户id
  */
  static getContact(userId, finish) {
    Networking.requestBase("/api/v1/get/contact", finish, params: {
      "id": userId,
    });
  }

  // 查看视频接口
  /*
  id	integer 用户id
  */
  static getVideo(userId, finish) {
    Networking.requestBase("/api/v1/get/video", finish, params: {
      "id": userId,
    });
  }

  static Future getGifts () {
    return DioManager().get("/api/v1/gift/lists");
  }

  static Future postGift (Map data) {
    return DioManager().post("/api/v1/send/gift", data: data, options: Options(extra: {
      "loading": true
    }));
  }
}
