import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/entity/pendency_entity.dart';
import 'package:tencent_im_plugin/enums/pendency_examine_type_enum.dart';
import 'package:tencent_im_plugin/enums/pendency_type_enum.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

class ApplyPage extends StatefulWidget {
  ApplyPage({Key key}) : super(key: key);

  @override
  _ApplyPageState createState() => _ApplyPageState();
}

class _ApplyPageState extends State<ApplyPage> {
  List _dataList = [];

  void _getPendencyList() {
    TencentImPlugin.getPendencyList(type: PendencyTypeEnum.BOTH).then(
      (value) {
        this.setState(
          () {
            _dataList = value.items != null ? List.from(value.items) : [];
          },
        );
      },
    );
  }

  /// 点击事件
  onClick(item) {}

  /// 同意按钮点击
  onAgree(item) {
    TencentImPlugin.examinePendency(
      type: PendencyExamineTypeEnum.AGREE_AND_ADD,
      id: item.identifier,
    );

    //通知刷新好友列表
    this.setState(() {
      this._dataList.remove(item);
    });
  }

  /// 拒绝按钮点击
  onRefuse(item) {
    TencentImPlugin.examinePendency(
      type: PendencyExamineTypeEnum.REJECT,
      id: item.identifier,
    );

    this.setState(() {
      this._dataList.remove(item);
    });
  }

  @override
  void initState() {
    super.initState();
    this._getPendencyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("申请列表"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                this._getPendencyList();
              }),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          PendencyEntity apply = _dataList[index];
          DateTime dateTime =
              DateTime.fromMillisecondsSinceEpoch(apply.addTime * 1000);
          return Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  this.onClick(apply);
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: Image.network(
                      apply.userProfile.faceUrl,
                      fit: BoxFit.cover,
                    ).image,
                  ),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          apply.nickname,
                        ),
                      ),
                      Text(
                        dateTime == null
                            ? ""
                            : "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(apply.addWording),
                ),
              ),
              apply.type == PendencyTypeEnum.COME_IN
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            this.onAgree(apply);
                          },
                          child: Text("同意"),
                        ),
                        Container(width: 10),
                        RaisedButton(
                          onPressed: () {
                            this.onRefuse(apply);
                          },
                          child: Text("拒绝"),
                        ),
                      ],
                    )
                  : Container(),
              Container(
                height: 1,
                color: Colors.grey[300],
              ),
            ],
          );
        },
        itemCount: _dataList.length,
      ),
    );
  }
}
