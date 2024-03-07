// ignore_for_file: deprecated_member_use
import 'package:workout/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_ml_kit_push_up/google_ml_kit.dart';
import 'package:google_ml_kit_quad_stretch_with_wall/google_ml_kit.dart';
import 'dart:async';

class result_warm extends StatefulWidget {
  final int setstep;
  final int level; //ส่วนของ level
  final String? img;
  final String? routePoseName;

  const result_warm({
    Key? key,
    this.setstep = 0,
    this.level = 0, //ส่วนของ level
    this.img,
    this.routePoseName,
  });
  @override
  State<StatefulWidget> createState() => _PoseResultViewState();
}

class _PoseResultViewState extends State<result_warm> {
  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector();
  @override
  void dispose() async {
    super.dispose();
    await poseDetector.close();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  " ท่าที่ออกกำลังกาย Level" + widget.level.toString(),
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 40),
                Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(134, 185, 217, 246),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(20),
                        width: 400, // กำหนดความกว้าง
                        height: 250, // กำหนดความยาว
                        child: Column(
                          children: [
                            textPosture(context, widget.level),
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      minimumSize: Size(230, 50),
                      primary: const Color(0xFF2FBDAB)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeWidget()),
                    );
                  },
                  child: Text(
                    "กลับสู่หน้าหลัก",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget textPosture(BuildContext context, int level) {
  final _firestore = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  return StreamBuilder<DocumentSnapshot>(
    stream: _firestore.collection('workout_update').doc(uid).snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      }
      if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      }
      if (!snapshot.hasData || !snapshot.data!.exists) {
        return Text('No data available');
      }

      String levelName = level.toString();
      // Retrieve data from the snapshot
      var postData = snapshot.data!.data() as Map<String, dynamic>;
      var arm_raises = postData['arm_raises$levelName'] ?? '';
      var tricep_kickback = postData['tricep_kickback$levelName'] ?? '';
      var side_arm_raises = postData['side_arm_raises$levelName'] ?? '';
      var sidelying_floor_stretch =
          postData['sidelying_floor_stretch$levelName'] ?? '';
      var cat_cow_pose = postData['cat_cow_pose$levelName'] ?? '';

      // Create a Text widget with custom posture
      return Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Arm raises: " + arm_raises.toString() + ' ครั้ง',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          Text(
            "Tricep kickback: " + tricep_kickback.toString() + ' ครั้ง',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          Text(
            "Side arm raises: " + side_arm_raises.toString() + ' ครั้ง',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          Text(
            "Sidelying floor stretch: " +
                sidelying_floor_stretch.toString() +
                ' ครั้ง',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          Text(
            "Cat cow pose: " + cat_cow_pose.toString() + ' ครั้ง',
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ],
      );
    },
  );
}


  //const result_warm({Key? key}) : super(key: key);
