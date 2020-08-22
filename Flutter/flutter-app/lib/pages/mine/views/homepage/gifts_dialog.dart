import 'package:flutter/material.dart';
import 'package:yue_mei/public/public.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../api/member_api.dart' show MemberApi;
import 'package:yue_mei/pages/wallet/wallet_page.dart';
import 'package:dart_notification_center/dart_notification_center.dart';

class GiftsDialog extends Dialog {
  int _receiveUserId;
  Function _onNavigationClickEvent;

  GiftsDialog({ receiveUserId, onNavigationClickEvent }) : _receiveUserId = receiveUserId, _onNavigationClickEvent = onNavigationClickEvent;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(onTap: _onNavigationClickEvent),
          _Gift(receiveUserId: _receiveUserId)
        ],
      ),
    );
  }
}

class _Gift extends StatefulWidget {
  int _receiveUserId;

  _Gift({ receiveUserId }) : _receiveUserId = receiveUserId;

  @override
  _GiftState createState() => _GiftState();
}

class _GiftState extends State<_Gift> {
  final String _topup = "images/topup.png";
  final String _give = "images/give_gift.png";
  int _selectedGiftId;
  int _amount = 0;
  Map _account = {};

  _GiftSwiper _giftSwiper;

  //获取用户信息
  void _refreshAccount() {
    setState(() {
      _account = currentAccount;
    });
  }

  @override
  void initState() {
    super.initState();

    _getAmount();

    _giftSwiper = _GiftSwiper(
      getSelectedGiftIdFn: (int id) {
        setState(() {
          _selectedGiftId = id;
        });
      },
    );

    DartNotificationCenter.subscribe(
      channel: kAccountHandleNotification,
      observer: this,
      onNotification: (option) {
        //type 0 登录 1 请求账号信息刷新 2 登出 3 请求账号信息结束，刷新本地记录用户信息
        if (option["type"] == 3) {
          this._refreshAccount();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getAmount() {
    DartNotificationCenter.post(
      channel: kAccountHandleNotification,
      options: {
        "type": 1,
      },
    );
  }

  _postGiving() async {
    var res = await MemberApi.postGift({
      "receive_user_id": this.widget._receiveUserId,
      "id": _selectedGiftId,
      "count": 1,
      "note": "",
    });
    var data = res.data;

    showToast(data["message"], context);
  }

  Widget bar() {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          width: 36,
          height: 5,
          color: rgba(72, 72, 74, 1),
        ),
      ),
    );
  }

  Widget footer() {
    return Center(
      child: Row(
        children: [
          Text( "金币余额", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), ),
          SizedBox(width: 14,),
          Image.asset("images/jinbi.png", width: 17.5, height: 17.5,),
          SizedBox(width: 7,),
          Text(_account["number_of_balance"].toString(), style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
          Expanded(child: Container(),),
          InkWell(
            child: Image.asset(_selectedGiftId != null ? _give : _topup, width: 74, height: 31,),
            onTap: () async {
              if (_selectedGiftId != null) {
                await _postGiving();
              } else {
                // 没有选中礼物，充值逻辑
                await Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => WalletPage()
                ));
              }
              _getAmount();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.fromLTRB(15, 6.5, 15, 23),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                bar(),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 23, 0, 12.5),
                  child: Text("赠送礼物", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                ),
                _giftSwiper,
                footer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _GiftSwiper extends StatefulWidget {
  Function _getSelectedGiftIdFn;

  _GiftSwiper({ Function getSelectedGiftIdFn }) : _getSelectedGiftIdFn = getSelectedGiftIdFn;

  @override
  _GifSwiperState createState() => _GifSwiperState();
}

class _GifSwiperState extends State<_GiftSwiper> {
  SwiperController _swiperController = SwiperController();
  List<List> _data = [];
  Color _default = rgba(217, 217, 217, 1);
  Color _active = rgba(127, 127, 127, 1);
  int _cur = 0;
  int _selectedGiftId;

  void setSelectedGiftId (int id, Function fn) {
    _selectedGiftId = id;
    fn(id);
  }

  int getSelectedGiftId () {
    return _selectedGiftId;
  }

  _getData () async {
    var res = await MemberApi.getGifts();
    var data = res.data["data"];

    setState(() {
      for (int i = 0; i < data.length; i += 8) {
        _data.add(data.sublist(i, i + 8 < data.length ? i + 8 : data.length));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _getData();
  }

  @override
  void dispose() {
    super.dispose();

    if (_swiperController != null) {
      _swiperController.dispose();
    }
  }

  Widget _item(Map data) {
    return InkWell(
      child: Center(
        child: Container(
          width: 82,
          height: 106,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: _selectedGiftId == data["id"] ? rgba(255, 45, 85, 1) : rgba(255, 255, 255, 1),
              width: 1,
            ),
            color: _selectedGiftId == data["id"] ? rgba(255, 45, 85, 0.1) : rgba(255, 255, 255, 1),
          ),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: data["logo"],
//                placeholder: (context, url) => CircularProgressIndicator(),
//                errorWidget: (context, url, error) => Icon(Icons.error),
                width: 54,
                height: 46,
                fit: BoxFit.scaleDown,
              ),
              Text(data["name"], style: TextStyle(fontSize: 13, color: rgba(44, 44, 44, 1)), overflow: TextOverflow.clip,),
              Text("${data["price"]} 币", style: TextStyle(fontSize: 11, color: rgba(102, 102, 102, 1)), overflow: TextOverflow.clip,),
            ],
          ),
        ),
      ),
      onTap: () {
        setState(() {
          setSelectedGiftId(data["id"], this.widget._getSelectedGiftIdFn);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 251.5,
      child: Stack(
        children: [
          Container(
            height: 212,
            child: Swiper(
              controller: _swiperController,
              loop: false,
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                  children: _data[index].map((e) => _item(e)).toList(),
                );
              },
              onIndexChanged: (int cur) {
                setState(() {
                  _cur = cur;
                });
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 19.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_data.length, (index) => index).map((index) {
                return Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      width: 5,
                      height: 5,
                      color: index == _cur ? _active : _default,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      )
    );
  }
}

