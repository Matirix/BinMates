import 'package:binmatesapp/binDetails.dart';
import 'package:binmatesapp/binMap.dart';
import 'package:binmatesapp/screenNav.dart';
import 'package:binmatesapp/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screenNav.dart';
import 'Utils.dart';
import 'addBin.dart';
import 'binList.dart';
import 'signin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

// Used to login to the app without context
final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        backgroundColor: const Color(0xFFFFFEF7),

        primarySwatch: Colors.blue,
        fontFamily: 'Chivo',
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const NavBar();
          } else {
            return const Login();
          }
        },
      ),
      routes: {
        '/home': (context) => const NavBar(),
        '/bins': (context) => const MapScreen(),
        '/binList': (context) => const BinList(),
        '/binDetails': (context) => const BinDetails(),
        '/login': (context) => const Login(),
        '/signup': (context) => const SignUp(),
        '/addBin': (context) => const AddBinAdmin(),
      },
    );
  }
}
