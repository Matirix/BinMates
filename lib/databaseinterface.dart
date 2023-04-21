import 'package:cloud_firestore/cloud_firestore.dart';

class DBInterface {
  Future addUserInfo(String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<DocumentSnapshot> getUserInfo(String userId) async {
    return FirebaseFirestore.instance.collection("users").doc(userId).get();
  }
}
