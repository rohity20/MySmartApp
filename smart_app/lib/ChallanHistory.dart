import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChallanHistory extends StatefulWidget {
  const ChallanHistory({super.key});
  // final List<dynamic>? dataArray;
  // const ChallanHistory({Key? key, this.dataArray}) : super(key: key);

  @override
  State<ChallanHistory> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ChallanHistory> {
  // List<TextEditingController> textControllers = [];

  // final List<dynamic>? dataArray;

  // _MyWidgetState({this.dataArray});

  //  @override
  // void initState() {
  //   super.initState();
  //   // Initialize text controllers for each image
  //   textControllers = List.generate(
  //     widget.dataArray!.length,
  //     (index) => TextEditingController(
  //       text: widget.dataArray![index]['text'] ?? 'rohi',
  //     ),
  //   );
  // }

  List<String> myarray = [];

  @override
  void initState() {
    super.initState();
    // Initialize text controllers for each image
    // myarray = List.generate(
    //   widget.dataArray!.length,
    //   (index) => widget.dataArray![index]['text'] ?? 'rohi',
    // );
  }

  // text field controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _snController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _vehmodel = TextEditingController();

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('items');

  final CollectionReference _challan =
      FirebaseFirestore.instance.collection('challan');

  String searchText = '';
  // for create operation
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Create your item",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'Name', hintText: 'eg.Elon'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _snController,
                  decoration:
                      const InputDecoration(labelText: 'S.N', hintText: 'eg.1'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _numberController,
                  decoration: const InputDecoration(
                      labelText: 'Number', hintText: 'eg.10'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        final String name = _nameController.text;
                        final int? sn = int.tryParse(_snController.text);
                        final int? number =
                            int.tryParse(_numberController.text);
                        if (number != null) {
                          await _items
                              .add({"name": name, "number": number, "sn": sn});
                          _nameController.text = '';
                          _snController.text = '';
                          _numberController.text = '';

                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text("Create")),
                )
              ],
            ),
          );
        });
  }

  // for Update operation
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _snController.text = documentSnapshot['vehno'].toString();
      // _numberController.text = documentSnapshot['number'].toString();
      _numberController.text = '0';
      _vehmodel.text = documentSnapshot['veh-model'].toString();
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Generate Challan",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: 'Name', hintText: 'eg.Elon'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _snController,
                  decoration: const InputDecoration(
                      labelText: 'Vehicle_No', hintText: 'eg.1'),
                ),
                TextField(
                  // keyboardType: TextInputType.number,
                  controller: _vehmodel,
                  decoration: const InputDecoration(
                      labelText: 'Vehicle Model', hintText: 'eg.10'),
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: _numberController,
                  decoration: const InputDecoration(
                      labelText: 'Penalty (Rs)', hintText: 'eg.10'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String name = _nameController.text;
                      // final int? sn = int.tryParse(_snController.text);
                      final String? sn = _snController.text;
                      final int? number = int.tryParse(_numberController.text);
                      // if (number != null) {
                      //   await _items
                      //       .doc(documentSnapshot!.id)
                      //       .update({"name": name, "number": number, "sn": sn});

                      if (number != null) {
                        await _challan.add(
                            {"name": name, "challan": number, "vehno": sn});

                        _nameController.text = '';
                        _snController.text = '';
                        _numberController.text = '';

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Submit"))
              ],
            ),
          );
        });
  }

  // for delete operation
  Future<void> _delete(String productID) async {
    await _items.doc(productID).delete();

    // for snackBar
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You have successfully deleted a itmes")));
  }

  void _onSearchChanged(String value) {
    setState(() {
      searchText = value;
    });
  }

  bool isSearchClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: isSearchClicked
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 95, 226, 77),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(16, 20, 16, 12),
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      hintText: 'Search..'),
                ),
              )
            : const Text('Challan History'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearchClicked = !isSearchClicked;
                });
              },
              icon: Icon(isSearchClicked ? Icons.close : Icons.search))
        ],
      ),

      // body: ListView.builder(
      //   itemCount: myarray.length,
      //   itemBuilder: (context, index) {
      //     return Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Text(
      //         myarray[index] ?? 'No text available',
      //         style: TextStyle(fontSize: 16),
      //       ),
      //     );
      //   },
      // ),

      body: StreamBuilder(
        // stream: _items.snapshots(),
        // stream: _items.where('vehno', whereIn: myarray).snapshots(),
        // stream: _items.snapshots(),

        stream: _challan.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            final List<DocumentSnapshot> items = streamSnapshot.data!.docs
                .where((doc) => doc['name'].toLowerCase().contains(
                      searchText.toLowerCase(),
                    ))
                .toList();
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot = items[index];
                  return Card(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // margin: const EdgeInsets.all(10),
                    margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: ListTile(
                      // leading: CircleAvatar(
                      //   radius: 27,
                      //   // backgroundColor: const Color.fromARGB(255, 26, 226, 76),
                      //   // child: Text(
                      //   //   documentSnapshot['sn'].toString(),
                      //   //   style: const TextStyle(
                      //   //       fontWeight: FontWeight.bold, color: Colors.black),
                      //   // ),
                      //   // backgroundImage: AssetImage('https://qph.cf2.quoracdn.net/main-thumb-123333959-50-jnmtvlvbqfmjuqaubgtoixulfpycbjyf.jpeg'),
                      //   backgroundImage: AssetImage('assets/images/rohit.png'),
                      // ),
                      title: Text(
                        documentSnapshot['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      // subtitle: Text(documentSnapshot['vehno'].toString()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start, // Align text to the start of the column
                        children: [
                          // Text(
                          //   documentSnapshot['vehno'].toString(),
                          //   style: const TextStyle(
                          //     color: Colors.black,
                          //     // Add any additional text style properties here
                          //   ),
                          // ),
                          // Text(
                          //   documentSnapshot['challan'].toString(),
                          //   style: const TextStyle(
                          //     color: Colors.black,
                          //     // Add any additional text style properties here
                          //   ),
                          // ),
                          // Text(
                          //   documentSnapshot['status'].toString(),
                          //   style: const TextStyle(
                          //     color: Colors.black,
                          //     // Add any additional text style properties here
                          //   ),
                          // ),

                          // Text(
                          //   documentSnapshot['vehno'].toString(),
                          //   style: const TextStyle(
                          //     color: Colors.black,
                          //     // Add any additional text style properties here
                          //   ),
                          // ),
                          // Text(
                          //   documentSnapshot['challan'].toString(),
                          //   style: const TextStyle(
                          //     color: Colors.black,
                          //     // Add any additional text style properties here
                          //   ),
                          // ),

                          // Row(
                          //   children: [
                          //     Text(
                          //       documentSnapshot['status'].toString(),
                          //       style: const TextStyle(
                          //         color: Colors.black,
                          //         // Add any additional text style properties here
                          //       ),
                          //     ),
                          //     SizedBox(
                          //         width:
                          //             8), // Adjust the width of the gap between the text and the rectangle
                          //     Container(
                          //       width: 20, // Adjust the width of the rectangle
                          //       height:
                          //           20, // Adjust the height of the rectangle
                          //       decoration: BoxDecoration(
                          //         color: documentSnapshot['status'] == 'paid'
                          //             ? Colors.green
                          //             : Colors
                          //                 .red, // Set color based on the status
                          //         borderRadius: BorderRadius.circular(
                          //             4), // Adjust the border radius as needed
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      documentSnapshot['vehno'].toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        // Add any additional text style properties here
                                      ),
                                    ),
                                    Text(
                                      documentSnapshot['challan'].toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        // Add any additional text style properties here
                                      ),
                                    ),
                                    // Add any additional details here except for the status value
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width:
                                      8), // Adjust the width of the gap between the columns
                              // Text(
                              //   documentSnapshot['status'].toString(),
                              //   style: const TextStyle(
                              //     color: Colors.black,
                              //     backgroundColor:
                              //         documentSnapshot['status'] == 'paid'
                              //             ? Colors.green
                              //             : Colors.red,
                              //     // Add any additional text style properties here
                              //   ),
                              // ),

                              // Container(
                              //   color: documentSnapshot['status'] == 'paid'
                              //       ? const Color.fromARGB(255, 38, 223, 44)
                              //       : const Color.fromARGB(255, 221, 28, 14),
                              //   child: Text(
                              //     documentSnapshot['status'].toString(),
                              //     style: const TextStyle(
                              //       color: Colors.black,
                              //       // Add any additional text style properties here
                              //     ),
                              //   ),
                              // ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 30,
                                    color: documentSnapshot['status'] == 'Paid'
                                        ? const Color.fromARGB(255, 38, 223, 44)
                                        : const Color.fromARGB(
                                            255, 221, 28, 14),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        documentSnapshot['status'].toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          // Add any additional text style properties here
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            // IconButton(
                            //     color: Colors.black,
                            //     onPressed: () => _update(documentSnapshot),
                            //     icon: const Icon(Icons.edit)),
                            // IconButton(
                            //     color: Colors.black,
                            //     onPressed: () => _delete(documentSnapshot.id),
                            //     icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      // Create new project button
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => _create(),
      //   backgroundColor: Color.fromARGB(255, 38, 110, 192),
      //   // child: const Icon(Icons.add),
      //   child: Text("Send"),
      // ),
    );
  }
}
