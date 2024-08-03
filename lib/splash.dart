// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:my_task_buddy/home_page.dart';
import 'package:my_task_buddy/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: const Center(
        child: Image(
            image: AssetImage("assets/images/logo.png")),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 33),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(

            onPressed: ()async {
              _handleButtonClick();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              alignment: AlignmentDirectional.center,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              )
            ),
            child: (const Text("Continue",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            )),
          ),
        ),
      ),
    );
  }
  void _handleButtonClick() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showHomePage = prefs.getBool('showHomePage') ?? false;

    if (showHomePage) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      prefs.setBool('showHomePage', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    }
  }
}

