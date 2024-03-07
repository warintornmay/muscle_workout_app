import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:workout/flutter_flow/flutter_flow_util.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:workout/index.dart';

void main() {
  runApp(report());
}

class report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firestore Chart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirestoreChartPage(),
    );
  }
}

class FirestoreChartPage extends StatefulWidget {
  @override
  _FirestoreChartPageState createState() => _FirestoreChartPageState();
}

class _FirestoreChartPageState extends State<FirestoreChartPage> {
  int currentWeek = 1; // Variable to track current week
  List<DataPoint> dataPoints = [];
  int maxWeekNumber = 4; // Assuming you have data for 4 weeks
  String uid = ''; //ส่วนของ level
  @override
  void initState() {
    super.initState();
    getDataFromFirestore(currentWeek);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  void getDataFromFirestore(int week) {
    // DateTime currentDate = DateTime.now();
    // DateTime nextWeek = currentDate.add(Duration(days: 7));

    // // Print the current date and next week
    // print('Current Date: ${formatDate(currentDate)}');
    // print('Next Week: ${formatDate(nextWeek)}');
    // DateTime tempDate = currentDate;
    // List<String> dateRange = [];
    // while (tempDate.isBefore(nextWeek)) {
    //   dateRange.add(formatDate(tempDate));
    //   tempDate = tempDate.add(Duration(days: 1));
    // }
    // dateRange.forEach((date) {
    //   print(date);
    // });
    FirebaseAuth.instance.authStateChanges().listen((event) async {
      uid = event!.uid;
      print(uid);
      final user = await FirebaseFirestore.instance
          .collection('users_used')
          .doc(uid)
          .get();
      print(user.data());
      if (user.exists) {
        Map<String, dynamic>? userData =
            user.data(); // Get the map of user data
        if (userData != null) {
          List<DataPoint> newDataPoints = [];
          userData.forEach((date, value) {
            newDataPoints.add(DataPoint(date, value));
            // }
          });
          setState(() {
            dataPoints.clear();
            dataPoints.addAll(newDataPoints);
          });
        } else {
          print('No data found for user');
        }
      } else {
        print('Document does not exist');
      }
    });
  }

  void goToPreviousWeek() {
    if (currentWeek > 1) {
      setState(() {
        currentWeek--;
      });
      getDataFromFirestore(currentWeek);
    }
  }

  void goToNextWeek() {
    // You need to handle the maximum week number according to your data
    if (currentWeek < maxWeekNumber) {
      setState(() {
        currentWeek++;
      });
      getDataFromFirestore(currentWeek);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('รายงานการออกกำลังกาย'),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 23.0),
          backgroundColor: Color(0xFF2FBDAB),
          leading: IconButton(
            icon: Icon(Icons.chevron_left_sharp),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeWidget(),
                ),
              );
            },
          )),
      body: Center(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: goToPreviousWeek,
                ),
                Text(
                  'Week $currentWeek',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: goToNextWeek,
                ),
              ],
            ),
            Container(
              height: 300,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // title: ChartTitle(text: 'รายงานการออกกำลังกาย'),
                legend: Legend(isVisible: true),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <CartesianSeries<DataPoint, String>>[
                  LineSeries<DataPoint, String>(
                    dataSource: dataPoints,
                    xValueMapper: (DataPoint date, _) => date.category,
                    yValueMapper: (DataPoint date, _) => date.value,
                    name: 'เวลาในการออกกำลังกาย',
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataPoint {
  final String category;
  final int value;

  DataPoint(this.category, this.value);
}
