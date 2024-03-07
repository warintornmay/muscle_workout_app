import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_ml_kit_mountain_climber/google_ml_kit.dart';

import 'coordinates_translator.dart';

class PosePainter extends CustomPainter {
  PosePainter(this.poses, this.absoluteImageSize, this.rotation);

  final List<DetectedPose> poses;
  final Size absoluteImageSize;
  final InputImageRotation rotation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Color.fromARGB(255, 16, 12, 224);

    final leftPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Color.fromARGB(255, 8, 248, 56);

    final rightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Color.fromARGB(255, 8, 248, 56);

    poses.forEach((pose) {
      pose.landmarks.forEach((_, landmark) {
        canvas.drawCircle(
            Offset(
              translateX(landmark.x, rotation, size, absoluteImageSize),
              translateY(landmark.y, rotation, size, absoluteImageSize),
            ),
            1,
            paint);
      });

      void paintLine(
          PoseLandmarkType type1, PoseLandmarkType type2, Paint paintType) {
        PoseLandmark joint1 = pose.landmarks[type1]!;
        PoseLandmark joint2 = pose.landmarks[type2]!;
        canvas.drawLine(
            Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
                translateY(joint1.y, rotation, size, absoluteImageSize)),
            Offset(translateX(joint2.x, rotation, size, absoluteImageSize),
                translateY(joint2.y, rotation, size, absoluteImageSize)),
            paintType);
      }

      //Draw arms left
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, leftPaint);
      paintLine(
          PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist, leftPaint);
      paintLine(
          PoseLandmarkType.leftWrist, PoseLandmarkType.leftPinky, leftPaint);
      paintLine(
          PoseLandmarkType.leftPinky, PoseLandmarkType.leftIndex, leftPaint);
      paintLine(
          PoseLandmarkType.leftIndex, PoseLandmarkType.leftThumb, leftPaint);
      //Draw arms right
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow,
          rightPaint);
      paintLine(
          PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist, rightPaint);
      paintLine(
          PoseLandmarkType.rightWrist, PoseLandmarkType.rightPinky, rightPaint);
      paintLine(
          PoseLandmarkType.rightPinky, PoseLandmarkType.rightIndex, rightPaint);
      paintLine(
          PoseLandmarkType.rightIndex, PoseLandmarkType.rightThumb, rightPaint);

      //Draw Body
      paintLine(PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder,
          leftPaint);
      paintLine(
          PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, leftPaint);
      paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.rightHip, leftPaint);
      paintLine(PoseLandmarkType.rightHip, PoseLandmarkType.rightShoulder,
          rightPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.leftShoulder,
          rightPaint);

      //Draw legs left
      paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, leftPaint);
      paintLine(
          PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle, leftPaint);
      paintLine(
          PoseLandmarkType.leftAnkle, PoseLandmarkType.leftHeel, leftPaint);
      paintLine(
          PoseLandmarkType.leftHeel, PoseLandmarkType.leftFootIndex, leftPaint);

      //Draw legs left
      paintLine(
          PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, rightPaint);
      paintLine(
          PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle, rightPaint);
      paintLine(
          PoseLandmarkType.rightAnkle, PoseLandmarkType.rightHeel, rightPaint);
      paintLine(PoseLandmarkType.rightHeel, PoseLandmarkType.rightFootIndex,
          rightPaint);
    });
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.poses != poses;
  }
}
