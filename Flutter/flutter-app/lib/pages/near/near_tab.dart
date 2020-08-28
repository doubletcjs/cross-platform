import 'dart:async';

import 'package:amap_location_flutter_plugin/amap_location_flutter_plugin.dart';
import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../../public/public.dart';
import 'near_list.dart';
import '../account/api/account_api.dart';
import 'package:yue_mei/public/scale_tabbar.dart';

class NearPage extends StatefulWidget {
  NearPage({Key key}) : super(key: key);

  @override
  _NearPageState createState() => _NearPageState();
}

class _NearPageState extends State<NearPage>
    with SingleTickerProviderStateMixin {
  List<String> _tabs = [
    "附近",
    "在线",
    "新人",
    "认证",
    "推荐",
  ];

  TabController _tabController;
  bool _firstLoading = true;

  //定位相关
  Map<String, Object> _locationData;
  AmapLocationFlutterPlugin _locationPlugin;
  Timer _locationTimer;

  //发送切换刷新数据通知
  void _switchReloadData({bool showHud = false}) {
    if (_locationData == null) {
      if (showHud) {
        XsProgressHud.show(context);
      }

      this._refreshLocationService();
    } else {
      DartNotificationCenter.post(channel: "kNearTabSwitch", options: {
        "index": _tabController.index,
        "longitude": "${_locationData['longitude']}",
        "latitude": "${_locationData['latitude']}",
      });
    }
  }

  //定位超时
  void _closeLocationTimer() {
    if (_locationTimer != null) {
      _locationTimer.cancel();
      _locationTimer = null;
      kLog("关闭倒计时");
    }
  }

  void _startLocationTimer() {
    this._closeLocationTimer();
    _locationTimer = Timer.periodic(Duration(seconds: 15), (timer) {
      this._closeLocationTimer();
      setState(() {
        XsProgressHud.hide();
        _firstLoading = false;
        //停止定位
        _locationPlugin.stopLocation();
        _locationData = null;
        if (_locationPlugin != null) {
          _locationPlugin.destroy();
          _locationPlugin = null;
        }
      });
    });
  }

  //定位权限
  void _initLocationPlugin() {
    if (_locationPlugin == null) {
      _locationPlugin = AmapLocationFlutterPlugin();
      //配置
      // _locationPlugin.setLocationOption(
      //   AMapLocationOption(
      //       // needAddress: false,
      //       // onceLocation: true,
      //       ),
      // );
      //监听
      _locationPlugin.onLocationChanged().listen((Map<String, Object> result) {
        if (result != null) {
          if (result["errorCode"] == null && _locationData == null) {
            this._closeLocationTimer();
            //停止定位
            _locationPlugin.stopLocation();
            kLog("停止定位");

            setState(() {
              _locationData = result;
              _firstLoading = false;
              kLog("定位信息:$_locationData");

              Future.delayed(Duration(milliseconds: 400), () {
                XsProgressHud.hide();
                this._switchReloadData();

                Future.delayed(Duration(milliseconds: 1600), () {
                  AccountApi.priceList((data, msg) {
                    if (data != null) {
                      priceList = data;
                    }
                  });
                });
              });
            });
          }
        } else {
          XsProgressHud.hide();
          showToast("无法获取当前位置！", context);

          setState(() {
            _firstLoading = false;
          });
        }
      });
    }
  }

  void _refreshLocationService() {
    kLog("获取定位授权");
    _locationPlugin.requestLocationPermission().then((enabled) {
      if (enabled) {
        //开始定位
        kLog("开始定位");
        this._startLocationTimer();
        _locationPlugin.startLocation();
      } else {
        showToast("无法开启定位服务", context);
        XsProgressHud.hide();

        setState(() {
          _firstLoading = false;
          _locationData = null;
        });
      }
    }).catchError((error) {
      kLog("无法开启定位服务:$error");
      showToast("无法开启定位服务", context);
      XsProgressHud.hide();

      setState(() {
        _firstLoading = false;
        _locationData = null;
      });
    }).timeout(Duration(seconds: 10), onTimeout: () {
      showToast("无法开启定位服务", context);
      XsProgressHud.hide();

      setState(() {
        _firstLoading = false;
        _locationData = null;
      });
    });
  }

  //重新定位
  void _reLocation() {
    setState(() {
      _firstLoading = false;
      _locationData = null;
    });

    XsProgressHud.show(context);
    this._refreshLocationService();
  }

  //刷新用户信息
  void _refreshAccount() async {
    XsProgressHud.show(context);
    AccountApi.profile((data, msg) {
      this._switchReloadData();

      if (data != null) {
        currentAccount = Map.from(data);
        kLog("首页刷新用户信息");
      }

      Future.delayed(Duration(milliseconds: 100), () {
        DartNotificationCenter.post(
            channel: kAccountHandleNotification,
            options: {
              "type": 3,
            });
      });
    });
  }

  @override
  void initState() {
    //初始化定位插件
    this._initLocationPlugin();

    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      this._switchReloadData(showHud: true);
    });

    Future.delayed(Duration(milliseconds: 100), () {
      this._refreshAccount();
    });
  }

  @override
  void dispose() {
    super.dispose();

    if (_locationPlugin != null) {
      _locationPlugin.destroy();
      _locationPlugin = null;
    }
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Stack(
        children: <Widget>[
          transparentAppBar(
            brightness: Brightness.light,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(
                0, MediaQuery.of(context).padding.top + 8, 0, 0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ScaleTabBar(
                  controller: _tabController,
                  indicator: RoundUnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 3,
                      color: rgba(18, 18, 18, 1),
                    ),
                    insets: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  ),
                  tabs: _tabs.map(
                    (tab) {
                      return Tab(
                        text: tab,
                      );
                    },
                  ).toList(),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3,
                  labelColor: rgba(18, 18, 18, 1),
                  isScrollable: true,
                  unselectedLabelColor: rgba(153, 153, 153, 1),
                  labelStyle: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Expanded(
                  child: _firstLoading == true
                      ? Container()
                      : _locationData == null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  //未开启定位权限
                                  Text(
                                    "未开启定位权限",
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: rgba(16, 16, 16, 1),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 17.5,
                                  ),
                                  //启用定位以查看附近的人
                                  Text(
                                    "启用定位以查看附近的人",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: rgba(153, 153, 153, 1),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 27.5,
                                  ),
                                  //启用定位
                                  Container(
                                    width: 121,
                                    height: 44,
                                    child: FlatButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        this._reLocation();
                                      },
                                      child: Text(
                                        "启用定位",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: rgba(255, 255, 255, 1),
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(44 / 2),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          rgba(255, 44, 96, 1),
                                          rgba(255, 114, 81, 1),
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(44 / 2),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : TabBarView(
                              // physics: NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: _tabs.map((tab) {
                                int index = _tabs.indexOf(tab);
                                return NearList(listType: index);
                              }).toList(),
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//定制 TabIndicator
class RoundUnderlineTabIndicator extends Decoration {
  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const RoundUnderlineTabIndicator({
    this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
    this.insets = EdgeInsets.zero,
  })  : assert(borderSide != null),
        assert(insets != null);

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;

  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the
  /// tab indicator's bounds in terms of its (centered) tab widget with
  /// [TabIndicatorSize.label], or the entire tab with [TabIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  @override
  Decoration lerpFrom(Decoration a, double t) {
    if (a is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration lerpTo(Decoration b, double t) {
    if (b is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _UnderlinePainter createBoxPainter([VoidCallback onChanged]) {
    return _UnderlinePainter(this, onChanged);
  }
}

class _UnderlinePainter extends BoxPainter {
  _UnderlinePainter(this.decoration, VoidCallback onChanged)
      : assert(decoration != null),
        super(onChanged);

  final RoundUnderlineTabIndicator decoration;

  BorderSide get borderSide => decoration.borderSide;
  EdgeInsetsGeometry get insets => decoration.insets;

  Rect _indicatorRectFor(Rect rect, TextDirection textDirection) {
    assert(rect != null);
    assert(textDirection != null);
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);
    //希望的宽度
    double wantWidth = 6;
    //取中间坐标
    double cw = (indicator.left + indicator.right) / 2;
    return Rect.fromLTWH(cw - wantWidth / 2,
        indicator.bottom - borderSide.width, wantWidth, borderSide.width);
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size;
    final TextDirection textDirection = configuration.textDirection;
    final Rect indicator =
        _indicatorRectFor(rect, textDirection).deflate(borderSide.width / 2.0);
    // final Paint paint = borderSide.toPaint()..strokeCap = StrokeCap.square;
    // 改为圆角
    final Paint paint = borderSide.toPaint()..strokeCap = StrokeCap.round;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}
