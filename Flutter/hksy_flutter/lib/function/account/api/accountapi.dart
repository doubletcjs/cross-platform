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
}
