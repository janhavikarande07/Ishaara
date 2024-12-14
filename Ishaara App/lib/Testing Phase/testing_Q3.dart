import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shreya/db_tasks.dart';
import '../values_.dart';
import 'TestingLevelPage.dart';
import '../colors.dart';

class Testing_Q3 extends StatefulWidget {
  final int current_level;
  const Testing_Q3({Key? key, required this.current_level}) : super(key: key);
  @override
  State<Testing_Q3> createState() => Testing_Q3State();
}

class Testing_Q3State extends State<Testing_Q3> with WidgetsBindingObserver {
  double _width = 250;
  double percent = 3/3;

  List<String> question_testing = [];
  String question = "";
  bool flag = true;
  String type = "alphabets";

  Map<String, dynamic> data = {};

  User? user = FirebaseAuth.instance.currentUser;

  late ConfettiController _confettiController;
  bool isCorrectAnswer = false;

  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCapturing = false;
  Timer? _timer;
  String _serverResponse = "0%";

  Future<void> getData() async {
    DocumentReference docRef = FirebaseFirestore.instance.collection("Users").doc(user!.uid);
    DocumentSnapshot snapshot = await docRef.get();
    if (snapshot.exists) {
      dynamic fieldValue = snapshot.data();
      if (fieldValue != null) {
        setState(() {
          data.addAll(fieldValue);
        });
        print(data);
      }
    }
  }

  Future<void> _initializeCamera([CameraLensDirection direction = CameraLensDirection.front]) async {
    try {
      _cameras = await availableCameras();
      print("casghva $_cameras");
      CameraDescription? selectedCamera = _cameras?.firstWhere(
            (camera) => camera.lensDirection == direction,
        orElse: () => _cameras!.first,
      );

      if (selectedCamera != null) {
        _controller = CameraController(
          selectedCamera,
          ResolutionPreset.medium,
        );
        print("1");

        await _controller?.initialize();
        print(2);
        // await _controller?.setFocusMode(FocusMode.locked);
        print(3);

        _startCapturing();
      } else {
        print('No cameras available');
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  void _startCapturing() {
    if (_controller == null || !_controller!.value.isInitialized) {
      print('Camera not initialized');
      return;
    }

    setState(() {
      _isCapturing = true;
    });

    _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      if (_controller == null || !_controller!.value.isInitialized) {
        print('Camera not initialized or disposed');
        return;
      }

      try {
        final XFile image = await _controller!.takePicture();
        Uint8List imageBytes = await image.readAsBytes();
        await _sendImageToServer(imageBytes);
      } catch (e) {
        print("Error capturing image: $e");
      }
    });
  }

  Future<void> _sendImageToServer(Uint8List bytes) async {
    try {
      var uri = Uri.parse('$ip_address/predict');

      var request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: 'frame.jpg',
          contentType: MediaType('image', 'jpeg'),
        ));

      var response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);

        double confidence = jsonResponse['confidence'];
        String label = jsonResponse['label'];

        print(confidence);
        print(label);

        setState(() {
          // Check if the correct answer is detected
          if (confidence > 0.8 && label.toLowerCase() == question.toLowerCase()) {
            _serverResponse = "${(confidence * 100).toStringAsFixed(2)}%";
            isCorrectAnswer = true;

            // Stop capturing images
            _stopCapturing();

            // Show confetti
            _confettiController.play();
          }
          else{
            _serverResponse = "0%";
          }
        });
      } else {
        print('Failed to get response from server: ${response.statusCode}');
      }
    } catch (e) {
      print("Error sending image to server: $e");
    }
  }

  void _stopCapturing() {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
    _timer = null;
    setState(() {
      _isCapturing = false;
      // _controller?.dispose();
      _controller = null;
    });
  }

  void _flipCamera() {
    if (_cameras == null || _cameras!.length < 2) {
      print('No secondary camera available');
      return;
    }

    setState(() {
      CameraLensDirection newDirection =
      _controller?.description.lensDirection == CameraLensDirection.front
          ? CameraLensDirection.back
          : CameraLensDirection.front;
      _initializeCamera(newDirection);
    });
  }

  @override
  void initState() {
    super.initState();
    Random random = Random();
    testing.shuffle(random);
    question = testing[0];
    if(digits.contains(question)){
      type = "digits";
    }
    WidgetsBinding.instance.addObserver(this);
    getData();
    _initializeCamera();
    _confettiController = ConfettiController();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _stopCapturing();
    _controller?.dispose();
    _controller = null;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      // Stop camera and server calls when app is not active
      _stopCapturing();
      _controller?.dispose();
      _controller = null;
    } else if (state == AppLifecycleState.resumed) {
      // Re-initialize the camera when the app is resumed
      _initializeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _width = percent * 250;
      });
    });
    return Scaffold(
      body :SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height : 30),
              Row(
                children: [
                  IconButton(onPressed: ()async {
                    await Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => TestingPage(),
                      ),
                    );
                  },
                    icon: Icon(Icons.close, size: 30, weight: 50,),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 250,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0xFFCFE2F3)),
                      ),
                      AnimatedContainer(
                          duration: const Duration(milliseconds: 800),
                          width: _width,
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: themeColor)
                      ),
                    ],
                  ),
                  SizedBox(width: 10,),
                  Image.asset("assets/honey_jar.png", width: 30, height: 50,),
                  Text(" 4", style: TextStyle(fontFamily: "Cooper", fontWeight: FontWeight.w700, fontSize: 20),)
                ],
              ),
              SizedBox(height: 20),
              Text("Show hand sign for \n${question}",
                style: TextStyle(
                  fontFamily: "Cooper",
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: themeColor, width: 4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _controller != null && _controller!.value.isInitialized
                    ? Stack(
                  children: [
                    ClipRRect(
                      child: SizedOverflowBox(
                        size : Size(300,300),
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(
                              _controller!.description.lensDirection == CameraLensDirection.front ? pi : 0),
                          child: CameraPreview(_controller!),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: ElevatedButton(
                        onPressed: _flipCamera,
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(10),
                          backgroundColor: Colors.white,
                        ),
                        child: Icon(Icons.flip_camera_android, color: Colors.black),
                      ),
                    ),
                  ],
                )
                    : (isCorrectAnswer) ?
                SizedOverflowBox(
                  size : Size(300,200),
                  child: Text(
                    "Correct Answer!!!\nGood Job", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24,),
                  ),
                ) :
                SizedOverflowBox(
                  size : Size(300,200),
                  child: Icon(Icons.camera_alt, weight: 700, size: 40),
                ),
              ),
              SizedBox(height: 20,),
              OutlinedButton(
                onPressed: () {},
                child: Text(
                  _serverResponse,
                  style: TextStyle(
                    fontFamily: "Cooper",
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: darkThemeColor, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
              ),
              SizedBox(height: 30,),
              Padding(padding: EdgeInsets.symmetric(horizontal: 30),
                child :
                Text("1. Ensure hand signs are clear and well-lit for accurate detection.\n2. Aim for an accuracy of over 80% to progress to the next test; adjust hand positioning or gestures as needed for improved results.",
                  style: TextStyle(
                    fontFamily: "Cooper",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: CupertinoColors.inactiveGray,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                onPressed: flag
                  ? () async {
                try {
                  setState(() {
                    current_testing_level++;
                    testing_levels["${widget.current_level}"]++;
                  });
                 await updateUser(user?.uid, points_data);
                  await Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => TestingPage()
                    ),
                  );
                }
                on Exception catch (e){
                  print("Error");
                }
              }
                  : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCorrectAnswer ? themeColor : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  minimumSize: const Size(double.infinity, 50),
                  shadowColor: yellowishOrange,
                  elevation: 5,
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: "Cooper",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}