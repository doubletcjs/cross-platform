import 'package:repayment_flutter/public/public.dart';
import 'package:sqflite/sqflite.dart';

Database database;

final String tableBill = "bills";
final String billId = "id";

class BillManager {
  // 初始化、打开数据库
  static void initDatabase(kObjectFunctionBlock complete) {
    void reopenDatabase() {
      if (database != null && database.isOpen == true) {
        database.close();
        initDatabase(complete);
      } else {
        if (complete != null) {
          complete(false);
        }
      }
    }

    Future<String> _ = getDatabasesPath().then(
      (databasesPath) {
        var path = "$databasesPath" + "/repayment.db";
        Future<Database> _ = openDatabase(
          path,
          version: 1,
          onCreate: (database, version) {
            Future<void> _ = database
                .execute(
                    "CREATE TABLE $tableBill (id INTEGER PRIMARY KEY, eachamount REAL, name TEXT, icon TEXT, adddate TEXT, firstdate TEXT, repaymentterms INTEGER, repaymentperiod TEXT, remark TEXT)")
                .then(
              (db) {
                kLog("创建数据库成功！");
                kLog("path:" + "$databasesPath");
              },
            ).catchError(
              (error) {
                kLog("创建数据库失败：" + "$error");
              },
            );
          },
        ).then(
          (db) {
            kLog("数据库打开成功！");
            database = db;
            if (complete != null) {
              complete(true);
            }
          },
        ).catchError(
          (error) {
            kLog("数据库打开失败：" + "$error");
            reopenDatabase();
          },
        );
      },
    ).catchError(
      (error) {
        kLog("数据库路径获取失败：" + "$error");
        if (complete != null) {
          complete(false);
        }
      },
    );
  }

  // 记录基础账单
  static void recordBill(
      Map<String, dynamic> bill, Function(String msg) handle) {
    if (database != null && database.isOpen == true) {
      database.insert(tableBill, bill).then(
        (rowid) {
          if (handle != null) {
            handle(null);
          }
        },
      ).catchError(
        (error) {
          kLog("error:" + error);
          if (handle != null) {
            handle("操作失败！");
          }
        },
      );
    } else {
      if (handle != null) {
        handle("操作失败！");
      }
    }
  }

  // 账单周期内所有还款日期、当前所在期数
  static allUnfoldBills(Function(List<Map<String, dynamic>>) complete,
      kObjectFunctionBlock fail) {
    allBills((bills) {
      List<Map<String, dynamic>> unfoldBills = [];
      for (var bill in bills) {
        var startDate = DateTime.parse(bill["firstdate"]);
        // 1~500期
        var limit = int.parse("${bill["repaymentterms"]}") + 1;
        // 1~100 0 月/ 1天
        var cycle = "${bill["repaymentperiod"]}";
        var cycleTime = int.parse(cycle.split("|").first);
        var cycleType = int.parse(cycle.split("|").last);
        //int.parse("$limit") > 12 ? 12 :
        int maxLimit = int.parse("$limit");

        DateTime unfoldDate;
        for (var i = 0; i < maxLimit; i++) {
          Map<String, dynamic> unfoldBill = Map.from(bill);

          if (unfoldDate == null) {
            unfoldDate = startDate;
          } else {
            if (cycleType == 0) {
              unfoldDate = DateTime(unfoldDate.year,
                  unfoldDate.month + (cycleTime + 1), unfoldDate.day);
            } else if (cycleType == 1) {
              unfoldDate = DateTime(unfoldDate.year, unfoldDate.month,
                  unfoldDate.day + (cycleTime + 1));
            }
          }

          unfoldBill["unfolddate"] = unfoldDate.toString().split(" ").first;
          unfoldBill["currentterm"] = "$i";
          unfoldBills.add(unfoldBill);
        }
      }

      if (complete != null) {
        complete(unfoldBills.toList());
      }
    }, fail);
  }

  // 获取基础账单
  static allBills(Function(List<Map<String, dynamic>>) complete,
      kObjectFunctionBlock fail) {
    Future<List<Map<String, dynamic>>> _ = database
        .query(
      tableBill,
      orderBy: "$billId",
    )
        .then(
      (bills) {
        if (complete != null) {
          complete(bills.toList());
        }
      },
    ).catchError(
      (error) {
        kLog("error:" + error);
        if (fail != null) {
          fail("获取账单失败！");
        }
      },
    );
  }
}
