import 'package:binmatesapp/logIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'navBar.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final _accessCodeController = TextEditingController();

  void _signUp() {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String phoneNumber = _phoneNumberController.text;
    String password = _passwordController.text;
    String accessCode = _accessCodeController.text;
    // Use the above variables to parse the data into Firebase
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

            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 100.0),
              const Image(
                image: AssetImage('images/BinMates-Logos_RGB.png'),
                width: 300,
                height: 100,
              ),
              // const Image(
              //   image: AssetImage('images/Bear.png'),
              //   width: 300,
              //   height: 300,
              // ),
              const SizedBox(
                height: 50,
                child: Text(
                  'Sign up as a Bin Mate!',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'First Name',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Last Name',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Phone Number',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextField(
                  controller: _accessCodeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Access Code',
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
                    _signUp();
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NavBar()
                            // builder: (context) => const ClientDetails(),
                            ));
                  },
                  child: const Text('Sign Up'),
                ),
              ),
              const SizedBox(height: 10.0),
              const SizedBox(
                height: 20.0,
                child: Divider(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()
                          // builder: (context) => const ClientDetails(),
                          ));
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
