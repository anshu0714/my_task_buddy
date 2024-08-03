import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_task_buddy/drawer.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("My Task Buddy"),
                  content: const Text("Do you want to quit the app?"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      child: const Text("No"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        child: const Text("Yes"))
                  ],
                ));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text("About 'My Task Buddy'"),
        ),
        drawer: appDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black),
                  child: const Image(
                    image: AssetImage("assets/images/logo.png"),
                  )),
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                    "To do list , Routine Planner, and Reminders. All in just One app!",
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.justify),
              ),
              Container(
                alignment: AlignmentDirectional.topStart,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: const Text(
                  "Introducing Task Buddy - Your Smart Task Manager ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: const Text(
                    "Your Daily Task Manager. Simplify your life with our intuitive to-do list app. "
                    "Plan tasks, set reminders, and boost your productivity. Download now and make"
                    " every day more organized and efficient",
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.justify),
              ),
              Container(
                alignment: AlignmentDirectional.centerEnd,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: const Text("Developed in 2023",
                    style: TextStyle(
                        letterSpacing: 0.3, fontStyle: FontStyle.italic)),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                alignment: AlignmentDirectional.centerEnd,
                child: const Text(
                  "- by Anshu Jha",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
