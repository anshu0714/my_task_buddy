// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_task_buddy/sign_in.dart';
import 'package:my_task_buddy/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _showPassword = false;

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
          title: const Text("Sign Up"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Image(
                    image: AssetImage("assets/images/task.png"),
                  ),
                ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: const Text(
                  ("Join My Task Buddy!"),
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 5, 24, 10),
                        child: TextFormField(
                          controller: nameController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Name';
                            }
                            if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)){
                              return 'First name should only contain alphabets and spaces';
                            }
                            if(value.length > 15){
                              return 'First name length should be less than 15';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Name",
                              prefixIcon: const Icon(
                                Icons.person_outlined,
                                size: 24,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  // color: Colors.redAccent,
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(8.0),
                              )
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 5, 24, 10),
                        child: TextFormField(
                          controller: numberController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Phone Number';
                            }
                            if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                              return 'Please enter a valid Phone Number of length 10';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Phone Number",
                              prefixIcon: const Icon(
                                Icons.phone_android_outlined,
                                size: 24,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  // color: Colors.redAccent,
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(8.0),
                              )
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 5, 24, 10),
                        child: TextFormField(
                          controller: emailController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a E-mail';
                            }
                            if (!RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid E-mail address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "E-mail",
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                size: 24,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  // color: Colors.redAccent,
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(8.0),
                              )),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 5, 24, 10),
                        child: TextFormField(
                          controller: passwordController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a Password';
                            }
                            if (value.length < 8 || value.length > 16) {
                              return 'Password length should be between 8 and 16';
                            }
                            return null;
                          },
                          obscureText: !_showPassword, //Password would be hidden
                          decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: const Icon(
                                Icons.password_outlined,
                                size: 24,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                child: Icon(
                                  _showPassword ? Icons.visibility : Icons.visibility_off,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  // color: Colors.redAccent,
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(8.0),
                              )
                          ),
                        ),
                      ),


                      Container(
                        padding: const EdgeInsets.fromLTRB( 0, 10, 0, 10),
                        child: ElevatedButton(
                            onPressed: () {
                              _handleSignUp();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                alignment: AlignmentDirectional.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            child: (const Text("Sign Up"))),
                      ),

                      const Text("Or",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )
                      ),


                      Container(
                        padding: const EdgeInsets.fromLTRB( 0, 10, 0, 10),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignIn(),
                                  ),
                                      (route) => false);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                alignment: AlignmentDirectional.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                            child: (const Text("Already have an account? Sign In"))),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isSignedIn', true);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false,
      );
    }
  }
}
