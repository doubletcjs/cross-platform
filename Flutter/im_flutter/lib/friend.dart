import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/entity/friend_entity.dart';
import 'package:tencent_im_plugin/entity/user_info_entity.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

class FriendPage extends StatefulWidget {
  FriendPage({Key key}) : super(key: key);

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  List _dataList = [];

  void _getFriendList() {
    TencentImPlugin.getFriendList().then(
      (value) => {
        this.setState(
          () {
            _dataList = List.from(value);
          },
        ),
      },
    );
  }

  @override
  void initState() {
    super.initState();
    this._getFriendList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("好友"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              this._getFriendList();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          FriendEntity friend = _dataList[index];
          UserInfoEntity info = friend.userInfoEntity;
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: info.faceUrl == null
                  ? null
                  : Image.network(
                      info.faceUrl,
                      fit: BoxFit.cover,
                    ).image,
            ),
            title: Text(
              info.nickName,
            ),
          );
        },
        itemCount: _dataList.length,
      ),
    );
  }
}
