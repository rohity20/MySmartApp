import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ChallanTablePage extends StatefulWidget {
  @override
  _ChallanTablePageState createState() => _ChallanTablePageState();
}

class _ChallanTablePageState extends State<ChallanTablePage> {
  List<String> imageList = ['image1.png', 'image2.png']; // Replace with your image paths
  List<TextEditingController> textControllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize text controllers for each image
    textControllers = List.generate(imageList.length, (index) => TextEditingController());
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
            for (int i = 0; i < imageList.length; i++)
              TableRow(
                children: [
                  TableCell(child: Image.asset('assets/images/${imageList[i]}',
                              width: 10,
                              height: 10,
                       )),
                  TableCell(child: TextFormField(controller: textControllers[i])),
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
