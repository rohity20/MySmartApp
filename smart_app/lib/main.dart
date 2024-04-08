import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:smart_app/ChallanHistory.dart';
import 'package:smart_app/ChallanTablePage.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_app/crude_operation.dart';

// ===================================
import 'package:smart_app/views/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'consts/consts.dart';
// ===================================

// void main() {
//   runApp(MyApp());
// }

Future<void> main() async {
  // Connets your flutter project with firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // we are using getX so we have to change this material app into getmaterialapp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            //to set app bar icons color
            iconTheme: IconThemeData(color: darkFontGrey),
            backgroundColor: Colors.transparent),
        fontFamily: regular,
      ),
      home: const SplashScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    // Home(),
    MyHomePage(),
    HistoryPage(),
    InboxPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     // title: Text('Bottom Navbar Demo'),
      //     ),
      appBar: AppBar(
        title: Text("Smart Traffic App"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.inbox_outlined),
            label: 'Inbox',
          ),

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.login),
          //   label: 'Sign In',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       // child: Text('Home Page'),
//       child: MyHomePage(),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<File?> selectedImages = [];
  List<File?> selectedVideos = [];
  var imgvid = 0;

  var message = [];
  final List<Map<String, dynamic>> mymessage = [
    {
      "url":
          'https://firebasestorage.googleapis.com/v0/b/myocr-2c1cd.appspot.com/o/RJ14VJ1331.png?alt=media&token=fee21e38-746d-4700-8f0b-ccdbd02cca40',
      "text": 'RJ14VJ1331'
    }
  ];

  late VideoPlayerController _videoPlayerController;
  late File _video;
  final picker = ImagePicker();

  Future getImages() async {
    final pickedImages = await ImagePicker().pickMultiImage();
    selectedImages =
        pickedImages?.map((pickedImage) => File(pickedImage!.path)).toList() ??
            [];

    message = [];
    mymessage.clear();
    imgvid = 1;

    setState(() {});
  }

  Future getVideos() async {
    selectedImages = [];
    final video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      _video = File(video!.path);
      _videoPlayerController = VideoPlayerController.file(_video)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController.play();
        });
      imgvid = 2;
      selectedVideos.add(_video);
    }
  }

  @override
  void initState() {
    super.initState();
    _video = File(
        ''); // Initialize with a default value or leave it empty depending on your use case.
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
  }

  // uploadImages() async {
  //   final request = http.MultipartRequest(
  //     "POST",
  //     Uri.parse("https://262c-103-230-149-33.ngrok-free.app/upload"),
  //   );
  //
  //   final headers = {"Content-type": "multipart/form-data"};
  //
  //   for (File? image in selectedImages) {
  //     request.files.add(http.MultipartFile(
  //       'images',
  //       image!.readAsBytes().asStream(),
  //       image.lengthSync(),
  //       filename: image.path.split("/").last,
  //     ));
  //   }
  //
  //   request.headers.addAll(headers);
  //   final response = await request.send();
  //   http.Response res = await http.Response.fromStream(response);
  //   final resJson = jsonDecode(res.body);
  //
  //   mymessage.clear();
  //   mymessage.addAll(List<Map<String, dynamic>>.from(resJson));
  // }

  uploadImages() async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://5653-2409-4080-121b-e953-1488-b82b-6f10-90e4.ngrok-free.app/process_images"),
      );

      final headers = {"Content-type": "multipart/form-data"};

      for (File? image in selectedImages) {
        request.files.add(http.MultipartFile(
          'images',
          image!.readAsBytes().asStream(),
          image.lengthSync(),
          filename: image.path.split("/").last,
        ));
      }

      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        // Upload successful
        final resJson = await http.Response.fromStream(response);
        mymessage.clear();
        mymessage
            .addAll(List<Map<String, dynamic>>.from(jsonDecode(resJson.body)));
        print("Response: $resJson");
      } else {
        // Handle error
        print("Error: ${response.reasonPhrase}");
      }
    } catch (error) {
      // Handle exception
      print("Error: $error");
    }
    imgvid = 0;
  }

  // uploadVideos() async {
  //   try {
  //     final request = http.MultipartRequest(
  //       "POST",
  //       Uri.parse("https://1c6b-103-230-149-33.ngrok-free.app/upload_videos"), // Update URL
  //     );
  //
  //     final headers = {"Content-type": "multipart/form-data"};
  //
  //     for (File? video in selectedVideos) {
  //       request.files.add(http.MultipartFile(
  //         'videos', // Update field name to 'videos'
  //         video!.readAsBytes().asStream(),
  //         video.lengthSync(),
  //         filename: video.path.split("/").last,
  //       ));
  //     }
  //
  //     request.headers.addAll(headers);
  //
  //     final response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       // Upload successful
  //       final resJson = await http.Response.fromStream(response);
  //       mymessage.clear();
  //       mymessage.addAll(List<Map<String, dynamic>>.from(jsonDecode(resJson.body)));
  //       print("Response: $resJson");
  //     } else {
  //       // Handle error
  //       print("Error: ${response.reasonPhrase}");
  //     }
  //   } catch (error) {
  //     // Handle exception
  //     print("Error: $error");
  //   }
  // }

  uploadVideos() async {
    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://5653-2409-4080-121b-e953-1488-b82b-6f10-90e4.ngrok-free.app/upload_videos"), // Update URL
      );

      final headers = {"Content-type": "multipart/form-data"};

      for (File? video in selectedVideos) {
        request.files.add(http.MultipartFile(
          'videos', // Update field name to 'videos'
          video!.readAsBytes().asStream(),
          video.lengthSync(),
          filename: video.path.split("/").last,
        ));
      }

      request.headers.addAll(headers);

      final response = await request.send();

      if (response.statusCode == 200) {
        // Upload successful
        final resString =
            await response.stream.bytesToString(); // Convert response to String
        final resJson = jsonDecode(resString);
        mymessage.clear();
        mymessage.addAll(List<Map<String, dynamic>>.from(resJson));
        print("Response: $resString"); // Print the response as a String
      } else {
        // Handle error
        print("Error: ${response.reasonPhrase}");
      }
    } catch (error) {
      // Handle exception
      print("Error: $error");
    }
    imgvid = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text("Smart Traffic App"),
          // backgroundColor: Colors.blue,
          // centerTitle: true,
          ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            selectedImages.isEmpty
                ?
                // Text("Please pick Images/Videos to upload")
                (_video != null
                    ? _videoPlayerController.value.isInitialized
                        ? AspectRatio(
                            aspectRatio:
                                _videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(_videoPlayerController),
                          )
                        : Container(
                            child: Text("Video Initialization Error"),
                          )
                    : Text("Please pick Images/Videos  to  upload"))
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: selectedImages
                          .map((image) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit
                                      .fill, // Ensure same width and height
                                  width: 150, // Set the desired width
                                  height: 150, // Set the desired height
                                ),
                              ))
                          .toList(),
                    ),
                  ),

            // (_video != null
            // ? _videoPlayerController.value.isInitialized
            //     ? AspectRatio(
            //         aspectRatio: _videoPlayerController.value.aspectRatio,
            //         child: VideoPlayer(_videoPlayerController),
            //       )
            //     : Container(
            //         child: Text("Video Initialization Error"),
            //       )
            // : Text("Please pick Images/Videos to upload")),

            TextButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              // onPressed: imgvid==1?uploadImages: uploadVideos,
              onPressed: uploadImages,
              icon: Icon(Icons.upload_file, color: Colors.white),
              label: Text(
                "Upload",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text("Total Detections: ${mymessage.length}\n"),
            TextButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChallanTablePage(dataArray: mymessage),
                  ),
                );
              },
              icon: Icon(Icons.receipt, color: Colors.white),
              label: Text(
                "Generate Challan",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              50.0, 16.0, 25.0, 32.0), // Adjust as needed
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Adjust to your preference
            children: [
              SizedBox(
                width: 100.0, // Adjust the width
                height: 70.0, // Adjust the height
                child: FloatingActionButton(
                  onPressed: getImages,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo),
                      Text("Images"),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 100.0, // Adjust the width
                height: 70.0, // Adjust the height
                child: FloatingActionButton(
                  onPressed: getVideos,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.video_library),
                      Text("Videos"),
                    ],
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

class InboxPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Inbox Page'),
    );
  }
}

// class SignInPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('Sign In Page'),
//     );
//   }
// }

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      // child: Text('History Page'),
      child: ChallanHistory(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Page'),
    );
  }
}

// ==========================================================================================


// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   List<File?> selectedImages = [];
//   List<File?> selectedVideos = [];
//   var imgvid = 0;

//   var message = [];
//   final List<Map<String, dynamic>> mymessage = [
//     {
//       "url":
//           'https://firebasestorage.googleapis.com/v0/b/myocr-2c1cd.appspot.com/o/RJ14VJ1331.png?alt=media&token=fee21e38-746d-4700-8f0b-ccdbd02cca40',
//       "text": 'RJ14VJ1331'
//     }
//   ];

//   late VideoPlayerController _videoPlayerController;
//   late File _video;
//   final picker = ImagePicker();

//   Future getImages() async {
//     final pickedImages = await ImagePicker().pickMultiImage();
//     selectedImages =
//         pickedImages?.map((pickedImage) => File(pickedImage!.path)).toList() ??
//             [];

//     message = [];
//     mymessage.clear();
//     imgvid = 1;

//     setState(() {});
//   }

//   Future getVideos() async {
//     selectedImages = [];
//     final video = await picker.pickVideo(source: ImageSource.gallery);
//     if (video != null) {
//       _video = File(video!.path);
//       _videoPlayerController = VideoPlayerController.file(_video)
//         ..initialize().then((_) {
//           setState(() {});
//           _videoPlayerController.play();
//         });
//       imgvid = 2;
//       selectedVideos.add(_video);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _video = File(
//         ''); // Initialize with a default value or leave it empty depending on your use case.
//     _videoPlayerController = VideoPlayerController.file(_video)
//       ..initialize().then((_) {
//         setState(() {});
//         _videoPlayerController.play();
//       });
//   }

//   // uploadImages() async {
//   //   final request = http.MultipartRequest(
//   //     "POST",
//   //     Uri.parse("https://262c-103-230-149-33.ngrok-free.app/upload"),
//   //   );
//   //
//   //   final headers = {"Content-type": "multipart/form-data"};
//   //
//   //   for (File? image in selectedImages) {
//   //     request.files.add(http.MultipartFile(
//   //       'images',
//   //       image!.readAsBytes().asStream(),
//   //       image.lengthSync(),
//   //       filename: image.path.split("/").last,
//   //     ));
//   //   }
//   //
//   //   request.headers.addAll(headers);
//   //   final response = await request.send();
//   //   http.Response res = await http.Response.fromStream(response);
//   //   final resJson = jsonDecode(res.body);
//   //
//   //   mymessage.clear();
//   //   mymessage.addAll(List<Map<String, dynamic>>.from(resJson));
//   // }

//   uploadImages() async {
//     try {
//       final request = http.MultipartRequest(
//         "POST",
//         Uri.parse(
//             "https://5653-2409-4080-121b-e953-1488-b82b-6f10-90e4.ngrok-free.app/process_images"),
//       );

//       final headers = {"Content-type": "multipart/form-data"};

//       for (File? image in selectedImages) {
//         request.files.add(http.MultipartFile(
//           'images',
//           image!.readAsBytes().asStream(),
//           image.lengthSync(),
//           filename: image.path.split("/").last,
//         ));
//       }

//       request.headers.addAll(headers);

//       final response = await request.send();

//       if (response.statusCode == 200) {
//         // Upload successful
//         final resJson = await http.Response.fromStream(response);
//         mymessage.clear();
//         mymessage
//             .addAll(List<Map<String, dynamic>>.from(jsonDecode(resJson.body)));
//         print("Response: $resJson");
//       } else {
//         // Handle error
//         print("Error: ${response.reasonPhrase}");
//       }
//     } catch (error) {
//       // Handle exception
//       print("Error: $error");
//     }
//     imgvid = 0;
//   }

//   // uploadVideos() async {
//   //   try {
//   //     final request = http.MultipartRequest(
//   //       "POST",
//   //       Uri.parse("https://1c6b-103-230-149-33.ngrok-free.app/upload_videos"), // Update URL
//   //     );
//   //
//   //     final headers = {"Content-type": "multipart/form-data"};
//   //
//   //     for (File? video in selectedVideos) {
//   //       request.files.add(http.MultipartFile(
//   //         'videos', // Update field name to 'videos'
//   //         video!.readAsBytes().asStream(),
//   //         video.lengthSync(),
//   //         filename: video.path.split("/").last,
//   //       ));
//   //     }
//   //
//   //     request.headers.addAll(headers);
//   //
//   //     final response = await request.send();
//   //
//   //     if (response.statusCode == 200) {
//   //       // Upload successful
//   //       final resJson = await http.Response.fromStream(response);
//   //       mymessage.clear();
//   //       mymessage.addAll(List<Map<String, dynamic>>.from(jsonDecode(resJson.body)));
//   //       print("Response: $resJson");
//   //     } else {
//   //       // Handle error
//   //       print("Error: ${response.reasonPhrase}");
//   //     }
//   //   } catch (error) {
//   //     // Handle exception
//   //     print("Error: $error");
//   //   }
//   // }

//   uploadVideos() async {
//     try {
//       final request = http.MultipartRequest(
//         "POST",
//         Uri.parse(
//             "https://5653-2409-4080-121b-e953-1488-b82b-6f10-90e4.ngrok-free.app/upload_videos"), // Update URL
//       );

//       final headers = {"Content-type": "multipart/form-data"};

//       for (File? video in selectedVideos) {
//         request.files.add(http.MultipartFile(
//           'videos', // Update field name to 'videos'
//           video!.readAsBytes().asStream(),
//           video.lengthSync(),
//           filename: video.path.split("/").last,
//         ));
//       }

//       request.headers.addAll(headers);

//       final response = await request.send();

//       if (response.statusCode == 200) {
//         // Upload successful
//         final resString =
//             await response.stream.bytesToString(); // Convert response to String
//         final resJson = jsonDecode(resString);
//         mymessage.clear();
//         mymessage.addAll(List<Map<String, dynamic>>.from(resJson));
//         print("Response: $resString"); // Print the response as a String
//       } else {
//         // Handle error
//         print("Error: ${response.reasonPhrase}");
//       }
//     } catch (error) {
//       // Handle exception
//       print("Error: $error");
//     }
//     imgvid = 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Smart Traffic App"),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             selectedImages.isEmpty
//                 ?
//                 // Text("Please pick Images/Videos to upload")
//                 (_video != null
//                     ? _videoPlayerController.value.isInitialized
//                         ? AspectRatio(
//                             aspectRatio:
//                                 _videoPlayerController.value.aspectRatio,
//                             child: VideoPlayer(_videoPlayerController),
//                           )
//                         : Container(
//                             child: Text("Video Initialization Error"),
//                           )
//                     : Text("Please pick Images/Videos  to  upload"))
//                 : SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       children: selectedImages
//                           .map((image) => Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Image.file(
//                                   image!,
//                                   fit: BoxFit
//                                       .fill, // Ensure same width and height
//                                   width: 150, // Set the desired width
//                                   height: 150, // Set the desired height
//                                 ),
//                               ))
//                           .toList(),
//                     ),
//                   ),

//             // (_video != null
//             // ? _videoPlayerController.value.isInitialized
//             //     ? AspectRatio(
//             //         aspectRatio: _videoPlayerController.value.aspectRatio,
//             //         child: VideoPlayer(_videoPlayerController),
//             //       )
//             //     : Container(
//             //         child: Text("Video Initialization Error"),
//             //       )
//             // : Text("Please pick Images/Videos to upload")),

//             TextButton.icon(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.blue),
//               ),
//               // onPressed: imgvid==1?uploadImages: uploadVideos,
//               onPressed: uploadImages,
//               icon: Icon(Icons.upload_file, color: Colors.white),
//               label: Text(
//                 "Upload",
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Text("Total Detections: ${mymessage.length}\n"),
//             TextButton.icon(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.blue),
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         ChallanTablePage(dataArray: mymessage),
//                   ),
//                 );
//               },
//               icon: Icon(Icons.receipt, color: Colors.white),
//               label: Text(
//                 "Generate Challan",
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: Align(
//         alignment: Alignment.bottomLeft,
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(
//               50.0, 16.0, 25.0, 32.0), // Adjust as needed
//           child: Row(
//             mainAxisAlignment:
//                 MainAxisAlignment.spaceBetween, // Adjust to your preference
//             children: [
//               SizedBox(
//                 width: 100.0, // Adjust the width
//                 height: 70.0, // Adjust the height
//                 child: FloatingActionButton(
//                   onPressed: getImages,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.add_a_photo),
//                       Text("Images"),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 100.0, // Adjust the width
//                 height: 70.0, // Adjust the height
//                 child: FloatingActionButton(
//                   onPressed: getVideos,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.video_library),
//                       Text("Videos"),
//                     ],
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






// ========================================================================================

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_app/screens/fetch_data.dart';
// import 'package:smart_app/screens/insert_data.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Firebase'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             const Image(
//               width: 300,
//               height: 300,
//               image: NetworkImage(
//                   'https://seeklogo.com/images/F/firebase-logo-402F407EE0-seeklogo.com.png'),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             const Text(
//               'Firebase Realtime Database Series in Flutter 2022',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w500,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             MaterialButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const InsertData()));
//               },
//               child: const Text('Insert Data'),
//               color: Colors.blue,
//               textColor: Colors.white,
//               minWidth: 300,
//               height: 40,
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             MaterialButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const FetchData()));
//               },
//               child: const Text('Fetch Data'),
//               color: Colors.blue,
//               textColor: Colors.white,
//               minWidth: 300,
//               height: 40,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





// ==================================================================================

// import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_display/TO%20DO/todo_list.dart';

// import 'package:flutter/material.dart';
// import 'package:smart_app/crude_operation.dart';

// Future<void> main() async {
//   // Connets your flutter project with firebase
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CRUDEoperation(),
//     );
//   }
// }
