import 'package:firebase_auth/firebase_auth.dart';

import 'databaseinterface.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      String? firstName,
      String? lastName,
      String? phoneNumber,
      String? accessCode}) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    // Updating Display Name
    await userCredential.user!.updateProfile(displayName: firstName);

    Map<String, dynamic> userInfoMap = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phoneNumber": phoneNumber,
      "accessCode": accessCode,
    };

    await DBInterface().addUserInfo(userCredential.user!.uid, userInfoMap);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
