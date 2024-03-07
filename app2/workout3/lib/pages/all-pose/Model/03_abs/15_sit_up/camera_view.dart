// ignore_for_file: unused_local_variable

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit_sit_up/google_ml_kit.dart';
import '/main.dart';

enum ScreenMode { liveFeed, gallery }

class CameraView extends StatefulWidget {
  CameraView(
      {Key? key,
      required this.customPaint,
      required this.onImage,
      this.initialDirection = CameraLensDirection.back})
      : super(key: key);

  final CustomPaint? customPaint;
  final Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? _controller;

  // 1: front cam
  // 0: rear cam
  int _cameraIndex = 1;

  @override
  void initState() {
    super.initState();
    _startLiveFeed();
  }

  @override
  void dispose() {
    _stopLiveFeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fraction =
        _controller!.value.isInitialized ? _controller!.value.aspectRatio : 0;

    return _controller!.value.isInitialized
        ? Stack(
            children: [
              Container(
                child: AspectRatio(
                  aspectRatio: 1 / fraction,
                  child: _controller!.buildPreview(),
                ),
              ),
              if (widget.customPaint != null)
                Container(
                  child: widget.customPaint!,
                  height: screenWidth * fraction,
                  width: screenWidth,
                ),
              Positioned(
                child: Container(
                  width: screenWidth,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 213, 2, 2),
                      width: 4.0,
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container(
            height: 50,
            width: 50,
          );
  }

  // Widget _liveFeedBody() {
  //   if (_controller?.value.isInitialized == false) {
  //     return Container();
  //   }
  //   return Container(
  //     color: Colors.black,
  //     child: Stack(
  //       fit: StackFit.expand,
  //       children: <Widget>[
  //         CameraPreview(_controller!),
  //         if (widget.customPaint != null) widget.customPaint!,
  //       ],
  //     ),
  //   );
  // }

  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    // final camera = cameras[0];
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller?.startImageStream(_processCameraImage);
      setState(() {});
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
    _controller = null;
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();

    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.NV21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    widget.onImage(inputImage);
  }
}
