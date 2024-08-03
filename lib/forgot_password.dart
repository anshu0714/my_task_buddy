import 'package:flutter/material.dart';
import 'package:my_task_buddy/reset_password.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: const Image(
                image: AssetImage("assets/images/forgotPassword.jpg"),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: const Text(
                ("Enter Your E-mail ID"),
                style: TextStyle(
                  fontSize: 20,
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
                      padding: const EdgeInsets.fromLTRB(24, 5, 24, 25),
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

                    // Container(
                    //   alignment: Alignment.centerRight,
                    //   padding: const EdgeInsets.fromLTRB(10, 10, 25, 20),
                    // ),

                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ResetPassword(),));
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
                        child: (const Text("Forgot Password"))),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
