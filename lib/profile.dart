import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_task_buddy/drawer.dart';
import 'package:my_task_buddy/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  late File? selectedImage;
  late String? imagePath;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    selectedImage = null;
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadProfileData();
  }

  Future<void> _saveProfileData() async {
    await _prefs.setString('firstName', firstNameController.text);
    await _prefs.setString('lastName', lastNameController.text);
    await _prefs.setString('email', emailController.text);
    await _prefs.setString('dateOfBirth', dateOfBirthController.text);
    await _prefs.setString('country', countryController.text);
    if (selectedImage != null) {
      await _prefs.setString('imagePath', selectedImage!.path);
    }
  }

  void _loadProfileData() {
    firstNameController.text = _prefs.getString('firstName') ?? '';
    lastNameController.text = _prefs.getString('lastName') ?? '';
    emailController.text = _prefs.getString('email') ?? '';
    dateOfBirthController.text = _prefs.getString('dateOfBirth') ?? '';
    countryController.text = _prefs.getString('country') ?? '';
    String? imagePath = _prefs.getString('imagePath');
    if (imagePath != null && imagePath.isNotEmpty) {
      setState(() {
        selectedImage = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Farm Product"),
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
                        child: const Text("No")),
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
          title: const Text("Profile"),
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
        ),
        drawer: appDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _pickFromgallery();
                },
                child: Container(
                    padding: const EdgeInsets.all(20),
                    child: selectedImage == null
                        ? const Image(
                            image: AssetImage("assets/images/profile-logo.png"),
                            height: 200,
                            width: 200,
                          )
                        : ClipOval(
                          child: Image.file(
                              selectedImage!,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                            ),
                        )),
              ),
              Form(
                  key: _formKey,
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                      child: TextFormField(
                        controller: firstNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter first name';
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return 'First name should only contain alphabets and spaces';
                          }
                          if (value.length > 15) {
                            return 'First name length should be less than 15';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "First Name",
                            prefixIcon: const Icon(
                              Icons.person,
                              size: 24,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                      child: TextFormField(
                        controller: lastNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter last name';
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return 'Last name should only contain alphabets and spaces';
                          }
                          if (value.length > 15) {
                            return ('Last name length should be less than 15');
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Last Name",
                            prefixIcon: const Icon(
                              Icons.person,
                              size: 24,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                      child: TextFormField(
                        controller: emailController,
                        onChanged: (value) {
                          setState(() {
                            //You can add any logic here
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter E-mail address';
                          }
                          if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid Email-address';
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
                              borderSide: const BorderSide(width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 5, 24, 10),
                      child: TextFormField(
                        controller: dateOfBirthController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter date of birth';
                          }
                          return null;
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: "D.O.B(YYYY-MM-DD)",
                            prefixIcon: const Icon(Icons.date_range, size: 24),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.calendar_today,
                                color: Colors.blue,
                                size: 24,
                              ),
                              onPressed: () {
                                _selectDate(context);
                              },
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
                      child: TextFormField(
                        controller: countryController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your country';
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return 'Country name should only contain alphabets and spaces';
                          }
                          if (value.length > 15) {
                            return 'Country name length should be less than 15';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Country",
                            prefixIcon: const Icon(
                              Icons.location_city,
                              size: 24,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 1.5),
                              borderRadius: BorderRadius.circular(8.0),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await _saveProfileData();
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                  (route) => false);
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
                          child: (const Text("Submit"))),
                    ),
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickFromgallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        selectedImage = file;
      });
      await _prefs.setString('imagePath', file.path);
    }
  }


  void _selectDate(context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateOfBirthController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }
}
