import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

typedef StickyScrollOffsetBlock = void Function(double offset);
final String kBaseStorePagePositionKey = "kStorePagePositionKey";

// ignore: must_be_immutable
class StickyScrollView extends StatefulWidget {
  double expandedHeight;
  Widget expandedChild;
  //MediaQuery.of(context).padding.top + AppBar().preferredSize.height
  double stickyBarHeight;
  Widget stickyBar;
  int keyIndex;
  double topBarHeight;

  Widget contentView;
  StickyScrollOffsetBlock offsetChange;

  Brightness brightness;

  StickyScrollView({
    Key key,
    @required this.expandedHeight,
    @required this.expandedChild,
    @required this.stickyBarHeight,
    @required this.stickyBar,
    @required this.contentView,
    @required this.offsetChange,
    @required this.keyIndex,
    @required this.topBarHeight,
    this.brightness,
  }) : super(key: key);

  @override
  _StickyScrollViewState createState() => _StickyScrollViewState();
}

class _StickyScrollViewState extends State<StickyScrollView> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController(initialScrollOffset: 0.0);
    _scrollController.addListener(() {
      if (this.widget.offsetChange != null) {
        this.widget.offsetChange(_scrollController.offset);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            expandedHeight: this.widget.expandedHeight,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: Container(),
            brightness: this.widget.brightness == null
                ? Theme.of(context).brightness
                : this.widget.brightness,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: this.widget.expandedChild,
            ),
          ),
        ];
      },
      pinnedHeaderSliverHeightBuilder: () {
        return MediaQuery.of(context).padding.top +
            AppBar().preferredSize.height;
      },
      innerScrollPositionKeyBuilder: () {
        String index = kBaseStorePagePositionKey;
        index += this.widget.keyIndex.toString();
        return Key(index);
      },
      body: SingleChildScrollView(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            this.widget.stickyBar,
            Container(
              height: MediaQuery.of(context).size.height -
                  (this.widget.topBarHeight == null
                      ? 0.0
                      : this.widget.topBarHeight),
              child: this.widget.contentView,
            ),
          ],
        ),
      ),
    );
  }
}

class StickyBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double barHeight;

  StickyBarDelegate({@required this.child, this.barHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => barHeight;

  @override
  double get minExtent => barHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

// ignore: must_be_immutable
class TabViewItem extends StatefulWidget {
  Key tabKey;
  Widget child;

  TabViewItem({
    Key key,
    @required this.tabKey,
    @required this.child,
  });

  @override
  _TabViewItemState createState() => _TabViewItemState();
}

class _TabViewItemState extends State<TabViewItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NestedScrollViewInnerScrollPositionKeyWidget(
      this.widget.tabKey,
      this.widget.child,
    );
  }
}
