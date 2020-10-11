import 'package:flutter/material.dart';
import 'package:focus_tick/views/tick_flip_cell.dart';
import 'package:wakelock/wakelock.dart';

class TickPage extends StatefulWidget {
  TickPage({Key key}) : super(key: key);

  @override
  _TickPageState createState() => _TickPageState();
}

class _TickPageState extends State<TickPage>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  DateTime _dateTime;

  void _updateDateTime() {
    setState(() {
      _dateTime = DateTime.now();
    });
  }

  @override
  void initState() {
    super.initState();

    this._updateDateTime();
    WidgetsBinding.instance.addObserver(this);
    Wakelock.enable();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Wakelock.disable();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("--" + state.toString());
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed: // 应用程序可见，前台
        break;
      case AppLifecycleState.paused: // 应用程序不可见，后台
        break;
      case AppLifecycleState.detached:
        break;
    }

    this._updateDateTime();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    print("didChangeMetrics");
    this._updateDateTime();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          double itemSpace = 70;

          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              bottom: AppBar().preferredSize.height,
              left: itemSpace,
              right: itemSpace,
            ),
            child: Wrap(
              runSpacing: 26,
              spacing: 26,
              children: [
                TickFlipCell(
                  dateTime: _dateTime,
                  tickType: 2,
                ),
                TickFlipCell(
                  dateTime: _dateTime,
                  tickType: 1,
                ),
                TickFlipCell(
                  dateTime: _dateTime,
                  tickType: 0,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
