import 'package:flutter/material.dart';
import 'nearlist.dart';
import '../../public/public.dart';

class NearPage extends StatefulWidget {
  NearPage({Key key}) : super(key: key);

  @override
  _NearPageState createState() => _NearPageState();
}

class _NearPageState extends State<NearPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      body: Stack(
        children: <Widget>[
          transparentAppBar(
            brightness: Brightness.light,
          ),
          NearTabView(),
        ],
      ),
    );
  }
}

class NearTabView extends StatefulWidget {
  NearTabView({Key key}) : super(key: key);

  @override
  _NearTabViewState createState() => _NearTabViewState();
}

class _NearTabViewState extends State<NearTabView>
    with SingleTickerProviderStateMixin {
  List<String> _tabs = [
    "附近",
    "在线",
    "新人",
    "认证",
    "推荐",
  ];
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top + 8, 0, 0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TabBar(
            controller: _tabController,
            indicator: RoundUnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3,
                color: rgba(18, 18, 18, 1),
              ),
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
          /*
          Container(
            padding: EdgeInsets.fromLTRB(17.5, 0, 17.5, 0),
            height: 35.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(right: 26),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _tabController.index = index;
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 32.5,
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            _tabs[index],
                            style: TextStyle(
                              fontSize: index == _tabController.index ? 23 : 15,
                              color: index == _tabController.index
                                  ? rgba(18, 18, 18, 1)
                                  : rgba(153, 153, 153, 1),
                              fontWeight: index == _tabController.index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              width: 6,
                              height: 3,
                              decoration: BoxDecoration(
                                color: index == _tabController.index
                                    ? rgba(18, 18, 18, 1)
                                    : null,
                                borderRadius: BorderRadius.circular(1.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: _tabs.length,
            ),
          ),
          */
          Expanded(
            child: TabBarView(
              // physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: _tabs.map((tab) {
                int index = _tabs.indexOf(tab);
                return NearList(
                  listType: index,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

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
