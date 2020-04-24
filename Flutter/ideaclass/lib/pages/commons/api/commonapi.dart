import 'package:ideaclass/public/networking.dart';

class LocaleApi {
  
}

class CommonApi {
  getEduList(Function finish) {
    Networking.requestBase(
      "/app/index/getEduList",
      finish, 
    );
  }

  getAreaList(String parentId, Function finish) {
    Networking.requestBase(
      "/app/index/getAreaList",
      finish,
      params: {
        "parentId": parentId,
      },
    );
  }
}