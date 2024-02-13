import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ChallanTablePage extends StatefulWidget {
  // var dataArray;
  // final List<Map<String, dynamic>> dataArray;

  // // Constructor to receive the array
  // ChallanTablePage({required this.dataArray});

  List<Map<String, dynamic>> dataArray;

  ChallanTablePage({required this.dataArray});

  @override
  _ChallanTablePageState createState() => _ChallanTablePageState();
}

class _ChallanTablePageState extends State<ChallanTablePage> {
  // final List<YourObjectType> dataArray;

  // // Constructor to receive the array
  // ChallanTablePage({required this.dataArray});

  // final List<Map<String, dynamic>> dataArray;

  // // Constructor to receive the array
  // ChallanTablePage({required this.dataArray});

  List<String> imageList = [
    'myimg1.png',
    'myimg2.png'
  ]; // Replace with your image paths
  List<TextEditingController> textControllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize text controllers for each image
    textControllers = List.generate(
        widget.dataArray.length,
        (index) => TextEditingController(
            text: widget.dataArray[index]['text'] ?? 'rohi'));
    // text: 'rohi'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Challan Table"),
      ),
      body: Center(
        child: Table(
          border: TableBorder.all(),
          children: [
            TableRow(
              children: [
                TableCell(child: Text('Image')),
                TableCell(child: Text('Details')),
                TableCell(child: Text('Actions')),
              ],
            ),
            for (int i = 0; i < widget.dataArray.length; i++)
              TableRow(
                children: [
                  TableCell(
                      child: Image.network(
                    // 'assets/images/${imageList[i]}',
                    widget.dataArray[i]["url"],
                    width: 100,
                    height: 100,
                  )),
                  TableCell(
                      child: TextFormField(
                    controller: textControllers[i],
                    textAlign: TextAlign.center,
                  )),
                  TableCell(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add button logic here (e.g., save details)
                            print('Details Saved for Image $i');
                          },
                          child: Text('Save'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Delete button logic here (e.g., remove image and corresponding details)
                            setState(() {
                              imageList.removeAt(i);
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
      ),
    );
  }
}
