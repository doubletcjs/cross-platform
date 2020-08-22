import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yue_mei/public/public.dart';
import 'package:yue_mei/public/scale_tabbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import './api/gift_api.dart';
import 'package:yue_mei/pages/mine/mine_homepage.dart';

const giftConfig = <int, Map<String, dynamic>>{
  1: {
    "noData": "您还没有送出过礼物",
    "action": "你送给了",
  },
  2: {
    "noData": "您还没有收到过礼物",
    "action": "送给您",
  }
};

class GiftPage extends StatefulWidget {
  @override
  _GiftPageState createState() => _GiftPageState();
}

class _GiftPageState extends State<GiftPage> with SingleTickerProviderStateMixin {
  List<String> _tabs = ["收到的", "送出的"];
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: rgba(247, 247, 247, 1),),
          Container(
            height: 270,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [rgba(255, 114, 81, 1), rgba(255, 44, 96, 1)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: new AppBar(
              title: new Text("礼物"),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            )
          ),
          Container(
            padding: EdgeInsets.fromLTRB(14, 73.5, 14, 23.5),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScaleTabBar(
                  controller: _tabController,
                  indicator: RoundUnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 3,
                      color: rgba(255, 255, 255, 1),
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
                  labelColor: rgba(255, 255, 255, 1),
                  isScrollable: true,
                  unselectedLabelColor: rgba(255, 255, 255, 1),
                  labelStyle: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(height: 12,),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: rgba(0, 0, 0, 0.06),
                          offset: Offset(0, 5),
                          blurRadius: 20,
                        ),
                      ]
                    ),
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _GiftList(type: 2,),
                        _GiftList(type: 1,),
                      ],
                    ),
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

class _GiftList extends StatefulWidget {
  int _type;

  _GiftList({ type }) : _type = type;

  @override
  _GiftListState createState() => _GiftListState();
}

class _GiftListState extends State<_GiftList> {
  RefreshController _refreshController;
  List _data = [];
  int _page = 1;
  bool _showLoadMore = true;

  //加载更多
  void _loadMoreData() {
    _page += 1;
    _getData();
  }

  //刷新
  void _refreshData() {
    _page = 1;
    _getData();
  }

  //请求
  void _getData() async {
    var res = await GiftApi.getGiftList({
      "page": _page,
      "type": this.widget._type,
    });
    var resData = res.data["data"];
    var data = resData['data'];
    var pagination = resData['pagination'];

    setState(() {
      if (_page < pagination["total_pages"]) {
        _showLoadMore = true;
        _refreshController.loadComplete();
      } else {
        _showLoadMore = false;
        _refreshController.loadNoData();
      }

      if (_page == 1) {
        _data = data;
      } else {
        _data.addAll(data);
      }
      _refreshController.refreshCompleted();
    });
  }

  bool _noData () {
    return _data.length == 0 && _page == 1 && !_showLoadMore;
  }

  @override
  void initState() {
    super.initState();

    _refreshController = RefreshController(initialRefresh: false);

    Future.delayed(Duration.zero, () {
      _refreshController.requestRefresh();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (
      _noData() ?
        Center(
          child: Column(
            children: [
              SizedBox(height: 101,),
              Image.asset("images/no_gift.png", width: 206, height: 189,),
              SizedBox(height: 11.5,),
              Text(giftConfig[this.widget._type]["noData"], style: TextStyle(
                height: 2,
                fontSize: 15,
                color: rgba(153, 153, 153, 1),
              ),),
            ],
          ),
        ) :
        functionRefresher(
          _refreshController,
          ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                var data = _data[index];
//                String title = "";
//
//                if (this.widget._type == 1) {
//                  title = "${data["nickname"]} ${giftConfig[this.widget._type]["action"]}";
//                } else if (this.widget._type == 2) {
//                  title = "${giftConfig[this.widget._type]["action"]}${data["nickname"]}";
//                }

                return Container(
                  padding: EdgeInsets.fromLTRB(15, 20, 15, index == _data.length - 1 ? 15 : 0),
                  child: Row(
                    children: [
                      InkWell(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(44),
                          child: CachedNetworkImage(
                            imageUrl: data["avatar"],
                            height: 36,
                            width: 34,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return MineHomePage(
                                userId: "${data["user_id"]}",
                              );
                            }),
                          );
                        },
                      ),
                      SizedBox(width: 14,),
                      Expanded(
                        child: Column(
                          children: [
                            Text(data["content"], style: TextStyle(
                                height: 1.46,
                                fontSize: 15,
                                color: rgba(16, 16, 16, 1)
                            ), overflow: TextOverflow.clip,),
                            Text(data["created_at"], style: TextStyle(
                                height: 1.36,
                                fontSize: 11,
                                color: rgba(130, 130, 130, 1)
                            ),),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      SizedBox(width: 14,),
                      Text("${data["gift_name"]} x${data["number"]}", style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: rgba(255, 45, 85, 1),
                      ),),
                    ],
                  ),
                );
              },
              itemCount: _data.length
          ),
          onRefresh: () {
            this._refreshData();
          },
          onLoadMore: () {
            this._loadMoreData();
          },
          enableLoadMore: _showLoadMore,
        )
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
