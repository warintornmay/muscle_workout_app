// ignore_for_file: duplicate_import, unused_local_variable, unused_import
import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:workout/index.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/counter.dart';
// import 'package:workout/pages/all-pose/Model/02_arm_chest/report_arm_chest.dart';
import 'camera_view.dart';
import 'painters/pose_painter.dart';

import 'package:workout/pages/wormup_page/wormup_page_model.dart';
import 'package:google_ml_kit_cobra_stretch/google_ml_kit.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/10_cobra_stretch/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/result.dart';
import 'package:workout/pages/all-pose/Model/count_waitcam/count_waitcam.dart';
import 'package:intl/intl.dart';

class detector_exercises_cobra extends StatefulWidget {
  //เปลี่ยน  detector_exercises
  final bool useClassifier;
  final bool isActivity;
  final int setStep;
  final int level; //ส่วนของ level
  const detector_exercises_cobra({
    //เปลี่ยน  detector_exercises
    this.useClassifier = true,
    this.isActivity = true,
    this.setStep = 1,
    this.level = 0, //ส่วนของ level
  });

  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState();
}

class _PoseDetectorViewState extends State<detector_exercises_cobra> {
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
  int _seconds = 5;
  //function เพื่อปรับให้หมดเวลา
  bool _staRoute = true;
  void _resetTimer() {
    setState(() {
      _seconds = 0;
    });
  }

  @override
  void initState() {
    setTimeUsed();
    super.initState();
    setCountFirebase();
    if (widget.level == 1) {
      _seconds = 20;
    } else if (widget.level == 2) {
      _seconds = 20;
    } else if (widget.level == 3) {
      _seconds = 30;
    }
    // else {
    //   _seconds = 1;
    // }
  }

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
                                  'Cobra Stretch',
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
                            // const Icon(
                            //   Icons.offline_pin,
                            //   color: Colors.black,
                            //   size: 30.0,
                            // ),
                            // const SizedBox(
                            //   width: 10, // Adjust the width
                            // ),

                            Expanded(
                              child: Container(
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(20),
                                  //   color:
                                  //       const Color.fromARGB(255, 242, 242, 242),
                                  // ),
                                  // child: Text(
                                  //   '${poseReps > 0 ? 'Count : $poseReps' : 'Count 0'}',
                                  //   style: const TextStyle(
                                  //     fontSize: 25.0,
                                  //     color: Color.fromARGB(255, 0, 0, 0),
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  //   textAlign: TextAlign.center,
                                  // ),
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
                            const Icon(
                              Icons.access_alarms,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: 30.0,
                            ),
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
                                child: Countdown(
                                  seconds: _seconds,
                                  build: (BuildContext context, time) => Text(
                                    time.toInt().toString(),
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  interval: const Duration(milliseconds: 1000),
                                  onFinished: () {
                                    SkipPage();
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => result_warm(
                                    //       level: widget.level,
                                    //       // useClassifier: true,
                                    //       // isActivity: true,
                                    //     ), //ท่า02
                                    //   ),
                                    // );
                                  },
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
                                _resetTimer();
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => LevelPage1Widget(),
                                //   ),
                                // );
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
        builder: (context) => result_warm(
          level: widget.level,
        ),
      ),
    );
  }

  Future setCountFirebase() async {
    int level = widget.level;
    int _settime = 0;

    while (_staRoute) {
      await Future.delayed(Duration(seconds: 1));
      _seconds--;
      _settime++;
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        uid = event!.uid;
        CollectionReference users =
            FirebaseFirestore.instance.collection('workout_update');
        if (uid != null) {
          await users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              print('Document data: ${documentSnapshot.data()}');
              if ((documentSnapshot.data()
                      as Map<String, dynamic>)['cobra_stretch$level'] ==
                  null) {
                users.doc(uid).set(
                    {'cobra_stretch$level': _settime}, SetOptions(merge: true));
              } else {
                users.doc(uid).update({'cobra_stretch$level': _settime});
              }
            } else {
              print('Document does not exist on the database');
            }
          });
        } else {
          print('No user');
        }
      });
      if (_seconds == 0) {
        _staRoute = false;
      } else {
        print('$_seconds');
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
        // if (poseReps == 3) {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) =>
        //           detector_exercises_toysoldier(),
        //     ),
        //   );
        // }
      });
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
