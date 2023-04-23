import 'dart:convert';
import 'package:binmatesapp/models/marker_model.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  Future<LatLng?> geocodeAddress(String address) async {
    var apiKey = 'AIzaSyA5BimNCeljcJ9mFCvxDQyckRAnIWfh_zo';
    var url =
        'https://maps.googleapis.com/maps/api/geocode/json?key=$apiKey&address=$address';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        var location = data['results'][0]['geometry']['location'];
        var lat = location['lat'];
        var lng = location['lng'];
        return LatLng(lat, lng);
      }
    }
    return null;
  }

  Future addBinInfo(MarkerModel bin) async {
    return FirebaseFirestore.instance
        .collection("bins")
        .add(bin.toJson())
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<DocumentSnapshot> getUserInfo(String userId) async {
    return FirebaseFirestore.instance.collection("users").doc(userId).get();
  }

  Future<List> getBins() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('bins').get();
    List binList = querySnapshot.docs
        .map((doc) => MarkerModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return binList;
  }
}
