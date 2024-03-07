import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:workout/index.dart';

class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  State<notification> createState() => _SendNotState();
}

class _SendNotState extends State<notification> {
  final TextEditingController _title = TextEditingController();
  // final TextEditingController _part = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  // final TextEditingController _date = TextEditingController();
  final TextEditingController _time = TextEditingController();

  DateTime dateTime = DateTime.now();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");

    const IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
      macOS: null,
      linux: null,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (dataYouNeedToUseWhenNotificationIsClicked) {},
    );
  }

  showNotification() {
    if (_title.text.isEmpty || _desc.text.isEmpty || _time.text.isEmpty) {
      return;
    }

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "ScheduleNotification001",
      "Notify Me",
      importance: Importance.high,
    );

    const IOSNotificationDetails iosNotificationDetails =
        IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: null,
      linux: null,
    );

    tz.initializeTimeZones();
    final tz.TZDateTime scheduledAt = tz.TZDateTime.from(dateTime, tz.local);
    final now = tz.TZDateTime.now(tz.local);
    final tomorrow = now.add(const Duration(days: 1));
    final scheduledTime = tz.TZDateTime(tz.local, tomorrow.year, tomorrow.month,
        tomorrow.day, dateTime.hour, dateTime.minute);

    flutterLocalNotificationsPlugin.zonedSchedule(
        01, _title.text, _desc.text, scheduledAt, notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: 'This is the data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("การแจ้งเตือน"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25.0),
        backgroundColor: Color(0xFF2FBDAB),
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_sharp,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),
                TextField(
                  controller: _title,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    label: Text("หัวข้อ"),
                  ),
                ),
                const SizedBox(height: 16),
                // DropdownButton<String>(
                //   isExpanded: true,
                //   hint: Text("เลือกส่วนของร่างกาย"),
                //   iconSize: 30,
                //   items: <String>[
                //     'แขน & หน้าอก',
                //     'หน้าท้อง',
                //     'ไหล่ & หลัง',
                //     'ขา'
                //   ].map((String dropdownValue) {
                //     return DropdownMenuItem<String>(
                //       value: dropdownValue,
                //       child: Text(
                //         dropdownValue,
                //         style: TextStyle(fontSize: 20),
                //       ),
                //     );
                //   }).toList(),
                //   onChanged: (String? value) {
                //     print(value); // ตรวจสอบค่าที่เลือก
                //     setState(() {
                //       _part.text = value ??
                //           ''; // ตรวจสอบและอัปเดตค่าใน TextField หรือ TextFormField
                //     });
                //   },
                // ),
                // TextField(
                //   controller: _part,
                //   decoration: InputDecoration(
                //     labelText: 'ส่วนของร่างกายที่เลือก',
                //   ),
                // ),
                // const SizedBox(height: 16),
                TextField(
                  controller: _desc,
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  decoration: InputDecoration(
                      hintText: "คำอธิบาย",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      )),
                ),
                const SizedBox(height: 16),
                // TextField(
                //   controller: _date,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       suffixIcon: InkWell(
                //         child: Icon(Icons.date_range),
                //         onTap: () async {
                //           final DateTime? newlySelectedDate =
                //               await showDatePicker(
                //             context: context,
                //             initialDate: dateTime,
                //             firstDate: DateTime.now(),
                //             lastDate: DateTime(2095),
                //           );

                //           if (newlySelectedDate == null) {
                //             return;
                //           }

                //           setState(() {
                //             dateTime = newlySelectedDate;
                //             _date.text =
                //                 "${dateTime.day}/${dateTime.month}/${dateTime.year}";
                //           });
                //         },
                //       ),
                //       label: Text("วัน/เดือน/ปี")),
                // ),
                // const SizedBox(
                //   height: 16.0,
                // ),
                TextField(
                  controller: _time,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      suffixIcon: InkWell(
                        child: const Icon(
                          Icons.timer_outlined,
                        ),
                        onTap: () async {
                          final TimeOfDay? slectedTime = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());

                          if (slectedTime == null) {
                            return;
                          }

                          _time.text =
                              "${slectedTime.hour}:${slectedTime.minute.toString().padLeft(2, '0')}";

                          DateTime newDT = DateTime(
                            dateTime.year,
                            dateTime.month,
                            dateTime.day,
                            slectedTime.hour,
                            slectedTime.minute,
                          );
                          setState(() {
                            dateTime = newDT;
                          });
                        },
                      ),
                      label: Text("เวลา")),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 50),
                      primary: Color.fromARGB(255, 71, 119, 251),
                      textStyle: TextStyle(fontSize: 20)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green),
                              SizedBox(
                                  width: 10), // ระยะห่างระหว่างไอคอนกับข้อความ
                              Text("แจ้งเตือน"),
                            ],
                          ),
                          content: Text("บันทึกการแจ้งเตือนเรียบร้อยแล้ว"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(
                                    context); // ปิดไดอะล็อกก่อนเปลี่ยนหน้า
                                showNotification(); // แสดงการแจ้งเตือน
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeWidget()),
                                );
                              },
                              child: Text("ตกลง"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text('บันทึกการแจ้งเตือน',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
