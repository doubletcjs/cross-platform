import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'public.dart';
import 'loading.dart' show Loading;
import 'package:crypto/crypto.dart';
import 'dart:convert';

final Map<String, Object> _baseHeaders = {};

final String kServerURL = (kDebug() == true)
    ? "https://sj1-api.test.qiawei.com"
    : "https://ermeng-api.glzyb.com";

class AppInterceptors extends InterceptorsWrapper {
  // 错误码处理
  static _requestHandleStatusCode(int statusCode, Map data, Function finish) {
    // 470 填写基本资料 471 上传头像、填写期望
    // 401 token过期，强制退出
    if (statusCode == 470 || statusCode == 471) {
      Future.delayed(Duration(milliseconds: 100), () {
        DartNotificationCenter.post(
          channel: kAccountProfileNotification,
          options: {
            "status": statusCode,
          },
        );
      });
    } else if (statusCode == 401) {
      //强制退出
      recordToken("");
      recordUserID("");

      Future.delayed(Duration(milliseconds: 100), () {
        DartNotificationCenter.post(
          channel: kAccountHandleNotification,
          options: {
            "type": 2,
          },
        );
      });
    } else {
      Future.delayed(Duration(milliseconds: 100), () {
        if (ObjectUtil.isEmpty(data["message"]) == false) {
          if (finish != null) {
            finish(null, "${data['message']}");
          }
        } else {
          if (finish != null) {
            finish(null, "返回数据格式错误");
          }
        }
      });
    }
  }

  @override
  Future onRequest(RequestOptions options) async {
    if (options.extra != null && options.extra['loading'] == true) {
      Loading.show();
    }

    options.headers["t"] =
        (DateTime.now().millisecondsSinceEpoch / 1000).floor();
    options.headers["s"] = sha1.convert(
      utf8.encode((options.headers["token"] ?? "") +
          options.headers["t"].toString() +
          privateKey),
    );
    options.headers["User-Agent"] = kDeviceModel;

    kLog("请求url: ${options.uri}");
    kLog("请求method: ${options.method}");
    kLog("请求头: ${options.headers}");

    if (options.queryParameters != null) {
      kLog("请求参数 queryParameters: ${options.queryParameters}");
    }
    if (options.data != null) {
      kLog("请求参数 data: ${options.data}");
    }

    return options;
  }

  @override
  Future onResponse(Response response) async {
    Loading.hide();

    kLog("请求成功");
    kLog("原始数据（测试环境可见）:${response.data}");

    return response;
  }

  @override
  Future onError(DioError e) async {
    Loading.hide();

    if (e.response != null) {
      kLog("error:${e.response}");
      _requestHandleStatusCode(e.response.statusCode, e.response.data, () {});
    } else {
      kLog("error:$e");
    }
    return e;
  }
}

class DioManager {
  static final DioManager _shared = DioManager._internal();

  factory DioManager() => _shared;

  Dio dio;

  DioManager._internal() {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: kServerURL,
        headers: _baseHeaders,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        connectTimeout: 15000,
      );
      dio = Dio(options);
      dio..interceptors.add(AppInterceptors());
    }
  }

  Future request(String path, {queryParameters, data, Options options}) {
    return dio.request(path,
        queryParameters: queryParameters, data: data, options: options);
  }

  Future get(String path, {queryParameters, Options options}) {
    return dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future post(String path,
      {queryParameters, data, Options options, onSendProgress}) {
    return dio.post(
      path,
      queryParameters: queryParameters,
      data: data,
      options: options,
      onSendProgress: onSendProgress,
    );
  }

  Future put(String path, {queryParameters, data, Options options}) {
    return dio.put(
      path,
      queryParameters: queryParameters,
      data: data,
      options: options,
    );
  }

  Future delete(String path, {queryParameters, data, Options options}) {
    return dio.delete(
      path,
      queryParameters: queryParameters,
      data: data,
      options: options,
    );
  }

  //非图片。files，类型是File，以获取后缀名
  Future uploadFiles(String path, List files,
      {queryParameters,
      data,
      headers,
      Options options,
      List<String> fileNames,
      Function(double progress) progress}) {
    if (ObjectUtil.isEmptyString(path)) {
      throw "path 不能为空";
    }

    if (ObjectUtil.isEmptyList(files)) {
      throw "文件列表不能为空";
    }

    //额外参数
    Map<String, Object> dataMap = {};
    if (queryParameters != null) {
      dataMap.addAll(queryParameters);
    }
    if (data != null) {
      dataMap.addAll(data);
    }

    //处理请求头
    Map<String, Object> _requestHeaders = {};
    if (headers != null) {
      _requestHeaders.addAll(headers);
    }

    //获取媒体类型
    MediaType _getMediaType(String fileExt) {
      switch (fileExt.toLowerCase()) {
        case ".jpg":
        case ".jpeg":
        case ".jpe":
          return new MediaType("image", "jpeg");
        case ".png":
          return new MediaType("image", "png");
        case ".bmp":
          return new MediaType("image", "bmp");
        case ".gif":
          return new MediaType("image", "gif");
        case ".json":
          return new MediaType("application", "json");
        case ".svg":
        case ".svgz":
          return new MediaType("image", "svg+xml");
        case ".mp3":
          return new MediaType("audio", "mpeg");
        case ".mp4":
          return new MediaType("video", "mp4");
        case ".htm":
        case ".html":
          return new MediaType("text", "html");
        case ".css":
          return new MediaType("text", "css");
        case ".csv":
          return new MediaType("text", "csv");
        case ".txt":
        case ".text":
        case ".conf":
        case ".def":
        case ".log":
        case ".in":
          return new MediaType("text", "plain");
      }

      return null;
    }

    //文件数组
    //https://github.com/flutterchina/dio/blob/master/README-ZH.md#formdata
    List<MapEntry<String, MultipartFile>> mFiles = List();
    for (var idx = 0; idx < files.length; idx++) {
      MultipartFile multipartFile;

      if (files[idx] is File) {
        File _file = files[idx];
        String _filePath = _file.path;
        var _fileName = _filePath.substring(
            _filePath.lastIndexOf("/") + 1, _filePath.length);
        String _fileSuffix = _fileName.substring(
            _fileName.lastIndexOf(".") + 1, _fileName.length);

        multipartFile = MultipartFile.fromFileSync(
          _file.path,
          filename: "file.$_fileSuffix",
          contentType: _getMediaType(_fileSuffix),
        );
      } else {
        List<int> _imageData = files[idx].buffer.asUint8List();
        multipartFile = MultipartFile.fromBytes(
          _imageData,
          filename: "file.jpg",
          contentType: MediaType("image", "jpg"),
        );
      }

      mFiles.add(MapEntry("files[]", multipartFile));
    }

    //封装文件data
    FormData formData = FormData.fromMap(dataMap);
    formData.files.addAll(mFiles);

    return post(
      path,
      data: formData,
      options: options,
      onSendProgress: (count, total) {
        if (progress != null) {
          progress(count / total);
        }

        kLog("上传进度:${count / total}");
      },
    );
  }
}

class Networking {
  // 文件上传
  static uploadFiles(String api, List files, Function finish,
      {Function(double progress) progress,
      List<String> fileNames,
      Map<String, Object> params,
      Map<String, Object> headers}) async {
    //处理请求头
    Map<String, Object> _requestHeaders = _baseHeaders;
    if (headers != null) {
      _requestHeaders.addAll(headers);
    }

    //开始上传
    void _handleUpload() async {
      //开始请求
      try {
        Response _response = await DioManager().uploadFiles(
          api,
          files,
          progress: progress,
          fileNames: fileNames,
          data: params,
          headers: _requestHeaders,
        );

        if (_response.statusCode == 200) {
          Map data = _response.data;
          if (ObjectUtil.isEmpty(data) == false) {
            String code = "${data['code']}";
            if (code == "0") {
              if (ObjectUtil.isEmpty(data["data"]) == false) {
                Future.delayed(Duration(milliseconds: 100), () {
                  if (finish != null) {
                    finish(data["data"]["urls"], null);
                  }
                });
              } else {
                Future.delayed(Duration(milliseconds: 100), () {
                  if (ObjectUtil.isEmpty(data["message"]) == false) {
                    if (finish != null) {
                      finish("${data['message']}", null);
                    }
                  } else {
                    if (finish != null) {
                      finish(null, "返回数据格式错误");
                    }
                  }
                });
              }
            }
          } else {
            Future.delayed(Duration(milliseconds: 100), () {
              if (finish != null) {
                finish(null, _response.statusMessage);
              }
            });
          }
        } else {
          Future.delayed(Duration(milliseconds: 100), () {
            if (finish != null) {
              finish(null, _response.statusMessage);
            }
          });
        }
      } on DioError catch (error) {
        if (error.response != null) {
          Future.delayed(Duration(milliseconds: 100), () {
            if (finish != null) {
              Map data = error.response.data;
              if (ObjectUtil.isEmpty(data["message"]) == false) {
                finish(null, "${data['message']}");
              } else {
                finish(null, error.toString() + "\n" + api);
              }
            }
          });
        } else {
          Future.delayed(Duration(milliseconds: 100), () {
            if (finish != null) {
              finish(null, error.toString() + "\n" + api);
            }
          });
        }
      } catch (e) {
        Future.delayed(Duration(milliseconds: 100), () {
          if (finish != null) {
            finish(null, e);
          }
        });
      }
    }

    //读取token
    token((obj) {
      if (ObjectUtil.isEmpty(obj) == false) {
        _requestHeaders["token"] = obj;
      }

      _handleUpload();
    });
  }

  // 网络请求封装
  static requestBase(
    String api,
    Function finish, {
    String method = "POST",
    Map<String, Object> params,
    Map<String, Object> headers,
  }) async {
    //api空判断
    if (ObjectUtil.isEmptyString(api) == true) {
      if (finish != null) {
        finish(null, "api不能为空");
      }

      return;
    }

    //处理请求头
    Map<String, Object> _requestHeaders = _baseHeaders;
    if (headers != null) {
      _requestHeaders.addAll(headers);
    }

    //开始请求
    void _startRequest() async {
      Response _reqFuture;
      Options _options = Options(method: method, headers: _requestHeaders);

      try {
        if (_options.method == "GET") {
          _reqFuture = await DioManager().get(kServerURL + api,
              queryParameters: params, options: _options);
        } else if (_options.method == "PUT") {
          _reqFuture = await DioManager()
              .put(kServerURL + api, data: params, options: _options);
        } else if (_options.method == "DELETE") {
          _reqFuture = await DioManager()
              .delete(kServerURL + api, data: params, options: _options);
        } else {
          _reqFuture = await DioManager()
              .post(kServerURL + api, data: params, options: _options);
        }

        if (_reqFuture.statusCode == 200) {
          Map data = _reqFuture.data;
          if (ObjectUtil.isEmpty(data) == false) {
            String code = "${data['code']}";
            if (code == "0") {
              if (ObjectUtil.isEmpty(data["data"]) == false) {
                Future.delayed(Duration(milliseconds: 100), () {
                  if (finish != null) {
                    finish(data["data"], null);
                  }
                });
              } else {
                Future.delayed(Duration(milliseconds: 100), () {
                  if (ObjectUtil.isEmpty(data["message"]) == false) {
                    if (finish != null) {
                      finish("${data['message']}", null);
                    }
                  } else {
                    if (finish != null) {
                      finish(null, "返回数据格式错误");
                    }
                  }
                });
              }
            }
          } else {
            Future.delayed(Duration(milliseconds: 100), () {
              if (finish != null) {
                finish(null, _reqFuture.statusMessage);
              }
            });
          }
        } else {
          Future.delayed(Duration(milliseconds: 100), () {
            if (finish != null) {
              finish(null, _reqFuture.statusMessage);
            }
          });
        }
      } on DioError catch (error) {
        if (error.response != null) {
          AppInterceptors._requestHandleStatusCode(
              error.response.statusCode, error.response.data, finish);
        } else {
          Future.delayed(Duration(milliseconds: 100), () {
            if (finish != null) {
              finish(null, error.toString() + "\n" + api);
            }
          });
        }
      }
    }

    //读取token
    token((obj) {
      if (ObjectUtil.isEmpty(obj) == false) {
        _requestHeaders["token"] = obj;
      }
      _startRequest();
    });
  }
}
