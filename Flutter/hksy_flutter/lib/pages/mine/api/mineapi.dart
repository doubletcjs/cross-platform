import 'package:hksy_flutter/public/networking.dart';

class MineApi {
  static createContract(userId, finish) {
    Networking.requestBase("createContract", finish, params: {
      "userId": userId,
    });
  }

  static getContractDetail(userId, page, limit, finish) {
    Networking.requestBase("createContract", finish, params: {
      "userId": userId,
      "page": page,
      "limit": limit,
    });
  }

  static addMessage(userId, userneame, phone, message, finish) {
    Networking.requestBase("addMessage", finish, params: {
      "userId": userId,
      "userneame": userneame,
      "phone": phone,
      "message": message,
    });
  }
}
