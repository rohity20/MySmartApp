// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
// -------------------------------------------------------------------------------------------------------------

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   File? _image;

//   Future<void> _getImage() async {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       }
//     });
//   }

//   void _deleteImage() {
//     setState(() {
//       _image = null;
//     });
//   }

//   // ------------------------------------------
//   // final url = "https://jsonplaceholder.typicode.com/posts";
//   final url = "https://a506-103-230-149-57.ngrok-free.app/images";
//   var _postJson = [];

//   // void fetchPosts() async {
//   //   try {
//   //     final response = await get(Uri.parse(url));
//   //     final jsonData = jsonDecode(response.body) as List;

//   //     setState(() {
//   //       _postJson = jsonData;
//   //     });
//   //   } catch (err) {}
//   // }

//   void fetchPosts() async {
//     try {
//       final response = await get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body) as List;
//         setState(() {
//           _postJson = jsonData;
//         });
//       } else {
//         print("Error: ${response.statusCode}");
//       }
//     } catch (err) {
//       print("Error: $err");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchPosts();
//   }

//   // final post = _postJson[0];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Image Upload & Display"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _image == null
//                 ? Text("No Image Selected")
//                 : Container(
//                     height: 200, // Set your desired fixed height
//                     child: Image.file(_image!),
//                   ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _getImage,
//               child: Text("Upload Image"),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _deleteImage,
//               child: Text("Delete Image"),
//             ),
//             SizedBox(height: 20),
//             Text("Title: ${_postJson.length}\n"),
//             Text("Title: ${_postJson[0]["title"]}\n"),
//             // SizedBox(height: 20),
//             // ListView.builder(
//             //     itemCount: _postJson.length,
//             //     itemBuilder: (context, i) {
//             //       final post = _postJson[i];
//             //       return Text("Title: ${post["title"]}\n");
//             //     })
//           ],
//         ),
//       ),
//     );
//   }
// }

// -------------------------------------------------------------------------------------------------------------

import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:smart_app/ChallanTablePage.dart';

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
  File? selectedImage;
  // String? message = "";
  var message = [];
  final List<Map<String, dynamic>> mymessage = [];
  // [
  //   {"urll": "urrll", "text": "11111"},
  //   {"urll": "mslkjk", "text": "222222"}
  // ];

  final List<String> imageList = ['myimg1.png', 'myimg2.png'];

  Future getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(pickedImage!.path);

    // message = "";
    message = [];
    mymessage.clear();

    setState(() {});
  }

  uploadImage() async {
    final request = http.MultipartRequest(
        "POST",
        Uri.parse(
            "https://d408-103-197-221-179.ngrok-free.app/process_images"));

    final headers = {"Contect-type": "multipart/form-data"};

    request.files.add(http.MultipartFile('image',
        selectedImage!.readAsBytes().asStream(), selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));

    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    // message = resJson['message'];
    // message = resJson;\

    // mymessage = List<Map<String, dynamic>>.from(resJson);
    // setState(() {});

    // Clear the mymessage list
    mymessage.clear();

    // Populate the mymessage list with the new data
    mymessage.addAll(List<Map<String, dynamic>>.from(resJson));
    // mymessage = List<Map<String, dynamic>>.from(resJson);
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
            selectedImage == null
                ? Text("Please pick a Image to upload")
                : Image.file(selectedImage!),
            TextButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: uploadImage,
              icon: Icon(Icons.upload_file, color: Colors.white),
              label: Text("Upload",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            SizedBox(height: 20),
            Text("Text: ${mymessage.length}\n"),
            TextButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: () {
                // Navigate to the ChallanTablePage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ChallanTablePage(dataArray: mymessage),
                  ),
                );
              },
              icon: Icon(Icons.receipt, color: Colors.white),
              label: Text("Generate Challan",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),

            // Expanded(
            //   // child: ListView.builder(
            //   //   itemCount: imageList.length, // Replace with your image count
            //   //   itemBuilder: (context, index) {
            //   //     return Image.asset(
            //   //       'assets/images/${imageList[index]}', // Replace with your actual path
            //   //       width: 150,
            //   //       height: 150,
            //   //     );
            //
            //   //   },
            //   // ),
            //
            //   child: ListView.builder(
            //     itemCount: message.length, // Replace with your image count
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text(message[index].text),
            //       );
            //     },
            //   ),
            //
            //   //   child: Column(
            //   // children: imageList
            //   //     .map((path) => Image.file(File(
            //   //         "H:/_Major-Project/ocr/number-plate-recognition/images/${path}")))
            //   //     .toList(),
            // )
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}




//
// class ChallanTablePage extends StatelessWidget {
//   // @override
//   // Widget build(BuildContext context) {
//   //   // Build your table UI here
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text("Challan Table"),
//   //     ),
//   //     body: Center(
//   //       child: Table(
//   //         border: TableBorder.all(),
//   //         children: [
//   //           TableRow(
//   //             children: [
//   //               TableCell(child: Text('Header 1')),
//   //               TableCell(child: Text('Header 2')),
//   //             ],
//   //           ),
//   //           TableRow(
//   //             children: [
//   //               TableCell(child: Text('Data 1')),
//   //               TableCell(child: Text('Data 2')),
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//   List<String> imageList = ['image1.png', 'image2.png']; // Replace with your image paths
//   List<TextEditingController> textControllers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize text controllers for each image
//     textControllers = List.generate(imageList.length, (index) => TextEditingController());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Challan Table"),
//       ),
//       body: Center(
//         child: Table(
//           border: TableBorder.all(),
//           children: [
//             TableRow(
//               children: [
//                 TableCell(child: Text('Image')),
//                 TableCell(child: Text('Details')),
//                 TableCell(child: Text('Actions')),
//               ],
//             ),
//             for (int i = 0; i < imageList.length; i++)
//               TableRow(
//                 children: [
//                   TableCell(child: Image.asset('assets/images/${imageList[i]}')),
//                   TableCell(child: TextFormField(controller: textControllers[i])),
//                   TableCell(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             // Add button logic here (e.g., save details)
//                             print('Details Saved for Image $i');
//                           },
//                           child: Text('Save'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Delete button logic here (e.g., remove image and corresponding details)
//                             setState(() {
//                               imageList.removeAt(i);
//                               textControllers.removeAt(i);
//                             });
//                           },
//                           child: Text('Delete'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
