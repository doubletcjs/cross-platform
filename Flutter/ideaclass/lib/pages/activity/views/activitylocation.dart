import 'package:flutter/material.dart';
import 'package:ideaclass/pages/activity/api/activityapi.dart';
import 'package:ideaclass/pages/commons/localeselection.dart';
import 'package:ideaclass/public/public.dart';
import 'package:geopoint/geopoint.dart';
import 'package:geopoint_location/geopoint_location.dart';

class ActivityLocation extends StatefulWidget {
  kObjectFunctionBlock areaHandle;

  ActivityLocation({this.areaHandle});

  @override
  _ActivityLocationState createState() => _ActivityLocationState();
}

class _ActivityLocationState extends State<ActivityLocation> {
  int _locationStatus = 0;
  // 0 获取中 1 获取成功 2 获取失败
  String _location = "";

  void _getAreaId(String areaName) {
    if (areaName != null && areaName.length > 0) {
      ActivityApi().getAreaId(
        areaName,
        (data, msg) {
          if (data != null) {
            if (this.widget.areaHandle != null) {
              this.widget.areaHandle("${data["areaId"]}");
            }
          } else {
            showToast(msg, context);
            if (this.widget.areaHandle != null) {
              this.widget.areaHandle("");
            }
          }
        },
      );
    } else {
      if (this.widget.areaHandle != null) {
        this.widget.areaHandle("");
      }
    }
  }

  void _locationSelection() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return LocaleSelection(
            localeHandle: (location, locationID, areaName) {
              setState(
                () {
                  _locationStatus = 1;
                  _location = location.replaceAll("-", "");
                },
              );

              this._getAreaId(areaName);
            },
          );
        },
      ),
    );
  }

  void _refreshLocation() {
    setState(
      () {
        _locationStatus = 0;
      },
    );

    Future.delayed(
      Duration(milliseconds: 600),
      () {
        this.requestLocation();
      },
    );
  }

  void requestLocation({bool initLocation = false}) {
    Future<GeoPoint> _future =
        geoPointFromLocation(name: "Current", withAddress: true);
    _future.then(
      (geo) {
        var location = geo.toMap();
        _location = "${location["region"] == null ? "" : location["region"]}" +
            "${location["locality"] == null ? "" : location["locality"]}" +
            "${location["sublocality"] == null ? "" : location["sublocality"]}";
        if (_location.length == 0) {
          _locationStatus = 2;
        } else {
          _locationStatus = 1;
        }

        var areaName = location["sublocality"];
        if (areaName == null) {
          areaName = location["locality"];
        }

        if (areaName == null) {
          areaName = location["region"];
        }

        this._getAreaId(areaName);
        Future.delayed(
          Duration(milliseconds: 800),
          () {
            setState(
              () {},
            );
          },
        );
      },
    ).catchError(
      (error) {
        _locationStatus = 2;
        showToast("$error", context, gravity: 1);

        if (this.widget.areaHandle != null) {
          this.widget.areaHandle("");
        }
        Future.delayed(
          Duration(milliseconds: 800),
          () {
            setState(
              () {},
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration(milliseconds: 400),
      () {
        this.requestLocation(initLocation: true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _locationStatus == 1
              ? Image.asset(
                  "images/shequ-weizhi@3x.png",
                  width: 15,
                  height: 18,
                  color: Colors.grey,
                )
              : _locationStatus == 2
                  ? Container()
                  : Container(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
          buttonWidget(
            Container(
              padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
              child: Text(
                _locationStatus == 0
                    ? "正在获取当前地址..."
                    : _locationStatus == 1 ? "$_location" : "当前地址获取失败, 点击重新获取",
                style: TextStyle(
                  fontSize: 12,
                  color: rgba(24, 159, 248, 1),
                ),
              ),
            ),
            context,
            onTap: () {
              if (_locationStatus != 0) {
                this._refreshLocation();
              }
            },
          ),
          SizedBox(
            width: _locationStatus == 2 ? 10 : 0,
          ),
          _locationStatus != 0
              ? buttonWidget(
                  Container(
                    padding: EdgeInsets.fromLTRB(6, 2, 6, 2),
                    child: Text(
                      "选择",
                      style: TextStyle(
                        fontSize: 14,
                        color: kMainColor,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: kMainColor,
                        ),
                        left: BorderSide(
                          width: 1,
                          color: kMainColor,
                        ),
                        bottom: BorderSide(
                          width: 1,
                          color: kMainColor,
                        ),
                        right: BorderSide(
                          width: 1,
                          color: kMainColor,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  context,
                  onTap: () {
                    this._locationSelection();
                  },
                )
              : Container()
        ],
      ),
    );
  }
}
