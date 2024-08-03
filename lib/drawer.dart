import 'package:flutter/material.dart';
import 'package:my_task_buddy/about.dart';
import 'package:my_task_buddy/feedback.dart';
import 'package:my_task_buddy/home_page.dart';
import 'package:my_task_buddy/profile.dart';
import 'package:my_task_buddy/settings.dart';
import 'package:my_task_buddy/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget appDrawer(context) {
  return Drawer(
    child: Container(
      color: Colors.redAccent,
      child: ListView(
        children: [
          DrawerHeader(
              child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black,
                image: const DecorationImage(
                    image: AssetImage("assets/images/logo.png"))),
          )),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white, size: 25),
            title: const Text('Home',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.task, color: Colors.white, size: 25),
            title: const Text('Profile',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white, size: 25),
            title: const Text('Settings',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback, color: Colors.white, size: 25),
            title: const Text('Feedback',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FeedbackPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.white, size: 25),
            title: const Text('About',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white, size: 25),
            title: const Text('Log Out',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                )),
            onTap: () async {
              await clearUserSessionData();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignIn()));
            },
          )
        ],
      ),
    ),
  );
}

Future<void> clearUserSessionData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('isSignedIn');
  await prefs.setBool('showHomePage', false);
}
