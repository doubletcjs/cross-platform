import 'package:flutter/material.dart';
import 'package:ideaclass/pages/commons/api/commonapi.dart'; 
import 'package:ideaclass/public/public.dart';

typedef LocaleSelectionBlock = void Function(
    String location, String locationID, String areaName);

class LocaleSelection extends StatefulWidget {
  String parentId;
  List dataSources;
  String location = ""; //省-市-区
  String locationID = "";

  LocaleSelectionBlock localeHandle;

  LocaleSelection(
      {this.parentId = "0",
      this.dataSources,
      this.location = "",
      this.localeHandle,
      this.locationID = ""});

  @override
  _LocaleSelectionState createState() => _LocaleSelectionState();
}

class _LocaleSelectionState extends State<LocaleSelection> {
  bool _loading = true;

  void _requestArea(String parentId, Function(List) finish) {
    _loading = true;
    CommonApi().getAreaList(
      parentId,
      (data, msg) {
        if (data != null) {
          if (finish != null) {
            finish(data);
          }
        } else {
          showToast(msg, context);
        }

        _loading = false;
        setState(
          () {},
        );
      },
    );
  }

  void _refreshArea() {
    if (this.widget.dataSources == null) {
      this._requestArea(
        this.widget.parentId,
        (list) {
          this.widget.dataSources = list;
          setState(
            () {},
          );
        },
      );
    } else {
      _loading = false;
      setState(
        () {},
      );
    }
  }

  @override
  void initState() {
    super.initState();
    this._refreshArea();
  }

  @override
  void didUpdateWidget(LocaleSelection oldWidget) {
    super.didUpdateWidget(oldWidget);

    this._refreshArea();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "选择地区",
      ),
      body: _loading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              itemBuilder: (context, index) {
                return buttonWidget(
                  Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: Text(
                      this.widget.dataSources[index]["areaName"],
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(23, 23, 23, 1),
                      ),
                    ),
                  ),
                  context,
                  onTap: () {
                    var model = this.widget.dataSources[index];
                    var areaId = model["areaId"];
                    this._requestArea(
                      "$areaId",
                      (list) {
                        var tempLocation = "";
                        var tempLocationID = "";
                        if (this.widget.location.length == 0) {
                          tempLocation = model["areaName"];
                          tempLocationID = "${model["areaId"]}";
                        } else {
                          tempLocation =
                              this.widget.location + "-" + model["areaName"];
                          tempLocationID =
                              this.widget.locationID + "-" + "${model["areaId"]}";
                        }

                        if (list.length > 0 &&
                            int.parse("${model["areaLevel"]}") < 3) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return LocaleSelection(
                                  dataSources: list,
                                  parentId: "$areaId",
                                  location: tempLocation,
                                  locationID: tempLocationID,
                                  localeHandle: this.widget.localeHandle,
                                );
                              },
                            ),
                          );
                        } else {
                          if (this.widget.localeHandle != null) {
                            this.widget.localeHandle(tempLocation,
                                tempLocationID, model["areaName"]);
                          }

                          var level = int.parse("${model["areaLevel"]}");
                          for (var i = 0; i < level; i++) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                    );
                  },
                  color: Colors.white,
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 10,
                  color: rgba(249, 249, 249, 1),
                );
              },
              itemCount: this.widget.dataSources.length),
    );
  }
}
