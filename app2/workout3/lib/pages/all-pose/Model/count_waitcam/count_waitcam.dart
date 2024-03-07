import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:workout/index.dart';

import 'package:google_ml_kit_cobra_stretch/google_ml_kit.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:workout/pages/all-pose/Model/01_warm_up/01_jumping_jack/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/01_warm_up/02_toy_soldier/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/01_warm_up/03_high_knees/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/01_warm_up/04_balance_arm_swing/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/01_warm_up/05_arm_circles/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/06_push_up/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/07_knee_push_up/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/08_box_push_up/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/09_shoulder_stretch/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/02_arm_chest/10_cobra_stretch/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/03_abs/11_abdominal_crunch/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/03_abs/12_legs_raise/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/03_abs/13_plank/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/03_abs/14_mountain_climber/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/03_abs/15_sit_up/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/04_shoulder_back/16_arm_raises/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/04_shoulder_back/17_tricep_kickback/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/04_shoulder_back/18_side_arm_raises/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/04_shoulder_back/19_sidelying_floor_stretch/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/04_shoulder_back/20_cat_cow_pose/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/05_legs/21_lunches/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/05_legs/22_squats/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/05_legs/23_sidelying_leg_raises/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/05_legs/24_donkey_kick/detector_exercises.dart';
import 'package:workout/pages/all-pose/Model/05_legs/25_quad_stretch_with_wall/detector_exercises.dart';

class counter_cam extends StatefulWidget {
  final int setstep;
  final int level; //ส่วนของ level
  final String? img;
  final String? routePoseName;
  const counter_cam({
    Key? key,
    this.setstep = 0,
    this.level = 0, //ส่วนของ level
    this.img,
    this.routePoseName,
  });
  @override
  State<StatefulWidget> createState() => _PoseCountViewState();
}

class _PoseCountViewState extends State<counter_cam> {
  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector();
  @override
  void dispose() async {
    super.dispose();
    await poseDetector.close();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IntrinsicHeight(
          child: Column(
            children: <Widget>[
              imgGift(context, widget.routePoseName!),
              Countdown(
                seconds: 5,
                build: (BuildContext context, time) => Text(
                    time.toInt().toString(),
                    style: TextStyle(
                        fontSize: 60,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold)),
                interval: Duration(milliseconds: 1000),
                onFinished: () {
                  routeToDetectorExercises(
                      context, widget.level, widget.routePoseName!);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => detector_exercises_pushup(
                  //         // setStep: setstep
                  //         level: level), //ท่า01
                  //     //builder: (context) => exercises(),
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void routeToDetectorExercises(
    BuildContext context, int level, String routePoseName) {
  //01_warm_up
  if (routePoseName == 'detector_exercises_jumping_jack') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detector_exercises_jumping_jack(), //01-->02
      ),
    );
  }
  if (routePoseName == 'detector_exercises_toy_soldier') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detector_exercises_toy_soldier(), //01-->02
      ),
    );
  }
  if (routePoseName == 'detector_exercises_high_knees') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detector_exercises_high_knees(), //02-->03
      ),
    );
  }
  if (routePoseName == 'detector_exercises_balance') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detector_exercises_balance(), //03-->04
      ),
    );
  }
  if (routePoseName == 'detector_exercises_arm_circles') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detector_exercises_arm_circles(), //04-->05
      ),
    );
  }
  //02_arm_chest
  if (routePoseName == 'detector_exercises_abdominal_crunch') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            detector_exercises_abdominal_crunch(level: level), //Start 06
      ),
    );
  }
  if (routePoseName == 'detector_exercises_pushup') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            detector_exercises_pushup(level: level), //Start 06
      ),
    );
  }
  if (routePoseName == 'detector_exercises_kneepushup') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            detector_exercises_kneepushup(level: level), //06-->07
      ),
    );
  }
  if (routePoseName == 'detector_exercises_boxpushup') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            detector_exercises_boxpushup(level: level), //07-->08
      ),
    );
  }
  if (routePoseName == 'detector_exercises_shoulderstretch') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            detector_exercises_shoulderstretch(level: level), //08-->09
      ),
    );
  }
  if (routePoseName == 'detector_exercises_cobra') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detector_exercises_cobra(level: level), //09-->10
      ),
    );
  }
  //03_abs
  if (routePoseName == 'detector_exercises_legs') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detector_exercises_legs(level: level), //11-->12
      ),
    );
  }
  if (routePoseName == 'detector_exercises_plank') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detector_exercises_plank(level: level), //12-->13
      ),
    );
  }
  if (routePoseName == 'detector_exercises_mountain') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            detector_exercises_mountain(level: level), //13-->14
      ),
    );
  }
  if (routePoseName == 'detector_exercises_situp') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detector_exercises_situp(level: level), //14-->15
      ),
    );
  }
  //04_shoulder_back
  if (routePoseName == 'detector_exercises_lunches') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            detector_exercises_lunches(level: level), //15-->16
      ),
    );
  }
  if (routePoseName == 'detector_exercises_armraises') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            detector_exercises_armraises(level: level), //start-->16
      ),
    );
  }
  if (routePoseName == 'detector_exercises_tricep') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detector_exercises_tricep(level: level), //16-->17
      ),
    );
  }
  if (routePoseName == 'detector_exercises_side_arm_raises') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            detector_exercises_side_arm_raises(level: level), //17-->18
      ),
    );
  }
  if (routePoseName == 'detector_exercises_sidelying_floor_stretch') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            detector_exercises_sidelying_floor_stretch(level: level), //18-->19
      ),
    );
  }
  if (routePoseName == 'detector_exercises_catcow') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detector_exercises_catcow(level: level), //19-->20
      ),
    );
  }
  //05_legs
  if (routePoseName == 'detector_exercises_squats') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detector_exercises_squats(level: level), //21-->22
      ),
    );
  }
  if (routePoseName == 'detector_exercises_sidelying_leg_raises') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            detector_exercises_sidelying_leg_raises(level: level), //22-->23
      ),
    );
  }
  if (routePoseName == 'detector_exercises_donkey_kick') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            detector_exercises_donkey_kick(level: level), //23-->24
      ),
    );
  }
  if (routePoseName == 'detector_exercises_quad_stretch') {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            detector_exercises_quad_stretch(level: level), //24-->25
      ),
    );
  }
}

Builder imgGift(BuildContext context, String poseName) {
  String img = '';
  if (poseName == 'detector_exercises_jumping_jack') {
    //01
    img = 'assets/images/jumpingjack.gif';
  } else if (poseName == 'detector_exercises_toy_soldier') {
    //02
    img = 'assets/images/toy.gif';
  } else if (poseName == 'detector_exercises_high_knees') {
    //03
    img = 'assets/images/high_knees.gif';
  } else if (poseName == 'detector_exercises_balance') {
    //04
    img = 'assets/images/balance_arm_swing.gif';
  } else if (poseName == 'detector_exercises_arm_circles') {
    //05
    img = 'assets/images/arm_circles.gif';
  } else if (poseName == 'detector_exercises_pushup') {
    //06
    img = 'assets/images/push_up.gif';
  } else if (poseName == 'detector_exercises_kneepushup') {
    //07
    img = 'assets/images/knee_push_up.gif';
  } else if (poseName == 'detector_exercises_boxpushup') {
    //08
    img = 'assets/images/box_push_up.gif';
  } else if (poseName == 'detector_exercises_shoulderstretch') {
    //09
    img = 'assets/images/shoulder_stretch.gif';
  } else if (poseName == 'detector_exercises_cobra') {
    //10
    img = 'assets/images/cobra_stretch.gif';
  } else if (poseName == 'detector_exercises_abdominal_crunch') {
    //11
    img = 'assets/images/abdomonal_crunch.gif';
  } else if (poseName == 'detector_exercises_legs') {
    //12
    img = 'assets/images/legs_raise.gif';
  } else if (poseName == 'detector_exercises_plank') {
    //13
    img = 'assets/images/plank.gif';
  } else if (poseName == 'detector_exercises_mountain') {
    //14
    img = 'assets/images/mountain_climber.gif';
  } else if (poseName == 'detector_exercises_situp') {
    //15
    img = 'assets/images/sit_up.gif';
  } else if (poseName == 'detector_exercises_armraises') {
    //16
    img = 'assets/images/arm_raises.gif';
  } else if (poseName == 'detector_exercises_tricep') {
    //17
    img = 'assets/images/tricep_kickback.gif';
  } else if (poseName == 'detector_exercises_side_arm_raises') {
    //18
    img = 'assets/images/side_arm_raises.gif';
  } else if (poseName == 'detector_exercises_sidelying_floor_stretch') {
    //19
    img = 'assets/images/sidelying_floor_stretch.gif';
  } else if (poseName == 'detector_exercises_catcow') {
    //20
    img = 'assets/images/cat_cow_pose.gif';
  } else if (poseName == 'detector_exercises_lunches') {
    //21
    img = 'assets/images/lunches.gif';
  } else if (poseName == 'detector_exercises_squats') {
    //22
    img = 'assets/images/squats.gif';
  } else if (poseName == 'detector_exercises_sidelying_leg_raises') {
    //23
    img = 'assets/images/sidelying_leg_raises.gif';
  } else if (poseName == 'detector_exercises_donkey_kick') {
    //24
    img = 'assets/images/donkey_kick.gif';
  } else if (poseName == 'detector_exercises_quad_stretch') {
    //25
    img = 'assets/images/quad_stretch_with_wall.gif';
  }

  return Builder(builder: (BuildContext context) {
    return Container(
      height: 450.0,
      width: 340.0,
      child: Image.asset(
        img,
      ),
    );
  });
}
