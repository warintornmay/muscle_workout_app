// ignore_for_file: duplicate_import, unused_local_variable, unused_import
import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/counter.dart';
import 'camera_view.dart';
import 'painters/pose_painter.dart';

import 'package:google_ml_kit_knee_push_up/google_ml_kit.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/07_knee_push_up/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/08_box_push_up/detector_exercises.dart';
import 'package:google_ml_kit_knee_push_up/google_ml_kit.dart';
import 'package:workout/pages/all-pose/Model/count_waitcam/count_waitcam.dart';
import 'package:intl/intl.dart';

class detector_exercises_kneepushup extends StatefulWidget {
  //เปลี่ยน  detector_exercises
  final bool useClassifier;
  final bool isActivity;
  final int setStep;
  final int level; //ส่วนของ level
  const detector_exercises_kneepushup({
    //เปลี่ยน  detector_exercises
    this.useClassifier = true,
    this.isActivity = true,
    this.setStep = 1,
    this.level = 0, //ส่วนของ level
  });

  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<detector_exercises_kneepushup> {
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
  //function เพื่อปรับให้หมดเวลา
  bool _staRoute = true;
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

  void _resetTimer() {
    setState(() {
      _seconds = 0;
    });
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
                            // Text(
                            //   'Name : ',
                            //   style: TextStyle(
                            //     fontSize: 20, // Adjust the font size
                            //     color: const Color.fromARGB(255, 0, 0, 0),
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
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
                                  'Knee Push Up',
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
                            // Text(
                            //   'Jumping_Jack',
                            //   style: TextStyle(
                            //     fontSize: 20, // Adjust the font size
                            //     color: const Color.fromARGB(255, 0, 0, 0),
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            // Text(
                            //   ' $poseName',
                            //   style: const TextStyle(
                            //     fontSize: 23,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
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
                                  '${poseReps > 0 ? 'Count : $poseReps ' : 'Count 0'}',
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
                            // const Icon(
                            //   Icons.access_alarms,
                            //   color: Color.fromARGB(255, 0, 0, 0),
                            //   size: 30.0,
                            // ),
                            // const Text(
                            //   'Timer : ',
                            //   style: TextStyle(
                            //     fontSize: 25.0,
                            //     color: Color.fromARGB(255, 0, 0, 0),
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 242, 242, 242),
                                ),
                                // child: Countdown(
                                //   seconds: _seconds,
                                //   build: (BuildContext context, time) => Text(
                                //     time.toInt().toString(),
                                //     style: const TextStyle(
                                //         fontSize: 25,
                                //         color: Color.fromARGB(255, 0, 0, 0),
                                //         fontWeight: FontWeight.bold),
                                //     textAlign: TextAlign.center,
                                //   ),
                                //   interval: const Duration(milliseconds: 1000),
                                //   onFinished: () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             const detector_exercises_kneepushup(), //ท่า02
                                //       ),
                                //     );
                                //   },
                                // ),
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
                                //Future.delayed(Duration(seconds: 2), () {
                                // Navigator.of(context).pushReplacement(
                                //   MaterialPageRoute(
                                //     builder: (context) => counter_cam(
                                //       level: widget.level,
                                //       routePoseName:
                                //           'detector_exercises_boxpushup',
                                //     ),
                                //   ),
                                // );
                                // });
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
          routePoseName: 'detector_exercises_boxpushup',
        ),
      ),
    );
  }

  Future movePage() async {
    while (_staRoute) {
      await Future<void>.delayed(const Duration(seconds: 1));
      int level = widget.level;

      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        uid = event!.uid;
        CollectionReference users =
            FirebaseFirestore.instance.collection('workout_update');
        if (uid != null) {
          await users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              print('Document data: ${documentSnapshot.data()}');
              if (poseReps != 0) {
                if ((documentSnapshot.data()
                        as Map<String, dynamic>)['knee_push_up$level'] ==
                    null) {
                  users.doc(uid).set({'knee_push_up$level': poseReps},
                      SetOptions(merge: true));
                } else {
                  users.doc(uid).update({'knee_push_up$level': poseReps});
                }
              }
            } else {
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
              routePoseName: 'detector_exercises_boxpushup',
            ),
          ),
        );
      }
    }
  }

  Future setTimeUsed() async {
    int prevTime;
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    while (_staRoute) {
      await Future<void>.delayed(const Duration(seconds: 1));
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        uid = event!.uid;
        CollectionReference users =
            FirebaseFirestore.instance.collection('users_used');

        if (uid != null) {
          await users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              if ((documentSnapshot.data()
                      as Map<String, dynamic>)['$formattedDate'] ==
                  null) {
                users
                    .doc(uid)
                    .set({'$formattedDate': 1}, SetOptions(merge: true));
              } else {
                prevTime = (documentSnapshot.data()
                    as Map<String, dynamic>)['$formattedDate'];
                users.doc(uid).update({'$formattedDate': prevTime + 1});
              }
            } else {
              users
                  .doc(uid)
                  .set({'$formattedDate': 1}, SetOptions(merge: true));
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
      // if (poseReps == getCountForLevel(level)) {
      //   await FirebaseAuth.instance.authStateChanges().listen((event) async {
      //     uid = event!.uid;
      //     CollectionReference users =
      //         FirebaseFirestore.instance.collection('workout_update');
      //     if (uid != null) {
      //       await users
      //           .doc(uid)
      //           .set({'knee_push_up$level': poseReps}); //เปลี่ยนชื่อ
      //     } else {
      //       print('No user');
      //     }
      //   });
      //================================================================
      // Future.delayed(
      //   Duration(seconds: 2),
      //   () {
      // while (_staRoute) {
      //   if (poseReps == getCountForLevel(level)) {
      //     _staRoute = false;
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (context) => counter_cam(
      //           level: widget.level,
      //           routePoseName: 'detector_exercises_boxpushup',
      //         ),
      //       ),
      //     );
      //   }
      // }

      //   },
      // );
      // }

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
}
