import 'package:hksy_flutter/public/networking.dart';

class InvitationApi {
  //邀请收益
  static getEarningsForUser(userId, finish) {
    Networking.requestBase("getEarningsForUser", finish, params: {
      "userId": userId,
    });
  }

  static getEarningsDetailForUser(userId, page, limit, finish) {
    Networking.requestBase(
      "getEarningsDetailForUser",
      finish,
      params: {
        "page": page,
        "limit": limit,
        "userId": userId,
      },
    );
  }
}
