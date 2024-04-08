import 'package:smart_app/consts/consts.dart';

class FirestoreServices {
  //get users data
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //all products
  static allproducts() {
    return firestore.collection(productsCollection).snapshots();
  }
}
