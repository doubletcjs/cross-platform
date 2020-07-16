import 'package:flutter/material.dart';
import 'package:im_flutter/creategroup.dart';
import 'package:tencent_im_plugin/entity/group_info_entity.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

class GroupPage extends StatefulWidget {
  GroupPage({Key key}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  List _dataList = [];

  void _getGroupList() {
    TencentImPlugin.getGroupList().then(
      (value) => {
        this.setState(
          () {
            _dataList = List.from(value);
          },
        ),
      },
    );
  }

  /// 点击事件
  void _onClick(group) {}

  @override
  void initState() {
    super.initState();
    this._getGroupList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("群组"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return CreateGroupPage();
                }),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          GroupInfoEntity group = _dataList[index];
          return InkWell(
            onTap: () {
              this._onClick(group);
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: Image.network(
                  group.faceUrl,
                  fit: BoxFit.cover,
                ).image,
              ),
              title: Text(
                group.groupName,
              ),
              subtitle: Text("${group.memberNum}人"),
            ),
          );
        },
        itemCount: _dataList.length,
      ),
    );
  }
}
