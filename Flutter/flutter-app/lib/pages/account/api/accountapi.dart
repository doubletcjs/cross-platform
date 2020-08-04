import '../../../public/networking.dart';

class AccountApi {
  // 国家区号列表
  static countryCode(finish) {
    Networking.requestBase("/api/v1/config/country", finish, method: "GET");
  }

  // 验证码发送
  /*
  mobile	string 手机号  
  type	string 请求类型：login:验证码登录 register:验证码注册 reset: 重置密码、忘记密码
  area_code	string 区号，默认86
  */
  static verifyCode(mobile, type, areacode, finish) {
    Networking.requestBase("/api/v1/sms/send", finish, params: {
      "mobile": mobile,
      "type": type,
      "area_code": areacode,
    });
  }

  // 验证码登录
  /*
  mobile	string 手机号  
  code	string 短信验证码
  */
  static smsLogin(mobile, code, finish) {
    Networking.requestBase("/api/v1/login/sms_code", finish, params: {
      "mobile": mobile,
      "code": code,
    });
  }

  // 注册
  /*
  mobile	string 手机号  
  code	string 短信验证码
  */
  static register(mobile, code, finish) {
    Networking.requestBase("/api/v1/register", finish, params: {
      "mobile": mobile,
      "code": code,
    });
  }

  // 编辑用户信息
  /*
  nickname	string 昵称
  avatar	string 头像
  signature	string 个性签名
  birthday	string 生日 传递年月日 1992-01-01
  child_nums	integer 小孩数量
  qq	string qq
  wechat	string 微信
  douyin	string 抖音
  province	integer 省
  city	integer 市
  smoking_habit	integer 抽烟习惯 0：保密 1：从不 2：偶尔 3：经常
  drinking_habit	integer 喝酒习惯 0：保密 1：从不 2：偶尔 3：经常
  education	integer 学历 0：保密 1：小学 2：初中 3：高中 4：专科 5：本科 6：硕士 7：博士
  living_status	integer 居住状态 0：保密 1：一个人 2：和家人 3：和某人 4：和朋友
  interest	兴趣 [String]
  photo	 照片 [String]
  */
  static editProfile(Map<String, Object> params, finish) {
    Networking.requestBase("/api/v1/user/profile", finish, params: params);
  }

  // 获取用户个人资料
  static profile(finish) {
    Networking.requestBase("/api/v1/user/profile", finish, method: "GET");
  }

  // 获取他人主页资料
  static otherProfile(userid, finish) {
    Networking.requestBase("/api/v1/user/other", finish,
        method: "GET",
        params: {
          "id": userid,
        });
  }

  // 修改手机号
  /*
  mobile	string 手机号  
  code	string 短信验证码
  */
  static modifyMobile(mobile, code, finish) {
    Networking.requestBase("/api/v1/user/mobile", finish,
        method: "PUT",
        params: {
          "mobile": mobile,
          "code": code,
        });
  }

  //视频认证
  static authenticate(videoPath, finish) {
    Networking.requestBase("/api/v1/authenticate/video", finish, params: {
      "video": videoPath,
    });
  }
}
