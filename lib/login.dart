import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'navBar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          color: const Color(0xFFFFFEF7),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100.0),
              const Image(
                image: AssetImage('images/BinMates-Logos_RGB.png'),
                width: 300,
                height: 100,
              ),
              const Image(
                image: AssetImage('images/Bear.png'),
                width: 300,
                height: 300,
              ),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 100,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00AD00),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NavBar()
                            // builder: (context) => const ClientDetails(),
                            ));
                  },
                  child: const Text('Login'),
                ),
              ),
              const SizedBox(height: 10.0),
              const SizedBox(
                height: 20.0,
                child: Divider(
                  color: Colors.black,
                ),
              ),
              const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 5.0),
              const Text(
                'Don\'t have an account?',
                style: TextStyle(
                  color: Colors.blue,
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
