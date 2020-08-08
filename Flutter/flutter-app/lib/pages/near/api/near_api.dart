import '../../../public/networking.dart';

class NearListApi {
  // 用户列表
  /*
  type integer 类型 1：在线，2：新人，3：推荐，4：认证 
  sort string 距离排序 DESC：距离降序，其他：距离升序，默认DESC
  longitude string 经度
  latitude string 纬度
  page integer 分页
  per_page integer 每页记录条数 默认15
  */
  static nearList(longitude, latitude, type, sort, page, size, finish) {
    Networking.requestBase("/api/v1/users", finish, method: "GET", params: {
      "type": type,
      "sort": sort,
      "page": page,
      "per_page": size,
      "longitude": longitude,
      "latitude": latitude,
    });
  }

  static near(longitude, latitude, page, size, finish) {
    Networking.requestBase("/api/v1/users", finish, method: "GET", params: {
      "page": page,
      "per_page": size,
      "longitude": longitude,
      "latitude": latitude,
    });
  }
}
