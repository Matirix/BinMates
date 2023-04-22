import 'dart:ffi';
import 'package:binmatesapp/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'Utils.dart';
import 'main.dart';
import 'navBar.dart';
import 'dart:developer';
import 'auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> signIn() async {
    /**
     * Sign in Function
     */

    // Broken show dialog
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await Auth().signIn(
          email: _emailController.text, password: _passwordController.text);
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      // TODO SnackBar Not Displaying
      Utils.showSnackBar(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          color: const Color(0xFFFFFEF7),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'Password',
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              loginButton(), // Login Button
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
              const SignUpButton()
            ],
          ),
        ),
      ]),
    );
  }

  SizedBox loginButton() {
    /**
     * Login Button
     */
    return SizedBox(
      width: 100,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00AD00),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        onPressed: () async {
          await signIn();
        },
        child: const Text('Login'),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  /// Sign Up Button
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/signup');
      },
      child: const Text(
        'Sign Up',
        style: TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }
}
