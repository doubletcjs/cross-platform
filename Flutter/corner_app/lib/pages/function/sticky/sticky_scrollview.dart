import 'package:flutter/material.dart';

typedef StickyScrollOffsetBlock = void Function(double offset);

// ignore: must_be_immutable
class StickyScrollView extends StatefulWidget {
  double expandedHeight;
  Widget expandedChild;

  double stickyBarHeight;
  Widget stickyBar;

  Widget contentView;
  StickyScrollOffsetBlock offsetChange;

  StickyScrollView({
    Key key,
    @required this.expandedHeight,
    @required this.expandedChild,
    @required this.stickyBarHeight,
    @required this.stickyBar,
    @required this.contentView,
    @required this.offsetChange,
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
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: this.widget.expandedChild,
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyBarDelegate(
              barHeight: this.widget.stickyBarHeight,
              child: this.widget.stickyBar,
            ),
          ),
        ];
      },
      body: this.widget.contentView,
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
