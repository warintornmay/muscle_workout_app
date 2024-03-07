import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import '/auth/firebase_auth/auth_util.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:workout/index.dart';

class QuestionOfFirebase extends StatefulWidget {
  const QuestionOfFirebase({Key? key}) : super(key: key);

  @override
  State<QuestionOfFirebase> createState() => _QuestionOfFirebase();
}

class _QuestionOfFirebase extends State<QuestionOfFirebase> {
  final _formkey = GlobalKey<FormState>();
  static const values1 = <String>['5', '4', '3', '2', '1'];
  static const values2 = <String>['5', '4', '3', '2', '1'];
  static const values3 = <String>['5', '4', '3', '2', '1'];
  static const values4 = <String>['5', '4', '3', '2', '1'];
  static const values5 = <String>['5', '4', '3', '2', '1'];
  String? selectedValue1;
  String? selectedValue2;
  String? selectedValue3;
  String? selectedValue4;
  String? selectedValue5;
  final selectedColor = Color.fromARGB(255, 45, 65, 219);
  final unselectedColor = Color.fromARGB(255, 48, 48, 48);
  String? uid;

  Widget buildQuestion1() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: values1.map(
          (value) {
            final selected = this.selectedValue1 == value;
            final color = selected ? selectedColor : unselectedColor;
            return Row(
              children: [
                Radio<String>(
                  value: value,
                  groupValue: selectedValue1,
                  onChanged: (value) => setState(() {
                    this.selectedValue1 = value!;
                    print(value);
                  }),
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return selectedColor;
                    }
                    return unselectedColor;
                  }),
                ),
                Text(value),
              ],
            );
          },
        ).toList(),
      );

  Widget buildQuestion2() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: values2.map(
          (value) {
            final selected = this.selectedValue2 == value;
            final color = selected ? selectedColor : unselectedColor;
            return Row(
              children: [
                Radio<String>(
                  value: value,
                  groupValue: selectedValue2,
                  onChanged: (value) => setState(() {
                    this.selectedValue2 = value!;
                    print(value);
                  }),
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return selectedColor; // สีเมื่อ Radio Button ถูกเลือก
                    }
                    return unselectedColor; // สีเมื่อ Radio Button ไม่ได้ถูกเลือก
                  }),
                ),
                Text(value),
              ],
            );
          },
        ).toList(),
      );

  Widget buildQuestion3() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: values3.map(
          (value) {
            final selected = this.selectedValue3 == value;
            final color = selected ? selectedColor : unselectedColor;
            return Row(
              children: [
                Radio<String>(
                  value: value,
                  groupValue: selectedValue3,
                  onChanged: (value) => setState(() {
                    this.selectedValue3 = value!;
                    print(value);
                  }),
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return selectedColor;
                    }
                    return unselectedColor;
                  }),
                ),
                Text(value),
              ],
            );
          },
        ).toList(),
      );

  Widget buildQuestion4() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: values4.map(
          (value) {
            final selected = this.selectedValue4 == value;
            final color = selected ? selectedColor : unselectedColor;
            return Row(
              children: [
                Radio<String>(
                  value: value,
                  groupValue: selectedValue4,
                  onChanged: (value) => setState(() {
                    this.selectedValue4 = value!;
                    print(value);
                  }),
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return selectedColor; // สีเมื่อ Radio Button ถูกเลือก
                    }
                    return unselectedColor; // สีเมื่อ Radio Button ไม่ได้ถูกเลือก
                  }),
                ),
                Text(value),
              ],
            );
          },
        ).toList(),
      );

  Widget buildQuestion5() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: values5.map(
          (value) {
            final selected = this.selectedValue5 == value;
            final color = selected ? selectedColor : unselectedColor;
            return Row(
              children: [
                Radio<String>(
                  value: value,
                  groupValue: selectedValue5,
                  onChanged: (value) => setState(() {
                    this.selectedValue5 = value!;
                    print(value);
                  }),
                  fillColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return selectedColor;
                    }
                    return unselectedColor;
                  }),
                ),
                Text(value),
              ],
            );
          },
        ).toList(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Text(
                "แบบสอบถามความพึงพอใจต่อการใช้งาน",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "คำชี้แจง กรุณาเลือกระดับคะแนนที่พึงพอใจต่อการใช้งาน",
                style: TextStyle(fontSize: 15),
              ),
              Text(
                "5 = ดีมาก, 4 = ดี, 3 = ปานกลาง, 2 = น้อย, 1 = น้อยที่สุด",
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1.แอปพลิเคชันใช้งานได้ง่าย",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    buildQuestion1(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "2.ประสิทธิภาพของแอปพลิเคชัน",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    buildQuestion2(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "3.ความน่าใช้งานของแอปพลิเคชัน",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    buildQuestion3(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "4.ภาพรวมของแอปพลิเคชัน",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    buildQuestion4(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "5.แอปพลิเคชันมีความเร็วในการตอบสนองต่อผู้ใช้งานเป็นอย่างดี",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    buildQuestion5(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 45, 65, 219),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      sendReport();
                      await FirebaseAuth.instance
                          .authStateChanges()
                          .listen((event) async {
                        uid = event!.uid;

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .update({'report': true});
                      });
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                content: Builder(
                                  builder: (context) {
                                    return Container(
                                      height: 200,
                                      width: 200,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Text("ส่งแบบสอบถามสำเร็จ",
                                              style: TextStyle(fontSize: 18)),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Color(0xFF2FBDAB),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomeWidget()),
                                              );
                                            },
                                            child: Text(
                                              "กลับสู่หน้าหลัก",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ));
                    },
                    child: Text(
                      "ส่งแบบสอบถาม",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  sendReport() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      String uid = event!.uid;
      print(uid);
      CollectionReference report =
          FirebaseFirestore.instance.collection('report');
      await report.doc(uid).set({
        'question1': int.parse(selectedValue1!),
        'question2': int.parse(selectedValue2!),
        'question3': int.parse(selectedValue3!),
        'question4': int.parse(selectedValue4!),
        'question5': int.parse(selectedValue5!),
      });
      // await FirebaseFirestore.instance.collection('report').doc(uid).set({
      //   'question1': int.parse(selectedValue1),
      //   'question2': int.parse(selectedValue2),
      //   'question3': int.parse(selectedValue3),
      //   'question4': int.parse(selectedValue4),
      //   'question5': int.parse(selectedValue5),
      // });
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('selectedValue1', selectedValue1));
  }
}
