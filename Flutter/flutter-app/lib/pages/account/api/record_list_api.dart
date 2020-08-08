import '../../../public/networking.dart';

class RecordListApi {
  // 访客列表
  /* 
  page integer 分页
  per_page integer 每页记录条数 默认15
  */
  static visitors(page, size, finish) {
    Networking.requestBase("/api/v1/visitors", finish, method: "GET", params: {
      "page": page,
      "per_page": size,
    });
  }

  // 喜欢我的人的列表
  /* 
  page integer 分页
  per_page integer 每页记录条数 默认15
  */
  static loveMe(page, size, finish) {
    Networking.requestBase("/api/v1/user/love-me", finish,
        method: "GET",
        params: {
          "page": page,
          "per_page": size,
        });
  }

  //我的黑名单列表
  /* 
  page integer 分页
  per_page integer 每页记录条数 默认15
  */
  static blockList(page, size, finish) {
    Networking.requestBase("/api/v1/user/shield/list", finish,
        method: "GET",
        params: {
          "page": page,
          "per_page": size,
        });
  }

  //清除访客
  static cleanVisitors(finish) {
    Networking.requestBase(
      "/api/v1/visitors",
      finish,
      method: "DELETE",
    );
  }

  //清除喜欢我的人
  static cleanLoveMe(finish) {
    Networking.requestBase(
      "/api/v1/user/love-me",
      finish,
      method: "DELETE",
    );
  }
}
