import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';

class SettingAccountCell extends StatelessWidget {
  String avatar;
  String nickname;
  kVoidFunctionBlock onTap;

  SettingAccountCell({this.avatar, this.nickname, this.onTap});

  @override
  Widget build(BuildContext context) {
    return buttonWidget(
      Container(
        height: 64,
        padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                avatar == null
                    ? Image.asset(
                        "images/user_head_default@3x.png",
                        width: 37,
                        height: 37,
                      )
                    : radiusNetworkImage(
                        avatar,
                        37,
                        37,
                        placeholder: "images/user_head_default@3x.png",
                        radius: BorderRadius.circular(37 / 2),
                      ),
                SizedBox(
                  width: 18,
                ),
                Container(
                  width: 200,
                  child: Text(
                    nickname == null ? "" : nickname,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(23, 23, 23, 1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 18,
                ),
              ],
            ),
            Image.asset(
              "images/jiantou@3x.png",
              fit: BoxFit.fitWidth,
              width: 6,
            ),
          ],
        ),
      ),
      context,
      color: Colors.white,
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
    );
  }
}

class SettingCell extends StatefulWidget {
  String text = "";
  kVoidFunctionBlock tapHandle;

  SettingCell({this.text, this.tapHandle});

  @override
  _SettingCellState createState() => _SettingCellState();
}

class _SettingCellState extends State<SettingCell> {
  bool _downLoadStatus = false;
  bool _notificationStatus = false;
  String _version = "";
  String _cacheSize = "";

  Widget _switchButton({Function onTap, bool isOn = false}) {
    return buttonWidget(
      Image.asset(
        isOn == true
            ? "images/kaiguan-kai@3x.png"
            : "images/kaiguan-guan@3x.png",
        width: 37,
        height: 21,
      ),
      context,
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      radius: BorderRadius.circular(21 / 2),
    );
  }

  void _appVersion() {
    PackageInfo.fromPlatform().then(
      (PackageInfo packageInfo) {
        setState(() {
          _version = packageInfo.version;
        });
      },
    );
  }

  void _clearCache() async {
    ///递归方式删除目录
    Future<Null> _deleteDir(FileSystemEntity file) async {
      try {
        if (file is Directory) {
          final List<FileSystemEntity> children = file.listSync();
          for (final FileSystemEntity child in children) {
            await _deleteDir(child);
          }
        }

        Directory tempDir = await getTemporaryDirectory();
        if (file.path != tempDir.path) {
          await file.delete();
        }
      } catch (e) {
        print(e);
      }
    }

    try {
      Directory tempDir = await getTemporaryDirectory();
      //删除缓存目录
      await _deleteDir(tempDir);
      _cacheSize = await loadAppCache();

      showToast("清除缓存成功", context);
    } catch (e) {
      print(e);
      showToast("清除缓存失败", context);
    } finally {}
  }

  @override
  void initState() {
    super.initState();

    this._appVersion();
    Future<String> future = loadAppCache();
    future.then((size) {
      setState(() {
        _cacheSize = size;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return buttonWidget(
      Container(
        padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
        height: 49,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              this.widget.text,
              style: TextStyle(
                fontSize: 14,
                color: rgba(23, 23, 23, 1),
              ),
            ),
            Row(
              children: <Widget>[
                this.widget.text == "检查更新"
                    ? Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                        child: Text(
                          "版本号$_version",
                          style: TextStyle(
                            fontSize: 12,
                            color: rgba(136, 136, 136, 0.8),
                          ),
                        ),
                      )
                    : this.widget.text == "清除缓存"
                        ? Container(
                            padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                            child: Text(
                              "$_cacheSize",
                              style: TextStyle(
                                fontSize: 12,
                                color: rgba(136, 136, 136, 0.8),
                              ),
                            ),
                          )
                        : Container(),
                this.widget.text == "2G/3G/4G播放和下载"
                    ? _switchButton(
                        onTap: () {
                          setState(
                            () {
                              _downLoadStatus = !_downLoadStatus;
                            },
                          );
                        },
                        isOn: _downLoadStatus,
                      )
                    : this.widget.text == "新消息通知"
                        ? _switchButton(
                            onTap: () {
                              setState(
                                () {
                                  _notificationStatus = !_notificationStatus;
                                },
                              );
                            },
                            isOn: _notificationStatus,
                          )
                        : Image.asset(
                            "images/jiantou@3x.png",
                            fit: BoxFit.fitWidth,
                            width: 6,
                          ),
              ],
            ),
          ],
        ),
      ),
      context,
      color: Colors.white,
      onTap:
          (this.widget.text == "2G/3G/4G播放和下载" || this.widget.text == "新消息通知")
              ? null
              : this.widget.text == "清除缓存"
                  ? () {
                      this._clearCache();
                    }
                  : () {
                      this.widget.tapHandle();
                    },
    );
  }
}
