import 'package:ideaclass/public/networking.dart';

class HomeApi {
  getIndexData(Function finish) {
    Networking.requestBase(
      "/app/index/getIndexData",
      finish,
    );
  }
}
