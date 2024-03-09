import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:smart_app/ChallanTablePage.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<File?> selectedImages = [];
  var message = [];
  final List<Map<String, dynamic>> mymessage = [];

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

    setState(() {});
  }

  Future getVideos() async {
    selectedImages = [];
    final video = await picker.pickVideo(source: ImageSource.gallery);
    _video = File(video!.path);
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.play();
      });
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
        Uri.parse("https://262c-103-230-149-33.ngrok-free.app/process_images"),
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
        mymessage.addAll(List<Map<String, dynamic>>.from(jsonDecode(resJson.body)));
        print("Response: $resJson");
      } else {
        // Handle error
        print("Error: ${response.reasonPhrase}");
      }
    } catch (error) {
      // Handle exception
      print("Error: $error");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Traffic App"),
        backgroundColor: Colors.blue,
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
                 aspectRatio: _videoPlayerController.value.aspectRatio,
                 child: VideoPlayer(_videoPlayerController),
               )
                   : Container(
                 child: Text("Video Initialization Error"),
               )
                   : Text("Please pick Images/Videos  to  upload")
               )

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

