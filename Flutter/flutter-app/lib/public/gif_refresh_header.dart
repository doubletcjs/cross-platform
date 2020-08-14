import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'public.dart' show loadingGifPath;

class GifHeader extends RefreshIndicator {
  GifHeader() : super(height: 80.0, refreshStyle: RefreshStyle.Follow);

  @override
  GifHeaderState createState() => GifHeaderState();
}

class GifHeaderState extends RefreshIndicatorState<GifHeader>
    with SingleTickerProviderStateMixin {
  GifController _gifController;

  @override
  void initState() {
    _gifController = GifController(
      vsync: this,
      value: 0,
    );
    super.initState();
  }

  @override
  void onModeChange(RefreshStatus mode) {
    if (mode == RefreshStatus.refreshing) {
      _gifController.repeat(
          min: 0, max: 98, period: Duration(milliseconds: 4000));
    }
    super.onModeChange(mode);
  }

  @override
  Future<void> endRefresh() {
    _gifController.value = 54;
    return _gifController.animateTo(98, duration: Duration(milliseconds: 1851));
  }

  @override
  void resetValue() {
    _gifController.value = 0;
    super.resetValue();
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    return GifImage(
      image: AssetImage(loadingGifPath),
      controller: _gifController,
      height: 36,
      width: 36,
    );
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }
}
