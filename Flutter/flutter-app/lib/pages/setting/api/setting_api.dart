import '../../../public/networking.dart';

class SettingApi {
  // 意见反馈
  /*
  type	string 类型 1 Bug 2提建议 3其他 
  content	string 反馈内容
  attachments	附件 [string]
  username	string 联系人名称
  mobile	string 联系人电话
  */

  static feedback(Map<String, Object> params, finish) {
    Networking.requestBase("/api/v1/feedback", finish, params: params);
  }
}
