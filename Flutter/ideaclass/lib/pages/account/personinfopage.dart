import 'dart:io';

import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ideaclass/pages/account/api/accountapi.dart';
import 'package:ideaclass/pages/account/infoinput.dart';
import 'package:ideaclass/pages/account/views/personinfocell.dart';
import 'package:ideaclass/pages/commons/educationlist.dart';
import 'package:ideaclass/pages/commons/localeselection.dart';
import 'package:ideaclass/public/networking.dart';
import 'package:ideaclass/public/public.dart';
import 'package:image_pickers/CropConfig.dart';
import 'package:image_pickers/Media.dart';
import 'package:image_pickers/UIConfig.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';

class PersonInfoPage extends StatefulWidget {
  PersonInfoPage({Key key}) : super(key: key);

  @override
  _PersonInfoPageState createState() => _PersonInfoPageState();
}

class _PersonInfoPageState extends State<PersonInfoPage> {
  List<String> _infoList = [
    "头像",
    "真实姓名",
    "昵称",
    "性别",
    "生日",
    "年级",
    "地区",
    "学校",
    "QQ",
    "微信",
  ];

  DateTime _seletedDate = DateTime.now();

  String _area() {
    String provinceName = "";
    String cityName = "";
    String areaName = "";

    if (isStringEmpty(_account["provinceName"]) == false) {
      provinceName = _account["provinceName"];
    }

    if (isStringEmpty(_account["cityName"]) == false) {
      cityName = _account["cityName"];
    }

    if (isStringEmpty(_account["areaName"]) == false) {
      areaName = _account["areaName"];
    }

    return provinceName + cityName + areaName;
  }

  void _avatarSelectAction() {
    Future<void> _selectImages() async {
      List<Media> _listImages = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 1,
        showCamera: true,
        uiConfig: UIConfig(uiThemeColor: Colors.black),
        cropConfig: CropConfig(enableCrop: true, width: 1, height: 1),
      );

      setState(
        () {
          if (_listImages.length == 1) {
            Media _avatarImage = _listImages[0];
            List<File> files = [File(_avatarImage.path)];
            showHUD();
            Networking.uploadFiles(
              "",
              files,
              (data, msg) {
                if (data != null) {
                  List _fileNames = data;
                  if (_fileNames.length > 0) {
                    String _avatar = _fileNames[0];
                    AccountApi().editUserInfo(
                      {"avatar": _avatar},
                      (data, msg) {
                        if (data != null) {
                          setState(() {
                            _account["avatar"] = _avatar;
                            recordUserInfo(_account);
                          });
                        } else {
                          showToast(msg, context);
                        }

                        hideHUD();
                      },
                    );
                  } else {
                    hideHUD();
                    showToast("返回图片url为空！", context);
                  }
                } else {
                  hideHUD();
                  showToast(msg, context);
                }
              },
            );
          }
        },
      );
    }

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        var style = TextStyle(
          fontSize: 16,
          color: kMainColor,
        );

        var dialog = CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "取消",
              style: style,
            ),
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();

                ImagePickers.openCamera(
                        cropConfig: CropConfig(enableCrop: true))
                    .then(
                  (media) {
                    kLog("media:$media");
                  },
                ).catchError(
                  (error) {
                    kLog("error:$error");
                  },
                );
              },
              child: Text(
                "拍照",
                style: style,
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();

                _selectImages();
              },
              child: Text(
                "从相册选取",
                style: style,
              ),
            ),
          ],
        );

        return dialog;
      },
    );
  }

  void _genderSelectAction() {
    void _uploadGender(sex) {
      Future.delayed(
        Duration(milliseconds: 400),
        () {
          if (sex != _account["sex"]) {
            showHUD();
            AccountApi().editUserInfo(
              {"sex": sex},
              (data, msg) {
                hideHUD();
                if (data != null) {
                  setState(() {
                    _account["sex"] = sex;
                    if (sex == 1) {
                      _account["sexName"] = "男";
                    } else {
                      _account["sexName"] = "女";
                    }
                    recordUserInfo(_account);
                  });
                } else {
                  showToast(msg, context);
                }
              },
            );
          }
        },
      );
    }

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        var style = TextStyle(
          fontSize: 16,
          color: kMainColor,
        );

        var unstyle = TextStyle(
          fontSize: 16,
          color: rgba(153, 153, 153, 1),
        );

        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _uploadGender(1);
              },
              child: Text(
                "男",
                style: _account["sexName"] == "男" ? style : unstyle,
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _uploadGender(2);
              },
              child: Text(
                "女",
                style: _account["sexName"] == "女" ? style : unstyle,
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "取消",
              style: style,
            ),
          ),
        );
      },
    );
  }

  void _birthdaySelectAction() async {
    DateTime _date = await showDatePicker(
      context: context,
      initialDate: _seletedDate,
      firstDate: DateTime.utc(1900),
      lastDate: DateTime.utc(DateTime.now().year + 1),
    );

    if (_date != null) {
      Future.delayed(
        Duration(milliseconds: 400),
        () {
          var birthday = "${_date.toString().split(" ").first}";
          if (birthday != _account["birthday"]) {
            showHUD();
            AccountApi().editUserInfo(
              {"birthday": birthday},
              (data, msg) {
                hideHUD();
                if (data != null) {
                  setState(() {
                    _account["birthday"] = birthday;
                    recordUserInfo(_account);
                    _seletedDate = _date;
                  });
                } else {
                  showToast(msg, context);
                }
              },
            );
          }
        },
      );
    }
  }

  void _localeHandle(String location, String locationID) {
    var provinceId = "";
    var cityId = "";
    var areaId = "";
    locationID.split("-").forEach(
      (aID) {
        if (provinceId.length == 0) {
          provinceId = aID;
        } else if (cityId.length == 0) {
          cityId = aID;
        } else if (areaId.length == 0) {
          areaId = aID;
        }
      },
    );

    var provinceName = "";
    var cityName = "";
    var areaName = "";
    location.split("-").forEach(
      (locale) {
        if (provinceName.length == 0) {
          provinceName = locale;
        } else if (cityName.length == 0) {
          cityName = locale;
        } else if (areaName.length == 0) {
          areaName = locale;
        }
      },
    );

    Map<String, Object> parameters = {};
    if (provinceId != _account["provinceId"]) {
      parameters["provinceId"] = provinceId;
    }
    if (cityId != _account["cityId"]) {
      parameters["cityId"] = cityId;
    }
    if (areaId != _account["areaId"]) {
      parameters["areaId"] = areaId;
    }

    if (parameters.length > 0) {
      Future.delayed(
        Duration(milliseconds: 600),
        () {
          showHUD();
          AccountApi().editUserInfo(
            parameters,
            (data, msg) {
              hideHUD();
              if (data != null) {
                setState(() {
                  _account["provinceId"] = provinceId;
                  _account["cityId"] = cityId;
                  _account["areaId"] = areaId;
                  _account["provinceName"] = provinceName;
                  _account["cityName"] = cityName;
                  _account["areaName"] = areaName;
                  recordUserInfo(_account);
                });
              } else {
                showToast(msg, context);
              }
            },
          );
        },
      );
    }
  }

  /// 1 微信 2 QQ
  void _unBindAccount(type) {
    showHUD();
    AccountApi().unBindAccount(
      type,
      (data, msg) {
        hideHUD();
        if (data != null) {
          setState(() {
            if (type == 1) {
              _account["openId"] = "";
            } else if (type == 2) {
              _account["isQqBind"] = 0;
            }
            recordUserInfo(_account);
            showToast("解除绑定成功", context);
          });
        } else {
          showToast(msg, context);
        }
      },
    );
  }

  void _bindAccount(type, bindId) {
    showHUD();
    AccountApi().bindAccount(
      type,
      bindId,
      (data, msg) {
        hideHUD();
        if (data != null) {
          setState(() {
            if (type == 1) {
              _account["openId"] = bindId;
            } else if (type == 2) {
              _account["isQqBind"] = 1;
            }
            recordUserInfo(_account);
            showToast("绑定成功", context);
          });
        } else {
          showToast(msg, context);
        }
      },
    );
  }

  Map _account = {};
  void _refreshAccount() {
    AccountApi().loadLocalAccount(
      (user) {
        setState(() {
          _account = user;
          if (isStringEmpty(_account["birthday"]) == false) {
            _seletedDate = DateTime.parse(_account["birthday"]);
          }
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();

    this._refreshAccount();
    DartNotificationCenter.subscribe(
      channel: kRefreshAccountNotification,
      observer: this,
      onNotification: (options) {
        this._refreshAccount();
      },
    );
  }

  @override
  void didUpdateWidget(PersonInfoPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    this._refreshAccount();
  }

  @override
  void dispose() {
    DartNotificationCenter.unsubscribe(
        observer: this, channel: kRefreshAccountNotification);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "个人资料",
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return index == 0
              ? PersonPortraitCell(
                  avatar: _account["avatar"],
                  text: _infoList[index],
                  onTap: () {
                    this._avatarSelectAction();
                  },
                )
              : (index == 8 || index == 9)
                  ? PersonBindingCell(
                      text: _infoList[index],
                      binded: index == 8
                          ? _account["isQqBind"] == 1 ? true : false
                          : index == 9
                              ? isStringEmpty(_account["openId"]) == false
                                  ? true
                                  : false
                              : false,
                      iconPath: index == 8
                          ? "images/denglu-icon-qq@3x.png"
                          : "images/denglu-icon-weixin@3x.png",
                      onTap: (text) {
                        /// 1 微信 2 QQ
                        var type = 1;
                        ShareSDKPlatform platform =
                            ShareSDKPlatforms.wechatSession;
                        if (index == 8) {
                          type = 2;
                          platform = ShareSDKPlatforms.qq;
                        }

                        if (text == "解除绑定") {
                          this._unBindAccount(type);
                        } else {
                          showHUD();
                          SharesdkPlugin.auth(
                            platform,
                            null,
                            (state, user, error) {
                              if (state == SSDKResponseState.Success) {
                                this._bindAccount(type, user["uid"]);
                              } else if (state == SSDKResponseState.Cancel) {
                                kLog("取消");
                              } else if (state == SSDKResponseState.Fail) {
                                showToast("授权失败", context);
                              }

                              hideHUD();
                            },
                          );
                        }
                      },
                    )
                  : PersonInfoCell(
                      text: _infoList[index],
                      content: index == 1
                          ? _account["trueName"]
                          : index == 2
                              ? _account["nickname"]
                              : index == 3
                                  ? _account["sexName"]
                                  : index == 4
                                      ? _account["birthday"]
                                      : index == 5
                                          ? _account["gradeName"]
                                          : index == 6
                                              ? _area()
                                              : index == 7
                                                  ? _account["school"]
                                                  : null,
                      onTap: () {
                        if (index == 3) {
                          this._genderSelectAction();
                        } else if (index == 4) {
                          this._birthdaySelectAction();
                        } else if (index == 5) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return EducationListPage(
                                  educationHandle: (gradeId, gradeName) {
                                    _account["gradeName"] = gradeName;
                                    _account["gradeId"] = gradeId;
                                    recordUserInfo(_account);
                                    setState(() {});
                                  },
                                );
                              },
                            ),
                          );
                        } else if (index == 6) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return LocaleSelection(
                                  localeHandle:
                                      (location, locationID, areaName) {
                                    this._localeHandle(location, locationID);
                                  },
                                );
                              },
                            ),
                          );
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return InfoInputPage(
                                  title: _infoList[index],
                                );
                              },
                            ),
                          );
                        }
                      },
                    );
        },
        separatorBuilder: (context, index) {
          return Container(
            height: (index == 0 || index == 4 || index == 7) ? 7 : 1,
          );
        },
        itemCount: _infoList.length,
      ),
    );
  }
}
