import 'package:hksy_flutter/public/networking.dart';

class CoinApi {
  static giftCoinTransfer(userId, balance, finish) {
    Networking.requestBase("giftCoinTransfer", finish, params: {
      "userId": userId,
      "balance": balance,
    });
  }

  static vipgiftCoinTransfer(userId, balance, finish) {
    Networking.requestBase("vipgiftCoinTransfer", finish, params: {
      "userId": userId,
      "balance": balance,
    });
  }

  static queryBalance(userId, page, limit, finish) {
    Networking.requestBase("queryBalance", finish, params: {
      "userId": userId,
      "page": page,
      "limit": limit,
    });
  }

  static transfer(userId, phone, paymentCode, balance, finish) {
    Networking.requestBase("transfer", finish, params: {
      "ownerUserId": userId,
      "phone": phone,
      "paymentCode": paymentCode,
      "balance": balance,
    });
  }
}
