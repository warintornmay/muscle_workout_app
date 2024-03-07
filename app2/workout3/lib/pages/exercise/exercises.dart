// // import 'dart:html';

// import 'package:flutter/material.dart';
// //import 'package:workout/pages/counter/counter.dart';
// import 'package:camera/camera.dart';

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
//                       color: Color.fromARGB(255, 75, 232, 130),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Jumping Jacks',
//                             style: TextStyle(
//                               fontSize:
//                                   screenHeight * 0.04, // Adjust the font size
//                               color: const Color.fromARGB(255, 0, 0, 0),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             'Warm Up',
//                             style: TextStyle(
//                               fontSize:
//                                   screenHeight * 0.03, // Adjust the font size
//                               color: const Color.fromARGB(255, 0, 0, 0),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Text(
//                             '5 วินาที',
//                             style: TextStyle(
//                               fontSize:
//                                   screenHeight * 0.03, // Adjust the font size
//                               color: const Color.fromARGB(255, 0, 0, 0),
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
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

//     // Widget _buildImageColumn() {
//     //   return Container(
//     //       width: 300.0,
//     //       height: 500.0,
//     //       decoration: BoxDecoration(
//     //         border: Border.all(
//     //           color: const Color.fromARGB(255, 213, 2, 2), // สีขอบ
//     //           width: 8.0, // ความกว้างขอบ
//     //         ),
//     //       ));
//     // }

//     // return Scaffold(
//     //   backgroundColor: Color.fromARGB(255, 169, 169, 169),
//     // body: FutureBuilder<void>(
//     //     future: _initializeControllerFuture,
//     //     builder: (context, snapshot) {
//     //       if (snapshot.connectionState == ConnectionState.done) {
//     //         return CameraPreview(_controller);
//     //       } else {
//     //         return Center(child: CircularProgressIndicator());
//     //       }
//     //     }),
//     // );

//     // return Container(
//     //   child: FutureBuilder<void>(
//     //     future: _initializeControllerFuture,
//     //     builder: (context, snapshot) {
//     //       if (snapshot.connectionState == ConnectionState.done) {
//     //         return CameraPreview(_controller,
//     //             child: Column(
//     //               mainAxisAlignment: MainAxisAlignment.end,
//     //               children: [
//     //                 Container(
//     //                   width: 400.0,
//     //                   height: 500.0,
//     //                   decoration: BoxDecoration(
//     //                     border: Border.all(
//     //                       color: const Color.fromARGB(255, 213, 2, 2), // สีขอบ
//     //                       width: 8.0, // ความกว้างขอบ
//     //                     ),
//     //                   ),
//     //                 ),
//     //                 Container(
//     //                     width: 400,
//     //                     height: 200.0,
//     //                     color: Color.fromARGB(255, 241, 237, 237)),
//     //               ],
//     //             ));
//     //       } else {
//     //         return Center(child: CircularProgressIndicator());
//     //       }
//     //     },
//     //   ),
//     //   width: 400,
//     //   height: 700,
//     // );
//   }
// }
