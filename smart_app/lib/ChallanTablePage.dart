// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
//
// class ChallanTablePage extends StatefulWidget {
//   // var dataArray;
//   // final List<Map<String, dynamic>> dataArray;
//
//   // // Constructor to receive the array
//   // ChallanTablePage({required this.dataArray});
//
//   List<Map<String, dynamic>> dataArray;
//
//   ChallanTablePage({required this.dataArray});
//
//   @override
//   _ChallanTablePageState createState() => _ChallanTablePageState();
// }
//
// class _ChallanTablePageState extends State<ChallanTablePage> {
//   // final List<YourObjectType> dataArray;
//
//   // // Constructor to receive the array
//   // ChallanTablePage({required this.dataArray});
//
//   // final List<Map<String, dynamic>> dataArray;
//
//   // // Constructor to receive the array
//   // ChallanTablePage({required this.dataArray});
//
//   List<String> imageList = [
//     'myimg1.png',
//     'myimg2.png'
//   ]; // Replace with your image paths
//   List<TextEditingController> textControllers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize text controllers for each image
//     textControllers = List.generate(
//         widget.dataArray.length,
//         (index) => TextEditingController(
//             text: widget.dataArray[index]['text'] ?? 'rohi'));
//     // text: 'rohi'));
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
//             for (int i = 0; i < widget.dataArray.length; i++)
//               TableRow(
//                 children: [
//                   TableCell(
//                       child: Image.network(
//                     // 'assets/images/${imageList[i]}',
//                     widget.dataArray[i]["url"],
//                     width: 100,
//                     height: 100,
//                   )),
//                   TableCell(
//                       child: TextFormField(
//                     controller: textControllers[i],
//                     textAlign: TextAlign.center,
//                   )),
//                   TableCell(
//                     child: Column(
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
//                               widget.dataArray.removeAt(i);
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
// ------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:smart_app/UserChallan.dart';
// import 'package:smart_app/crude_operation.dart';
//
// class ChallanTablePage extends StatefulWidget {
//   final List<Map<String, dynamic>> dataArray;
//
//   ChallanTablePage({required this.dataArray});
//
//   @override
//   _ChallanTablePageState createState() => _ChallanTablePageState();
// }
//
// class _ChallanTablePageState extends State<ChallanTablePage> {
//   List<TextEditingController> textControllers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize text controllers for each image
//     textControllers = List.generate(
//       widget.dataArray.length,
//       (index) => TextEditingController(
//         text: widget.dataArray[index]['text'] ?? 'rohi',
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Vehicle Number Plates"),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
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
//             for (int i = 0; i < widget.dataArray.length; i++)
//               TableRow(
//                 children: [
//                   TableCell(
//                     child: Image.network(
//                       widget.dataArray[i]["url"],
//                       width: 100,
//                       height: 100,
//                     ),
//                   ),
//                   TableCell(
//                     child: TextFormField(
//                       controller: textControllers[i],
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   TableCell(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             // Save button logic here (e.g., update details)
//                             setState(() {
//                               widget.dataArray[i]['text'] =
//                                   textControllers[i].text;
//                             });
//                             print('Details Saved for Image $i');
//                           },
//                           child: Text('Save'),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Delete button logic here (e.g., remove image and details)
//                             setState(() {
//                               widget.dataArray.removeAt(i);
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
//             TableRow(
//               children: [
//                 TableCell(child: Container()), // Empty cell for spacing
//                 TableCell(child: Container()), // Empty cell for spacing
//                 TableCell(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Submit button logic here (e.g., send updated array)
//                       print(
//                           'Updated Array Submitted ${widget.dataArray.length}');
//
//                       // Call a function or send data to FineTable.dart file
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               // UserChallan(dataArray: widget.dataArray),
//                               CRUDEoperation(dataArray: widget.dataArray),
//                         ),
//                       );
//                     },
//                     child: Text('Submit'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// -------------------------------------------------
import 'package:flutter/material.dart';
import 'package:smart_app/UserChallan.dart';
import 'package:smart_app/crude_operation.dart';

class ChallanTablePage extends StatefulWidget {
  final List<Map<String, dynamic>> dataArray;

  ChallanTablePage({required this.dataArray});

  @override
  _ChallanTablePageState createState() => _ChallanTablePageState();
}

class _ChallanTablePageState extends State<ChallanTablePage> {
  List<TextEditingController> textControllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize text controllers for each image
    textControllers = List.generate(
      widget.dataArray.length,
      (index) => TextEditingController(
        text: widget.dataArray[index]['text'] ?? 'rohi',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Vehicle Number Plates"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
            columnWidths: {
              0: FlexColumnWidth(1), // Shrink the first column
              1: FlexColumnWidth(2), // Shrink the second column
              2: FlexColumnWidth(1), // Shrink the third column
            },
            border: TableBorder.all(),
            children: [
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                ),
                children: [
                  TableCell(
                    child: Center(
                      child: Text(
                        'Image',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        'Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Center(
                      child: Text(
                        'Actions',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              for (int i = 0; i < widget.dataArray.length; i++)
                TableRow(
                  children: [
                    TableCell(
                      child: Image.network(
                        widget.dataArray[i]["url"],
                        width: 100,
                        height: 100,
                      ),
                    ),
                    TableCell(
                      child: TextFormField(
                        controller: textControllers[i],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    TableCell(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Save button logic here (e.g., update details)
                              setState(() {
                                widget.dataArray[i]['text'] =
                                    textControllers[i].text;
                              });
                              print('Details Saved for Image $i');
                            },
                            child: Text('Save'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Delete button logic here (e.g., remove image and details)
                              setState(() {
                                widget.dataArray.removeAt(i);
                                textControllers.removeAt(i);
                              });
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                // Submit button logic here (e.g., send updated array)
                print('Updated Array Submitted ${widget.dataArray.length}');

                // Call a function or send data to FineTable.dart file
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        // UserChallan(dataArray: widget.dataArray),
                        CRUDEoperation(dataArray: widget.dataArray),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
