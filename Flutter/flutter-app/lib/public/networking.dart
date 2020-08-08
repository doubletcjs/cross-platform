import 'package:common_utils/common_utils.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:dio/dio.dart';
import 'public.dart';
import 'package:http_parser/http_parser.dart';

final Map<String, Object> _baseHeaders = {};

final String kServerURL = "https://sj1-api.test.qiawei.com";

class AppInterceptors extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
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

  Future onResponse(Response response) async {
    kLog("请求成功");
    kLog("原始数据（测试环境可见）:${response.data}");
    return response;
  }

  Future onError(DioError e) async {
    if (e.response != null) {
      kLog("errror:${e.response}");
    } else {
      kLog("errror:$e");
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

  Future request(path, {queryParameters, data, options}) {
    return dio.request(path,
        queryParameters: queryParameters, data: data, options: options);
  }

  Future get(path, {queryParameters, options}) {
    return dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future post(path, {queryParameters, data, options, onSendProgress}) {
    return dio.post(
      path,
      queryParameters: queryParameters,
      data: data,
      options: options,
      onSendProgress: onSendProgress,
    );
  }

  Future put(path, {queryParameters, data, options}) {
    return dio.put(
      path,
      queryParameters: queryParameters,
      data: data,
      options: options,
    );
  }

  Future delete(path, {queryParameters, data, options}) {
    return dio.delete(
      path,
      queryParameters: queryParameters,
      data: data,
      options: options,
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
    if (ObjectUtil.isEmptyString(api)) {
      if (finish != null) {
        finish("api不能为空");
      }

      return;
    }

    if (ObjectUtil.isEmptyList(files)) {
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
      List<int> _imageData = files[idx].buffer.asUint8List();
      MultipartFile multipartFile = MultipartFile.fromBytes(
        _imageData,
        filename: "file.jpg",
        contentType: MediaType("image", "jpg"),
      );

      mFiles.add(MapEntry("files[]", multipartFile));
    }

    //封装文件data
    FormData formData = FormData.fromMap(dataMap);
    formData.files.addAll(mFiles);

    //处理请求头
    Map<String, Object> _reqestHeaders = {};
    if (headers != null) {
      _reqestHeaders.addAll(headers);
    }

    //开始上传
    void _handleUpload() async {
      //options
      Options options = Options(method: "POST");
      options.headers = _reqestHeaders;

      //开始请求
      try {
        Response _response = await DioManager().post(
          api,
          data: formData,
          options: options,
          onSendProgress: (count, total) {
            if (progress != null) {
              progress(count / total);
            }

            kLog("上传进度:${count / total}");
          },
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
          kLog("errror:${error.response}");
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
          kLog("errror:$error");
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
      if (ObjectUtil.isEmptyString(obj) == false) {
        _reqestHeaders["token"] = obj;
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
    Map<String, Object> _reqestHeaders = _baseHeaders;
    if (headers != null) {
      _reqestHeaders.addAll(headers);
    }

    //开始请求
    void _startRequest() async {
      Response _reqFuture;
      Options _options = Options(method: method, headers: _reqestHeaders);

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
          _requestHandleStatusCode(
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
      if (ObjectUtil.isEmptyString(obj) == false) {
        _reqestHeaders["token"] = obj;
      }
      _startRequest();
    });
  }

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
}
