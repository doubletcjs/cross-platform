import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hksy_flutter/public/public.dart';
// import 'package:dart_notification_center/dart_notification_center.dart';

final Map<String, Object> _baseHeaders = {
  "charset": "utf-8",
  "content-type": "application/x-www-form-urlencoded"
};

final String kServerURL = "http://39.100.54.18/tbr/";
final String kQrcodeURL = "http://39.100.54.18/";

final kRequestSuccessCode = "200";

class Networking {
  static uploadFiles(String api, List files, Function finish,
      {Function(double progress) progress,
      List<String> fileNames,
      Map<String, Object> params,
      Map<String, Object> headers}) async {
    if (isStringEmpty(api) == true) {
      api = "/app/index/imgUpload";
    }

    if (files == null || files.length == 0) {
      if (finish != null) {
        finish(null, "文件列表不能为空");
      }

      return;
    }

    //额外参数
    Map<String, Object> dataMap = {};
    if (params != null) {
      dataMap.addAll(params);
    }

    //文件数组
    //https://github.com/flutterchina/dio/blob/master/README-ZH.md#formdata
    List<MapEntry<String, MultipartFile>> mFiles = List();
    for (var idx = 0; idx < files.length; idx++) {
      if (files[idx] is File) {
        File file = files[idx];
        String path = file.path;
        var name = path.substring(path.lastIndexOf("/") + 1, path.length);
        String suffix = name.substring(name.lastIndexOf(".") + 1, name.length);

        //data <path> name <file> filename <upload_image_*.***>
        MultipartFile multipartFile = MultipartFile.fromFileSync(path,
            filename: "upload_file_$idx.$suffix");
        mFiles.add(MapEntry("files", multipartFile));
      } else {
        List<int> fileData = files[idx];
        MultipartFile multipartFile = MultipartFile.fromBytes(fileData);
        mFiles.add(MapEntry("files", multipartFile));
      }
    }

    //封装文件data
    FormData formData = FormData.fromMap(dataMap);
    formData.files.addAll(mFiles);

    //处理请求头
    Map<String, Object> _reqestHeaders = _baseHeaders;
    if (headers != null) {
      _reqestHeaders.addAll(headers);
    }

    if (isStringEmpty(token()) == false) {
      _reqestHeaders["token"] = token();
    }

    //options
    Options options = Options(method: "POST");
    options.headers = _reqestHeaders;

    kLog("上传 请求url: " + "$api");
    kLog("上传 请求参数: " + "$_reqestHeaders");
    kLog("上传 额外参数: " + "$params");

    //开始请求
    Response _response;
    try {
      _response = await Dio().post(
        kServerURL + api,
        data: formData,
        options: options,
        onSendProgress: (count, total) {
          if (progress != null) {
            progress(count / total);
          }

          kLog("上传进度:${count / total}");
        },
      );

      if ("${_response.statusCode}" == kRequestSuccessCode) {
        kLog("上传 原始数据:${_response.data}");
        var data = _response.data["data"];
        List _fileNames = data["fileNames"];
        kLog("上传 _fileNames:$_fileNames");
        if (_fileNames == null || _fileNames.length == 0) {
          if (finish != null) {
            finish(null, "返回图片url为空！");
          }
        } else {
          if (finish != null) {
            finish(_fileNames, null);
          }
        }
      }
    } on DioError catch (error) {
      if (finish != null) {
        finish(null, error.message);
      }
    }
  }

  static requestBase(String api, Function finish,
      {String method = "POST",
      Map<String, Object> params,
      Map<String, Object> headers}) async {
    if (isStringEmpty(api) == true) {
      if (finish != null) {
        finish(null, "api不能为空");
      }

      return;
    }

    //处理请求头
    Map<String, Object> _reqestHeaders = {};
    if (headers != null) {
      _reqestHeaders.addAll(headers);
    }

    if (isStringEmpty(token()) == false) {
      _reqestHeaders["token"] = token();
    }

    var _dio = Dio();
    Response _reqFuture;
    Options _options = Options(method: method);
    _options.headers = _reqestHeaders;

    try {
      kLog("请求url: " + kServerURL + api);
      kLog("请求method: " + _options.method);
      kLog("请求头: " + _options.headers.toString());

      if (params != null) {
        kLog("请求参数: " + params.toString());
      }

      if (_options.method == "GET") {
        _reqFuture = await _dio.get(kServerURL + api,
            queryParameters: params, options: _options);
      } else {
        _reqFuture = await _dio.post(kServerURL + api,
            queryParameters: params, options: _options);
      }

      if (_reqFuture.statusCode == 200) {
        Map data = _reqFuture.data;
        if (data != null) {
          // kLog("原始数据:$data");
          String code = "${data["code"]}";
          if (code == kRequestSuccessCode) {
            if (data["token"] != null &&
                isStringEmpty(data["token"]) == false) {
              recordToken(data["token"]);
            }

            if (data["data"] != null) {
              if (finish != null) {
                finish(data["data"], null);
              }
            } else {
              if (isStringEmpty(data["msg"]) == false) {
                if (finish != null) {
                  finish(data["msg"], null);
                }
              } else {
                if (finish != null) {
                  finish(null, "返回数据格式错误");
                }
              }
            }
          }
          /*
            else if (code == kForceLogoutCode) {
              if (isStringEmpty(data["msg"]) == false) {
                if (finish != null) {
                  finish(null, data["msg"]);
                }
              } else {
                if (finish != null) {
                  finish(null, "登录异常，请重新登录！");
                }
              }
              kLog("原始数据:$data");
              Future.delayed(
                Duration(milliseconds: 800),
                () {
                  DartNotificationCenter.post(
                      channel: kForceLogoutNotification, options: null);
                },
              );
            } 
            */
          else {
            kLog("原始数据:$data");
            if (isStringEmpty(data["msg"]) == false) {
              if (finish != null) {
                finish(null, data["msg"]);
              }
            } else {
              if (finish != null) {
                finish(null, "返回数据格式错误");
              }
            }
          }
        } else {
          if (finish != null) {
            finish(null, _reqFuture.statusMessage);
          }
        }
      } else {
        if (finish != null) {
          finish(null, _reqFuture.statusMessage);
        }
      }
    } on DioError catch (error) {
      if (finish != null) {
        finish(null, error.message + "\n" + api);
        kLog("error:$error");
      }
    }
  }
}
