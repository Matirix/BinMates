import 'dart:convert';
import 'package:binmatesapp/models/binModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/userModel.dart';

class DBInterface {
  /// Adds the user info to the database
  Future addUserInfo(String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  /// Converts the address into a lat and long using the google maps api
  /// Returns a LatLng object
  Future<LatLng?> geocodeAddress(String address) async {
    // Should be replaced with a google plan
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

  /// Adds a bin to the database
  Future addBinInfo(Bin bin) async {
    return FirebaseFirestore.instance
        .collection("bins")
        .add(bin.toJson())
        .catchError((e) {
      print(e.toString());
    });
  }

  /// Gets the user info from the database
  Future<DocumentSnapshot> getUserInfo(String userId) async {
    return FirebaseFirestore.instance.collection("users").doc(userId).get();
  }

  /// Gets all the bins from the database
  Future<List> getBins() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('bins').get();
    List binList = querySnapshot.docs
        .map((doc) => Bin.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return binList;
  }
}

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Signs in the user
  Future<void> signIn({required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  /// Signs up the userand adds the user info to the database
  Future<void> signUp(
      {required String email,
      required String password,
      String? firstName,
      String? lastName,
      String? phoneNumber,
      String? accessCode,
      String? role}) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    // Updating Display Name
    await userCredential.user!.updateProfile(displayName: firstName);

    UserModel userModel = UserModel(
      uid: userCredential.user!.uid,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      accessCode: accessCode,
      role: role,
    );

    await DBInterface()
        .addUserInfo(userCredential.user!.uid, userModel.toJson());
  }

  /// Signs out the user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
