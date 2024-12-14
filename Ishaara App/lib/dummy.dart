import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'Learning Phase/AlphabetsLevelPage.dart';
import 'colors.dart';

class A_Q3_2 extends StatefulWidget {
  final String current_alphabet;
  final int current_level;

  const A_Q3_2({Key? key, required this.current_alphabet, required this.current_level}) : super(key: key);

  @override
  State<A_Q3_2> createState() => A_Q3_2State();
}

class A_Q3_2State extends State<A_Q3_2> with WidgetsBindingObserver {
  double _width = 300;
  double percent = 1;
  bool flag = true;
  Map<String, dynamic> alphabets_map = {
    "1": ["a", "b"],
    "2": ["c", "d"],
    "3": ["e", "f"],
    "4": ["g", "h"],
    "5": ["i", "j"],
    "6": ["k", "l"],
    "7": ["m", "n"],
    "8": ["o", "p"],
    "9": ["q", "r"],
    "10": ["s", "t"],
    "11": ["u", "v"],
    "12": ["w", "x"],
    "13": ["y", "z"],
  };

  Map<String, dynamic> data = {};
  User? user = FirebaseAuth.instance.currentUser;

  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isRecording = false;
  String? _serverResponse;

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
      CameraDescription? selectedCamera = _cameras?.firstWhere(
            (camera) => camera.lensDirection == direction,
        orElse: () => _cameras!.first,
      );

      if (selectedCamera != null) {
        _controller = CameraController(
          selectedCamera,
          ResolutionPreset.medium,
          enableAudio: true,
        );

        await _controller?.initialize();
        await _controller?.setFocusMode(FocusMode.locked);
        setState(() {});
      } else {
        print('No cameras available');
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  void _startRecording() async {
    if (_controller == null || !_controller!.value.isInitialized || _isRecording) {
      print('Camera not initialized or already recording');
      return;
    }

    try {
      await _controller!.startVideoRecording();
      setState(() {
        _isRecording = true;
      });

      // Stop recording after 5 seconds
      Future.delayed(Duration(seconds: 6), () async {
        await _stopRecording();
      });
    } catch (e) {
      print("Error starting video recording: $e");
    }
  }

  Future<void> _stopRecording() async {
    if (!_isRecording) return;

    try {
      XFile videoFile = await _controller!.stopVideoRecording();
      setState(() {
        _isRecording = false;
      });

      Uint8List videoBytes = await videoFile.readAsBytes();
      await _sendVideoToServer(videoBytes);
    } catch (e) {
      print("Error stopping video recording: $e");
    }
  }

  Future<void> _sendVideoToServer(Uint8List bytes) async {
    try {
      var uri = Uri.parse('http://192.168.114.34:5000/predict_v');

      var request = http.MultipartRequest('POST', uri)
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: 'video.mp4',
          contentType: MediaType('video', 'mp4'),
        ));

      var response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        setState(() {
          _serverResponse = responseBody;
        });
      } else {
        print('Failed to get response from server: ${response.statusCode}');
      }
    } catch (e) {
      print("Error sending video to server: $e");
    }
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
    WidgetsBinding.instance.addObserver(this);
    getData();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      // Stop camera and server calls when app is not active
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
        _width = percent * 300;
      });
    });
    return Scaffold(
      body: SingleChildScrollView(
        child :
        Container(
          padding: EdgeInsets.all(20.0),
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      _controller?.dispose();
                      _controller = null;
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AlphabetsPage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.close, size: 30, weight: 50),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: 300,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xFFCFE2F3),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        width: _width,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: themeColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Alphabet ${widget.current_alphabet}",
                style: TextStyle(
                  fontFamily: "Cooper",
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Image.asset(
                "assets/alphabets/${widget.current_alphabet}.png",
                width: 100,
                height: 100,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _controller != null && _controller!.value.isInitialized
                    ? Stack(
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(
                          _controller!.description.lensDirection == CameraLensDirection.front ? pi : 0), // Flip for front camera
                      child: AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: CameraPreview(_controller!),
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
                    : Icon(Icons.camera_alt, weight: 700, size: 40),
              ),
              SizedBox(height: 10),
              if (_serverResponse != null)
                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    _serverResponse!,
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
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  "1. Ensure hand signs are clear and well-lit for accurate detection.\n2. Aim for an accuracy of over 80% to progress to the next test; adjust hand positioning or gestures as needed for improved results.",
                  style: TextStyle(
                    fontFamily: "Cooper",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: CupertinoColors.inactiveGray,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: _startRecording,
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  minimumSize: const Size(double.infinity, 50),
                  shadowColor: yellowishOrange,
                  elevation: 5,
                ),
                child: const Text(
                  "Start Recording",
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




// import 'dart:async';
// import 'dart:math';
// import 'dart:typed_data';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:shreya/AplhabetsLevelStartPage.dart';
// import 'AlphabetsLevelPage.dart';
// import 'colors.dart';
//
// class A_Q3_2 extends StatefulWidget {
//   final String current_alphabet;
//   final int current_level;
//
//   const A_Q3_2({Key? key, required this.current_alphabet, required this.current_level}) : super(key: key);
//
//   @override
//   State<A_Q3_2> createState() => A_Q3_2State();
// }
//
// class A_Q3_2State extends State<A_Q3_2> with WidgetsBindingObserver {
//   double _width = 300;
//   double percent = 1;
//   bool flag = true;
//   Map<String, dynamic> alphabets_map = {
//     "1": ["a", "b"],
//     "2": ["c", "d"],
//     "3": ["e", "f"],
//     "4": ["g", "h"],
//     "5": ["i", "j"],
//     "6": ["k", "l"],
//     "7": ["m", "n"],
//     "8": ["o", "p"],
//     "9": ["q", "r"],
//     "10": ["s", "t"],
//     "11": ["u", "v"],
//     "12": ["w", "x"],
//     "13": ["y", "z"],
//   };
//
//   Map<String, dynamic> data = {};
//   User? user = FirebaseAuth.instance.currentUser;
//
//   CameraController? _controller;
//   List<CameraDescription>? _cameras;
//   bool _isCapturing = false;
//   Timer? _timer;
//   String _serverResponse = "Waiting for server response...";
//
//   Future<void> getData() async {
//     DocumentReference docRef = FirebaseFirestore.instance.collection("Users").doc(user!.uid);
//     DocumentSnapshot snapshot = await docRef.get();
//     if (snapshot.exists) {
//       dynamic fieldValue = snapshot.data();
//       if (fieldValue != null) {
//         setState(() {
//           data.addAll(fieldValue);
//         });
//         print(data);
//       }
//     }
//   }
//
//   Future<void> _initializeCamera([CameraLensDirection direction = CameraLensDirection.front]) async {
//     try {
//       _cameras = await availableCameras();
//       CameraDescription? selectedCamera = _cameras?.firstWhere(
//             (camera) => camera.lensDirection == direction,
//         orElse: () => _cameras!.first,
//       );
//
//       if (selectedCamera != null) {
//         _controller = CameraController(
//           selectedCamera,
//           ResolutionPreset.medium,
//         );
//
//         await _controller?.initialize();
//         await _controller?.setFocusMode(FocusMode.locked); // Lock focus for stability
//         setState(() {});
//
//         // Start capturing immediately after initialization
//         _startCapturing();
//       } else {
//         print('No cameras available');
//       }
//     } catch (e) {
//       print("Error initializing camera: $e");
//     }
//   }
//
//   void _startCapturing() {
//     if (_controller == null || !_controller!.value.isInitialized) {
//       print('Camera not initialized');
//       return;
//     }
//
//     setState(() {
//       _isCapturing = true;
//     });
//
//     _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
//       if (_controller == null || !_controller!.value.isInitialized) {
//         print('Camera not initialized or disposed');
//         return; // Prevent capturing if camera is not initialized or disposed
//       }
//
//       try {
//         final XFile image = await _controller!.takePicture(); // Capture the image
//         Uint8List imageBytes = await image.readAsBytes(); // Read the image bytes
//         await _sendImageToServer(imageBytes); // Send to the server
//       } catch (e) {
//         print("Error capturing image: $e");
//       }
//     });
//   }
//
//   Future<void> _sendImageToServer(Uint8List bytes) async {
//     try {
//       var uri = Uri.parse('http://192.168.114.34:5000/predict'); // Update with your server URL
//
//       var request = http.MultipartRequest('POST', uri)
//         ..files.add(http.MultipartFile.fromBytes(
//           'file',
//           bytes,
//           filename: 'frame.jpg',
//           contentType: MediaType('image', 'jpeg'),
//         ));
//
//       var response = await request.send();
//
//       if (response.statusCode == 200) {
//         String responseBody = await response.stream.bytesToString();
//         setState(() {
//           _serverResponse = responseBody;
//         });
//       } else {
//         print('Failed to get response from server: ${response.statusCode}');
//       }
//     } catch (e) {
//       print("Error sending image to server: $e");
//     }
//   }
//
//   void _stopCapturing() {
//     if (_timer != null && _timer!.isActive) {
//       _timer?.cancel();
//     }
//     _timer = null;
//     setState(() {
//       _isCapturing = false;
//     });
//   }
//
//   void _flipCamera() {
//     if (_cameras == null || _cameras!.length < 2) {
//       print('No secondary camera available');
//       return;
//     }
//
//     setState(() {
//       CameraLensDirection newDirection =
//       _controller?.description.lensDirection == CameraLensDirection.front
//           ? CameraLensDirection.back
//           : CameraLensDirection.front;
//       _initializeCamera(newDirection);
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this); // Add observer to listen to app lifecycle
//     getData();
//     _initializeCamera(); // Start with front camera
//   }
//
//   @override
//   void dispose() {
//     _stopCapturing();
//     _controller?.dispose();
//     _controller = null;
//     WidgetsBinding.instance.removeObserver(this); // Remove observer
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
//       // Stop camera and server calls when app is not active
//       _stopCapturing();
//       _controller?.dispose();
//       _controller = null;
//     } else if (state == AppLifecycleState.resumed) {
//       // Re-initialize the camera when the app is resumed
//       _initializeCamera();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(milliseconds: 500), () {
//       setState(() {
//         _width = percent * 300;
//       });
//     });
//     return Scaffold(
//       body: SingleChildScrollView(
//         child :
//         Container(
//           padding: EdgeInsets.all(20.0),
//           alignment: Alignment.center,
//           child: Column(
//             children: [
//               SizedBox(height: 20),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () async {
//                       _stopCapturing(); // Stop camera and server calls when navigating
//                       _controller?.dispose();
//                       _controller = null;
//                       await Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => AlphabetsPage(),
//                         ),
//                       );
//                     },
//                     icon: Icon(Icons.close, size: 30, weight: 50),
//                   ),
//                   Stack(
//                     children: [
//                       Container(
//                         width: 300,
//                         height: 20,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: Color(0xFFCFE2F3),
//                         ),
//                       ),
//                       AnimatedContainer(
//                         duration: const Duration(milliseconds: 800),
//                         width: _width,
//                         height: 20,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: themeColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Text(
//                 "Alphabet ${widget.current_alphabet}",
//                 style: TextStyle(
//                   fontFamily: "Cooper",
//                   fontWeight: FontWeight.w700,
//                   fontSize: 24,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 10),
//               Image.asset(
//                 "assets/alphabets/${widget.current_alphabet}.png",
//                 width: 100,
//                 height: 100,
//               ),
//               SizedBox(height: 10),
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: themeColor,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: _controller != null && _controller!.value.isInitialized
//                     ? Stack(
//                   children: [
//                     Transform(
//                       alignment: Alignment.center,
//                       transform: Matrix4.rotationY(
//                           _controller!.description.lensDirection == CameraLensDirection.front ? pi : 0), // Flip for front camera
//                       child: AspectRatio(
//                         aspectRatio: _controller!.value.aspectRatio,
//                         child: CameraPreview(_controller!),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 10,
//                       right: 10,
//                       child: ElevatedButton(
//                         onPressed: _flipCamera,
//                         style: ElevatedButton.styleFrom(
//                           shape: CircleBorder(),
//                           padding: EdgeInsets.all(10),
//                           backgroundColor: Colors.white,
//                         ),
//                         child: Icon(Icons.flip_camera_android, color: Colors.black),
//                       ),
//                     ),
//                   ],
//                 )
//                     : Icon(Icons.camera_alt, weight: 700, size: 40),
//               ),
//               SizedBox(height: 10),
//               OutlinedButton(
//                 onPressed: () {},
//                 child: Text(
//                   _serverResponse,
//                   style: TextStyle(
//                     fontFamily: "Cooper",
//                     fontWeight: FontWeight.w700,
//                     fontSize: 20,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   side: const BorderSide(color: darkThemeColor, width: 2),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 30),
//                 child: Text(
//                   "1. Ensure hand signs are clear and well-lit for accurate detection.\n2. Aim for an accuracy of over 80% to progress to the next test; adjust hand positioning or gestures as needed for improved results.",
//                   style: TextStyle(
//                     fontFamily: "Cooper",
//                     fontWeight: FontWeight.w700,
//                     fontSize: 16,
//                     color: CupertinoColors.inactiveGray,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               SizedBox(height: 50),
//               ElevatedButton(
//                 onPressed: flag
//                     ? () async {
//                   if (alphabets_map["${widget.current_level}"].indexOf(widget.current_alphabet) == 0) {
//                     data["learning_levels"]["${widget.current_level}"] = 1;
//                   } else {
//                     data["learning_levels"]["${widget.current_level}"] = 2;
//                     data["current_learning_level"] = widget.current_level + 1;
//                   }
//
//                   try {
//                     await FirebaseFirestore.instance.collection("Users").doc(user!.uid).update(data);
//                     print("done");
//                     _stopCapturing();
//                     _controller?.dispose();
//                     _controller = null;
//
//                     if (data["current_learning_level"] == 1) {
//                       await Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => AlphabetsLevelStartPage(
//                             current_level: widget.current_level,
//                           ),
//                         ),
//                       );
//                     } else {
//                       await Navigator.of(context).push(
//                         MaterialPageRoute(builder: (context) => AlphabetsPage()),
//                       );
//                     }
//                   } on Exception catch (e) {
//                     print("Error");
//                   }
//                 }
//                     : null,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: flag ? themeColor : Colors.grey,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   minimumSize: const Size(double.infinity, 50),
//                   shadowColor: yellowishOrange,
//                   elevation: 5,
//                 ),
//                 child: const Text(
//                   "Continue",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontFamily: "Cooper",
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }






// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shreya/AplhabetsLevelStartPage.dart';
// import 'AlphabetsLevelPage.dart';
// import 'colors.dart';
//
// class A_Q3_2 extends StatefulWidget {
//   final String current_alphabet;
//   final int current_level;
//   const A_Q3_2({Key? key, required this.current_alphabet, required this.current_level}) : super(key: key);
//   @override
//   State<A_Q3_2> createState() => A_Q3_2State();
// }
//
// class A_Q3_2State extends State<A_Q3_2> {
//   double _width = 300;
//   double percent = 1;
//   bool flag = true;
//   Map<String, dynamic> alphabets_map = {"1": ["a", "b"], "2": ["c", "d"], "3": ["e", "f"], "4": ["g", "h"], "5": ["i", "j"],
//     "6": ["k", "l"], "7": ["m", "n"], "8": ["o", "p"], "9": ["q", "r"], "10": ["s", "t"], "11": ["u", "v"], "12": ["w", "x"], "13": ["y", "z"],
//   };
//
//   Map<String, dynamic> data = {};
//   User? user = FirebaseAuth.instance.currentUser;
//
//   Future<void> getData() async {
//     DocumentReference docRef =
//     FirebaseFirestore.instance.collection("Users").doc(user!.uid);
//     DocumentSnapshot snapshot = await docRef.get();
//     if (snapshot.exists) {
//       dynamic fieldValue = snapshot.data();
//       if (fieldValue != null) {
//         setState(() {
//           data.addAll(fieldValue);
//         });
//         print(data);
//       }
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     getData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(const Duration(milliseconds: 500), () {
//       setState(() {
//         _width = percent * 300;
//       });
//     });
//     return Scaffold(
//       body :Container(
//         padding: EdgeInsets.all(20.0),
//         alignment: Alignment.center,
//         child: Column(
//           children: [
//             SizedBox(height : 20),
//             Row(
//               children: [
//                 IconButton(onPressed: () async {
//                   await Navigator.of(context).push(
//                     MaterialPageRoute(
//                         builder: (context) => AlphabetsPage(),
//                     ),
//                   );
//                 },
//                   icon: Icon(Icons.close, size: 30, weight: 50,),
//                 ),
//                 Stack(
//                   children: [
//                     Container(
//                       width: 300,
//                       height: 20,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(12),
//                           color: Color(0xFFCFE2F3)),
//                     ),
//                     AnimatedContainer(
//                         duration: const Duration(milliseconds: 800),
//                         width: _width,
//                         height: 20,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: themeColor)
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Text("Alphabet ${widget.current_alphabet}",
//               style: TextStyle(
//                 fontFamily: "Cooper",
//                 fontWeight: FontWeight.w700,
//                 fontSize: 24,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 10,),
//             Image.asset(
//                 "assets/alphabets/${widget.current_alphabet}.png", width: 150, height: 150,
//             ),
//             SizedBox(height: 10,),
//             Container(
//               width: 220,
//               height: 170,
//               decoration: BoxDecoration(
//                 color: themeColor,
//               ),
//               child: Icon(Icons.camera_alt, weight: 700, size: 40,),
//             ),
//             SizedBox(height: 10,),
//             OutlinedButton(onPressed: (){}, child:
//             Text(
//               "xx%",
//               style: TextStyle(fontFamily: "Cooper", fontWeight: FontWeight.w700, fontSize: 20),
//               textAlign: TextAlign.center,
//             ),
//               style: ElevatedButton.styleFrom(
//                 side: const BorderSide(color: darkThemeColor, width: 2),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//                 // textStyle: TextStyle(fontSize: 14),
//               ),
//             ),
//             SizedBox(height: 20,),
//             Padding(padding: EdgeInsets.symmetric(horizontal: 30),
//               child :
//               Text("1. Ensure hand signs are clear and well-lit for accurate detection.\n2. Aim for an accuracy of over 80% to progress to the next test; adjust hand positioning or gestures as needed for improved results.",
//                 style: TextStyle(
//                   fontFamily: "Cooper",
//                   fontWeight: FontWeight.w700,
//                   fontSize: 16,
//                   color: CupertinoColors.inactiveGray,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(height: 50,),
//             ElevatedButton(onPressed: flag
//                 ? () async {
//
//               if(alphabets_map["${widget.current_level}"].indexOf(widget.current_alphabet) == 0) {
//                 data["learning_levels"]["${widget.current_level}"] = 1;
//               }
//               else{
//                 data["learning_levels"]["${widget.current_level}"] = 2;
//                 data["current_learning_level"] = widget.current_level + 1;
//               }
//
//               try {
//                 await FirebaseFirestore.instance
//                     .collection("Users")
//                     .doc(user!.uid)
//                     .update(data);
//                 print("done");
//
//                 if (data["current_learning_level"] == 1) {
//                   await Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) =>
//                           AlphabetsLevelStartPage(current_level: widget
//                               .current_level,),
//                     ),
//                   );
//                 }
//                 else{
//                   await Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => AlphabetsPage()
//                     ),
//                   );
//                 }
//               }
//               on Exception catch (e){
//                 print("Error");
//               }
//             }
//                 : null,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: flag ? themeColor : Colors.grey,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 minimumSize: const Size(double.infinity, 50),
//                 // textStyle: TextStyle(fontSize: 14),
//                 shadowColor: yellowishOrange,
//                 elevation: 5,
//               ),
//               child: const Text("Continue",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontFamily: "Cooper",
//                   fontStyle: FontStyle.normal,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }