// ignore_for_file: duplicate_import, unused_local_variable, unused_import
import 'dart:async';
import 'dart:ffi';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/counter.dart';
import 'camera_view.dart';
import 'painters/pose_painter.dart';

import 'package:google_ml_kit_push_up/google_ml_kit.dart';
import 'package:workout/pages/alllevel/level1_page1/level1_page1_widget.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/06_push_up/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/07_knee_push_up/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/count_waitcam/count_waitcam.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/result.dart';

class detector_exercises_pushup extends StatefulWidget {
  //เปลี่ยน  detector_exercises
  final bool useClassifier;
  final bool isActivity;
  final int setStep;
  final int level; //ส่วนของ level
  const detector_exercises_pushup({
    //เปลี่ยน  detector_exercises
    this.useClassifier = true,
    this.isActivity = true,
    this.setStep = 1,
    this.level = 0, //ส่วนของ level
  });

  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<detector_exercises_pushup> {
  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector();
  bool isBusy = false;
  CustomPaint? customPaint;
  String poseName = "";
  int poseReps = 0;
  get screenWidth => null;
  get screenHeight => null;
  String uid = ''; //ส่วนของ level
  //กำหนดจำนวนครั้ง
  int _counter = 0;
  //กำหนดเวลา
  int _seconds = 20;
  bool _staRoute = true;

  //function เพื่อปรับให้หมดเวลา
  void _resetTimer() {
    setState(() {
      _seconds = 0;
    });
  }

  @override
  void initState() {
    movePage();
    setTimeUsed();
    super.initState();
  }

//ส่วนของ level  ======================================
  int getCountForLevel(int level) {
    if (level == 1) {
      return 4;
    } else if (level == 2) {
      return 9;
    } else if (level == 3) {
      return 14;
    } else {
      return 1;
    }
  }

//===================================================

  @override
  void dispose() async {
    super.dispose();
    await poseDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF2FBDAB),
      body: Container(
        width: MediaQuery.of(context).size.width, // Adjust width as needed
        height: MediaQuery.of(context).size.height, // Adjust height as needed
        child: Stack(
          children: [
            CameraView(
              customPaint: customPaint,
              onImage: (inputImage) {
                processImage(
                  inputImage,
                  widget.useClassifier,
                  widget.isActivity,
                );
              },
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2FBDAB),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 20, // Adjust the width
                            ),
                            Icon(
                              Icons.accessibility,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: 30.0,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 242, 242, 242),
                                ),
                                child: Text(
                                  'Push Up',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20, // Adjust the width
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 20, // Adjust the width
                            ),

                            Icon(
                              Icons.directions_run,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: 30.0,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 242, 242, 242),
                                ),
                                child: Text(
                                  ' $poseName',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20, // Adjust the width
                            ),
                            const Icon(
                              Icons.offline_pin,
                              color: Colors.black,
                              size: 30.0,
                            ),
                            // const SizedBox(
                            //   width: 10, // Adjust the width
                            // ),

                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 242, 242, 242),
                                ),
                                child: Text(
                                  '${poseReps > 0 ? 'Count : $poseReps ' : 'Count 0'}', //  แสดงค่าที่เก็บไว้
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20, // Adjust the width
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 20, // Adjust the width
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 242, 242, 242),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10, // Adjust the width
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 255, 238, 0),
                                onPrimary: const Color.fromARGB(255, 0, 0, 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 5),
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                ),
                              ),
                              onPressed: () {
                                SkipPage();
                              },
                              child: const Text('Skip'),
                            ),
                            const SizedBox(
                              width: 20, // Adjust the width
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void SkipPage() {
    _staRoute = false;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => counter_cam(
          level: widget.level,
          routePoseName: 'detector_exercises_kneepushup',
        ),
      ),
    );
  }

  Future movePage() async {
    while (_staRoute) {
      await Future<void>.delayed(const Duration(seconds: 1));
      int level = widget.level; //ส่วนของ level

      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        uid = event!.uid;
        CollectionReference users =
            FirebaseFirestore.instance.collection('workout_update');
        if (uid != null) {
          await users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              print('Document data: ${documentSnapshot.data()}');
              if (poseReps != 0) {
                //ถ้าค่าที่เก็บไว้ไม่เท่ากับ 0 ให้ทำการเพิ่มข้อมูลเข้าไปใน firebase
                if ((documentSnapshot.data()
                        as Map<String, dynamic>)['pushup$level'] ==
                    null) {
                  users
                      .doc(uid)
                      .set({'pushup$level': poseReps}, SetOptions(merge: true));
                } else {
                  users.doc(uid).update({'pushup$level': poseReps});
                }
              }
            } else {
              users
                  .doc(uid)
                  .set({'pushup$level': poseReps}, SetOptions(merge: true));
              print('Document does not exist on the database');
            }
          });
        } else {
          print('No user');
        }
      });

      if (poseReps >= getCountForLevel(level)) {
        _staRoute = false;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => counter_cam(
              level: widget.level,
              routePoseName: 'detector_exercises_kneepushup',
            ),
          ),
          // result_warm(
          //   level: widget.level,
          // )),
        );
      }
    }
  }

  Future setTimeUsed() async {
    int prevTime; //ประกาศตัวแปรไว้เก็บค่าเวลาที่ใช้ไป
    String formattedDate = DateFormat('dd-MM-yyyy')
        .format(DateTime.now()); //ประกาศตัวแปรไว้เก็บวันที่ปัจจุบัน
    while (_staRoute) {
      //เมื่อยังไม่เปลี่ยนหน้า
      await Future<void>.delayed(const Duration(seconds: 1)); //รอ 1 วินาที
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        //รอข้อมูลจาก firebase
        uid = event!.uid; //เก็บค่า uid ไว้ในตัวแปร
        CollectionReference users = FirebaseFirestore.instance.collection(
            'users_used'); //เรียกใช้งานข้อมูลจาก collection ที่ชื่อว่า users_used

        if (uid != null) {
          //ถ้า uid ไม่เท่ากับ null
          await users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
            //รอข้อมูลจาก firebase
            if (documentSnapshot.exists) {
              //ถ้ามีข้อมูล
              if ((documentSnapshot.data()
                      as Map<String, dynamic>)['$formattedDate'] ==
                  null) {
                //ถ้าข้อมูลที่เก็บไว้ใน firebase ไม่มีข้อมูลที่เก็บวันที่ปัจจุบัน
                users.doc(uid).set({'$formattedDate': 1},
                    SetOptions(merge: true)); //เพิ่มข้อมูลเข้าไปใน firebase
              } else {
                prevTime = (documentSnapshot.data()
                    as Map<String, dynamic>)['$formattedDate'];
                users.doc(uid).update({
                  '$formattedDate': prevTime + 1
                }); //เพิ่มข้อมูลเข้าไปใน firebase  โดยเพิ่มค่าเวลาที่ใช้ไป
              }
            } else {
              //ถ้าไม่มีข้อมูล document ให้ทำการเพิ่มข้อมูลเข้าไปใน firebase
              users.doc(uid).set({'$formattedDate': 1},
                  SetOptions(merge: true)); //เพิ่มข้อมูลเข้าไปใน firebase
            }
          });
        } else {
          print('No user');
        }
      });
    }
  }

  Future<void> processImage(
    InputImage inputImage,
    bool useClassifier,
    bool isActivity,
  ) async {
    if (isBusy) return;
    isBusy = true;

    final poses = await poseDetector.processImage(
      inputImage: inputImage,
      useClassifier: widget.useClassifier,
      isActivity: isActivity,
    );
    if (useClassifier) {
      poses.forEach((pose) {
        poseName = pose.name;
        poseReps = pose.reps;
        print('#######COUNTER ,$poseReps');
      });
      //ส่วนของ level =====================================================
      // int level = widget.level; //
      // while (_staRoute) {
      //   if (poseReps == getCountForLevel(level)) {
      //     _staRoute = false;
      //     await FirebaseAuth.instance.authStateChanges().listen((event) async {
      //       uid = event!.uid;
      //       CollectionReference users =
      //           FirebaseFirestore.instance.collection('workout_update');
      //       if (uid != null) {
      //         await users
      //             .doc(uid)
      //             .set({'pushup$level': poseReps}); //เปลี่ยนชื่อ
      //       } else {
      //         print('No user');
      //       }
      //     });
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (context) => counter_cam(
      //           level: widget.level,
      //           routePoseName: 'detector_exercises_kneepushup',
      //         ),
      //       ),
      //     );
      //================================================================

      // while (_staRoute) {
      //   if (poseReps == getCountForLevel(level)) {
      //     _staRoute = false;
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (context) => counter_cam(
      //           level: widget.level,
      //           routePoseName: 'detector_exercises_kneepushup',
      //         ),
      //       ),
      //     );
      //   }
      // }

      //  });
      //   }
      // }
    }
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = PosePainter(
        poses,
        inputImage.inputImageData!.size,
        inputImage.inputImageData!.imageRotation,
      );
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;

    if (mounted) {
      setState(() {});
    }
    //print('#######COUNTER ,$poseReps');
  }
}
