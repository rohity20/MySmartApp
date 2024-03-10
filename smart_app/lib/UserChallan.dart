import 'package:flutter/material.dart';

class UserChallan extends StatelessWidget {
  final List<Map<String, dynamic>> dataArray;

  UserChallan({required this.dataArray});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Challan"),
      ),
      body: ListView.builder(
        itemCount: dataArray.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dataArray[index]['text'] ?? 'No text available',
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}



//
//
// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class UserChallan extends StatelessWidget {
//   final List<Map<String, dynamic>> dataArray;
//   final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
//
//   UserChallan({required this.dataArray});
//
//   Future<Map<String, dynamic>> fetchUserData(String userId) async {
//     DataSnapshot snapshot = await _databaseReference.child('users').child(userId).once();
//     return Map<String, dynamic>.from(snapshot.value);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("User Challan"),
//       ),
//       body: ListView.builder(
//         itemCount: dataArray.length,
//         itemBuilder: (context, index) {
//           String userId = dataArray[index]['text'] ?? '';
//
//           return FutureBuilder(
//             future: fetchUserData(userId),
//             builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               } else if (snapshot.hasError) {
//                 return Text('Error fetching user data');
//               } else if (!snapshot.hasData || snapshot.data == null) {
//                 return Text('User not found');
//               } else {
//                 Map<String, dynamic> userData = snapshot.data!;
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('Name: ${userData['name']}'),
//                       Text('Email: ${userData['email']}'),
//                       // Add other user details as needed
//                     ],
//                   ),
//                 );
//               }
//             },
//           );
//         },
//       ),
//     );
//   }
// }
