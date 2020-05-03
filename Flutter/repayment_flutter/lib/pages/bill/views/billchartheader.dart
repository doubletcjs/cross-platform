import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:repayment_flutter/public/billmanager.dart';
import 'package:repayment_flutter/public/public.dart';

typedef kMonthlyBillBlock = void Function(
    List<Map<String, dynamic>> bills, double total);

class BillChartHeader extends StatefulWidget {
  kMonthlyBillBlock selectBills;
  BillChartHeader({Key key, this.selectBills}) : super(key: key);

  @override
  _BillChartHeaderState createState() => _BillChartHeaderState();
}

class _BillChartHeaderState extends State<BillChartHeader> {
  List<DateTime> _monthlyDates = [];
  List<double> _monthlyAmounts = [];
  double _maxAmount = 0;
  double _minAmount = 0;
  List<Map<String, dynamic>> _allUnfoldBills = [];

  // 曲线数据
  LineChartData _chartData() {
    if (_monthlyAmounts.length == 0) {
      return LineChartData();
    }
    var diff = _maxAmount - _minAmount;
    var each = diff / 17;

    List<LineChartBarData> _lineBarsData = _chartLinesDotData(each);
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.grey,
          tooltipPadding: EdgeInsets.all(6),
          getTooltipItems: (item) {
            LineBarSpot spot = item.first;
            LineTooltipItem obj = LineTooltipItem(
              "金额：" + "${(spot.y * each).toStringAsFixed(2)}",
              TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            );
            return [obj];
          },
        ),
        touchCallback: (LineTouchResponse touchResponse) {
          try {
            LineBarSpot _spot = touchResponse.lineBarSpots.first;
            setState(() {
              this._billsOfMonth(_spot.spotIndex);
            });
          } catch (e) {
            touchResponse.lineBarSpots.first;
          }
        },
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: true,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: false,
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 24,
      maxY: 18,
      minY: -1,
      lineBarsData: _lineBarsData,
    );
  }

  // 曲线点数据
  List<LineChartBarData> _chartLinesDotData(double each) {
    List<FlSpot> spots = [];
    for (var i = 0; i < _monthlyAmounts.length; i++) {
      var amount = _monthlyAmounts[i];
      FlSpot spot = FlSpot(i * 2 + 1.0, amount / each);
      spots.add(spot);
    }

    final LineChartBarData lineChartBarData = LineChartBarData(
      spots: spots,
      isCurved: true,
      colors: [
        kMainColor,
      ],
      barWidth: 2.4,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
      preventCurveOverShooting: true,
    );
    return [
      lineChartBarData,
    ];
  }

  // 当前月左右5个月月份（曲线X轴数据）
  List<Widget> _monthTitle() {
    List<Widget> _list = [];

    for (var i = 0; i < _monthlyDates.length; i++) {
      var date = _monthlyDates[i];
      var month = "${date.month}";
      _list.add(
        Container(
          width: MediaQuery.of(context).size.width / _monthlyDates.length,
          child: Column(
            children: <Widget>[
              Text(
                (i == (_monthlyDates.length / 2) - 1)
                    ? "本月"
                    : "${month.padLeft(2, '0')}",
                style: TextStyle(
                  color: (i == (_monthlyDates.length / 2) - 1)
                      ? kMainColor
                      : Colors.black87,
                  fontSize: 11,
                ),
              ),
              (i == (_monthlyDates.length / 2) - 1 || i == 0)
                  ? Text(
                      "${date.year}",
                      style: TextStyle(
                        color: (i == (_monthlyDates.length / 2) - 1)
                            ? kMainColor
                            : Colors.black87,
                        fontSize: 5,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
    }

    return _list;
  }

  // 曲线Y轴数据
  void _monthlyChartData() {
    for (var i = 0; i < _monthlyDates.length; i++) {
      var date = _monthlyDates[i];
      double amounts = 0.0;
      for (var bill in _allUnfoldBills) {
        var unfolddate = "${bill["unfolddate"]}";
        DateTime unfoldDate = DateTime.parse(unfolddate);
        if (unfoldDate.month == date.month && unfoldDate.year == date.year) {
          double eachamount = double.parse("${bill['eachamount']}");
          amounts += eachamount;
        }
      }

      _monthlyAmounts.add(amounts);
      //获取最大最小值
      if (amounts > _maxAmount) {
        _maxAmount = amounts;
      }

      if (amounts < _minAmount) {
        _minAmount = amounts;
      }
    }

    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {});
    });
  }

  // 当前选择月份账单
  void _billsOfMonth(int index) {
    DateTime selectDate = _monthlyDates[index];
    List<Map<String, dynamic>> _bills = [];
    for (var bill in _allUnfoldBills) {
      var unfolddate = "${bill["unfolddate"]}";
      DateTime unfoldDate = DateTime.parse(unfolddate);
      if (unfoldDate.month == selectDate.month &&
          unfoldDate.year == selectDate.year) {
        Map<String, dynamic> _listBill = Map.from(bill);
        var date = DateTime.now();
        date = DateTime(date.year, date.month, date.day);
        var diffDay = unfoldDate.difference(date).inDays;
        _listBill["residueday"] = "$diffDay";

        _bills.add(_listBill);
      }
    }

    if (this.widget.selectBills != null) {
      this.widget.selectBills(_bills, _monthlyAmounts[index]);
    }
  }

  // 计算当前月左右5个月月份
  void _loadingDataBills() {
    var date = DateTime.now();
    date = DateTime(date.year, date.month);

    DateTime leftDate = date;
    DateTime rightDate;
    for (var i = 0; i < 7; i++) {
      if (i < 5) {
        leftDate = DateTime(leftDate.year, leftDate.month - 1);
        _monthlyDates.insert(0, leftDate);
      }

      if (rightDate == null) {
        rightDate = date;
      } else {
        rightDate = DateTime(rightDate.year, rightDate.month + 1);
      }
      _monthlyDates.add(rightDate);
    }

    BillManager.allUnfoldBills(
      (data) {
        _allUnfoldBills = data;
        this._monthlyChartData();
        this._billsOfMonth(_monthlyDates.indexOf(date));
      },
      (msg) {
        showToast(
          msg,
          context,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    _loadingDataBills();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(8, 10, 0, 10),
            child: Text(
              "账单趋势",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: LineChart(
              _chartData(),
            ),
            decoration: BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(
                  width: 0.6,
                  color: Colors.black26,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _monthTitle(),
            ),
          ),
        ],
      ),
    );
  }
}
