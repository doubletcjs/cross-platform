import 'package:hksy_flutter/public/networking.dart';

class StoreApi {
  static getProductList(page, limit, finish) {
    Networking.requestBase(
      "getProductList",
      finish,
      params: {
        "page": page,
        "limit": limit,
      },
    );
  }
}
