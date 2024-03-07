// // import 'dart:html';

// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:workout/pages/counter/counter.dart';
// import 'package:camera/camera.dart';
// import 'package:timer_count_down/timer_count_down.dart';
// import 'package:workout/pages/wormup_page/wormup_page_model.dart';

// void main() {
//   runApp(exercises());
// }

// class exercises extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: CameraScreen(),
//     );
//   }
// }

// class CameraScreen extends StatefulWidget {
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   @override
//   void initState() {
//     _controller = CameraController(
//       CameraDescription(
//         sensorOrientation: 1,
//         name: '1',
//         lensDirection: CameraLensDirection.front,
//       ),
//       ResolutionPreset.medium,
//     );
//     _initializeControllerFuture = _controller.initialize();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             double screenHeight = MediaQuery.of(context).size.height;
//             double screenWidth = MediaQuery.of(context).size.width;

//             return Container(
//               width: screenWidth,
//               height: screenHeight,
//               child: Stack(
//                 children: [
//                   CameraPreview(
//                     _controller,
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     child: Container(
//                       width: screenWidth,
//                       height:
//                           screenHeight * 0.32, // Adjust the height as needed
//                       color: Color.fromARGB(255, 47, 189, 198),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 10, // Adjust the height
//                           ),
//                           Text(
//                             'Jumping Jacks',
//                             style: TextStyle(
//                               fontSize:
//                                   screenHeight * 0.04, // Adjust the font size
//                               color: const Color.fromARGB(255, 0, 0, 0),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(
//                                 Icons.access_alarms,
//                                 color: Color.fromARGB(255, 0, 0, 0),
//                                 size: 30.0,
//                               ),
//                               SizedBox(
//                                 width: 10, // Adjust the width
//                               ),
//                               Text(
//                                 'Timer : ',
//                                 style: TextStyle(
//                                   fontSize: 30.0,
//                                   color: const Color.fromARGB(255, 0, 0, 0),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Countdown(
//                                 seconds: 20,
//                                 build: (BuildContext context, time) => Text(
//                                     time.toInt().toString(),
//                                     style: TextStyle(
//                                         fontSize: 30,
//                                         color:
//                                             const Color.fromARGB(255, 0, 0, 0),
//                                         fontWeight: FontWeight.bold)),
//                                 interval: Duration(milliseconds: 1000),
//                                 onFinished: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => exercises(),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Icon(
//                                 Icons.offline_pin,
//                                 color: Colors.black,
//                                 size: 30.0,
//                               ),
//                               SizedBox(
//                                 width: 10, // Adjust the width
//                               ),
//                               Text(
//                                 'Count : 0',
//                                 style: TextStyle(
//                                   fontSize: 30.0,
//                                   color: const Color.fromARGB(255, 0, 0, 0),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               // Text(
//                               //   'Count : 0',
//                               //   style: TextStyle(
//                               //     fontSize: 30.0,
//                               //     color: const Color.fromARGB(255, 0, 0, 0),
//                               //     fontWeight: FontWeight.bold,
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 20, // Adjust the height
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Color.fromARGB(255, 89, 189, 7),
//                                   onPrimary: Color.fromARGB(255, 0, 0, 0),
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 40, vertical: 20),
//                                   textStyle: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => counter(),
//                                     ),
//                                   );
//                                 },
//                                 child: const Text('Skip'),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 0,
//                     child: Container(
//                       width: screenWidth,
//                       height:
//                           screenHeight * 0.68, // Adjust the height as needed
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: const Color.fromARGB(255, 213, 2, 2),
//                           width: 4.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
