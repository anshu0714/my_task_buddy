import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_task_buddy/drawer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_task_buddy/home_page.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  double _rating = 0.0;
  final _formKey = GlobalKey<FormState>();
  bool _showRatingError = false;

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
          title: const Text("Feedback"),
        ),
        drawer: appDrawer(context),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                    child: const Image(image: AssetImage("assets/images/feedback.png"))
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: const Text(
                    ("Your Feedback is Important!"),
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: const Text(
                    "How do you rate this app?",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                RatingBar.builder(
                    initialRating: _rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _rating = rating;
                        _formKey.currentState?.validate();
                      });
                    }),
                if (_showRatingError)
                  const Text(
                    "Please select a rating",
                    style: TextStyle(color: Colors.red),
                  ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: const Text(
                    "Please leave your feedback below: ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: const TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: "Enter your feedback here...(Optional)",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5),
                          )),
                    )),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_validateForm()) {
                          _showThankYouDialogAndReturnHome();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          alignment: AlignmentDirectional.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                      child: const Text("Submit")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    if (_rating == 0.0) {
      setState(() {
        _showRatingError = true;
      });
      return false;
    } else {
      setState(() {
        _showRatingError = false;
      });
      return true;
    }
  }

  void _showThankYouDialogAndReturnHome() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Thanks for your feedback",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
                (route) => false,
              );
            },style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
          ),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
