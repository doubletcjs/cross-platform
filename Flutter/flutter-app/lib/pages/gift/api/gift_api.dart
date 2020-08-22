import 'package:yue_mei/public/networking.dart';

class GiftApi {
  static Future getGiftList (params) {
    return DioManager().get('/api/v1/myself/gift/lists', queryParameters: params);
  }
}