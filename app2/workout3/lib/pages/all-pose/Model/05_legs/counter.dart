import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:workout/index.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/06_push_up/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/05_legs/21_lunches/detector_exercises.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
//import '/flutter_flow/flutter_flow_util.dart';
//import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:workout/pages/wormup_page/wormup_page_widget.dart';
import 'package:workout/pages/all-pose/Model/01_warm_up/01_jumping_jack/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/01_warm_up/02_toy_soldier/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/01_warm_up/03_high_knees/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/01_warm_up/04_balance_arm_swing/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/01_warm_up/05_arm_circles/detector_exercises.dart';

class counter extends StatelessWidget {
  final int setstep;
  final int level; //ส่วนของ level
  const counter({
    this.setstep = 0,
    this.level = 0, //ส่วนของ level
  });
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2FBDAB),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderRadius: 20.0,
          borderWidth: 1.0,
          buttonSize: 40.0,
          icon: Icon(
            Icons.chevron_left_sharp,
            color: FlutterFlowTheme.of(context).primaryBtnText,
            size: 30.0,
          ),
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LevelPage4Widget(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Countdown(
              seconds: 1,
              build: (BuildContext context, time) => Text(
                  time.toInt().toString(),
                  style: TextStyle(
                      fontSize: 60,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold)),
              interval: Duration(milliseconds: 1000),
              onFinished: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => detector_exercises_lunches(
                        // setStep: setstep
                        level: level), //ท่า01
                    //builder: (context) => exercises(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
