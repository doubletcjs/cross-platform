import 'package:hksy_flutter/public/networking.dart';

class AccountApi {
  static sendMessage(phone, finish) {
    Networking.requestBase(
      "sendMessage",
      finish,
      params: {
        "phone": phone,
      },
    );
  }

  static login(params, finish) {
    Networking.requestBase(
      "login",
      finish,
      params: params,
    );
  }

  static register(params, finish) {
    Networking.requestBase(
      "register",
      finish,
      params: params,
    );
  }

  static getUserInfo(userId, finish) {
    Networking.requestBase(
      "getUserInfo",
      finish,
      params: {
        "userId": userId,
      },
    );
  }

  static changePaymentCode(params, finish) {
    Networking.requestBase(
      "changePaymentCode",
      finish,
      params: params,
    );
  }

  static setPaymentCode(params, finish) {
    Networking.requestBase(
      "setPaymentCode",
      finish,
      params: params,
    );
  }

  static changeAvater(nickname, url, finish) {
    Networking.requestBase(
      "changeAvater",
      finish,
      params: {
        "nickname": nickname,
        "url": url,
      },
    );
  }

  static getBankName(bankCard, finish) {
    Networking.requestBase(
      "getBankName",
      finish,
      params: {
        "bankCard": bankCard,
      },
    );
  }

  static authentication(params, finish) {
    Networking.requestBase(
      "authentication",
      finish,
      params: params,
    );
  }
}
