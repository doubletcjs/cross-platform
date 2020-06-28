import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hksy_flutter/public/public.dart';

import 'public.dart';
// import 'package:dart_notification_center/dart_notification_center.dart';

final Map<String, Object> _baseHeaders = {
  "charset": "utf-8",
  "content-type": "application/x-www-form-urlencoded"
};

final String kServerURL = "http://39.100.54.18/tbr/";
final String kQrcodeURL = "http://39.100.54.18";

final kRequestSuccessCode = "200";

class Networking {
  static uploadFiles(String api, List files, Function finish,
      {Function(double progress) progress,
      List<String> fileNames,
      Map<String, Object> params,
      Map<String, Object> headers}) async {
    if (isStringEmpty(api)) {
      if (finish != null) {
        finish("api不能为空");
      }

      return;
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
        mFiles.add(MapEntry("file", multipartFile));
        kLog("name: " + "upload_file_$idx.$suffix");
      } else {
        List<int> fileData = files[idx];
        MultipartFile multipartFile = MultipartFile.fromBytes(fileData);
        mFiles.add(MapEntry("file", multipartFile));
      }
    }

    //封装文件data
    FormData formData = FormData.fromMap(dataMap);
    formData.files.addAll(mFiles);

    //处理请求头
    Map<String, Object> _reqestHeaders = {"charset": "utf-8"};
    if (headers != null) {
      _reqestHeaders.addAll(headers);
    }

    void _handleUpload() async {
      //options
      Options options = Options(method: "POST");
      options.headers = _reqestHeaders;

      kLog("上传 请求url: " + kServerURL + "$api");
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

        kLog("上传 原始数据:${_response.toString()}");
        if ("${_response.statusCode}" == kRequestSuccessCode) {
          // kLog("上传 原始数据:${_response.data}");
          var data = _response.data;
          String _fileName = "${data["msg"]}";
          // kLog("上传 _fileName:$_fileName");
          if (isStringEmpty(_fileName)) {
            if (finish != null) {
              finish(null, "返回图片url为空！");
            }
          } else {
            if (finish != null) {
              finish(_fileName, null);
            }
          }
        }
      } on DioError catch (error) {
        kLog("error:" + error.toString());
        if (finish != null) {
          finish(null, error.message);
        }
      }
    }

    token((obj) {
      if (isStringEmpty(obj) == false) {
        _reqestHeaders["token"] = obj;
      }

      _handleUpload();
    });
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
    Map<String, Object> _reqestHeaders = _baseHeaders;
    if (headers != null) {
      _reqestHeaders.addAll(headers);
    }

    void _handlling() async {
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
            if (isStringEmpty(data["state"]) == false) {
              code = "${data["state"]}";
            }

            if (code == kRequestSuccessCode) {
              if (data["token"] != null &&
                  isStringEmpty("${data["token"]}") == false) {
                recordToken(data["token"]);
              }

              if (isStringEmpty("${data["data"]}") == false) {
                if (finish != null) {
                  finish(data["data"], null);
                }
              } else {
                kLog("原始数据:$data");
                if (isStringEmpty("${data["msg"]}") == false) {
                  if (finish != null) {
                    finish("${data["msg"]}", null);
                  }
                } else {
                  if (finish != null) {
                    finish(null, "返回数据格式错误");
                  }
                }
              }
            } else {
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

    token((obj) {
      if (isStringEmpty(obj) == false) {
        _reqestHeaders["token"] = obj;
      }

      _handlling();
    });
  }
}
