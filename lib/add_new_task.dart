import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_task_buddy/drawer.dart';
import 'package:my_task_buddy/task_model.dart';
import 'package:my_task_buddy/task_provider.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';

class AddTask extends StatefulWidget {
  final String categoryName;

  const AddTask({required this.categoryName, Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late String _selectedCategory = '';
  final _formKey = GlobalKey<FormState>();

  TextEditingController taskNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  String _selectedPriority = 'Medium';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _reminders = true;

  @override
  void initState() {
    super.initState();
    categoryController.text = widget.categoryName;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Add Task"),
                  content: const Text("Do you want to skip adding a task?"),
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
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                              (route) => false);
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
        drawer: appDrawer(context),
        appBar: AppBar(
          title: Text(widget.categoryName),
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
        ),
        body: Form(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    child: const Text(
                      "Create New Task",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.3,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: taskNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the task name';
                                  }
                                  if (value.length > 20) {
                                    return 'Task name length should be less than 20';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    labelText: "Task Name",
                                    prefixIcon: const Icon(
                                      Icons.task,
                                      size: 24,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(width: 1.5),
                                      borderRadius: BorderRadius.circular(5.0),
                                    )),
                              )),
                          Container(
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                controller: descriptionController,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                    hintText: "Task Description (Optional)",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 1.5,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 1.5),
                                    )),
                              )),
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: dateController,
                              onChanged: (value) {
                                setState(() {});
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please select date for task';
                                }
                                return null;
                              },
                              readOnly: true,
                              decoration: InputDecoration(
                                  labelText: "Task Date",
                                  prefixIcon:
                                      const Icon(Icons.date_range, size: 24),
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
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: timeController,
                                onChanged: (value) {
                                  setState(() {});
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please select time for task';
                                  }
                                  return null;
                                },
                                readOnly: true,
                                decoration: InputDecoration(
                                    labelText: "Task Time",
                                    prefixIcon: const Icon(
                                      Icons.timer,
                                      size: 24,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: const Icon(
                                        Icons.access_time_outlined,
                                        color: Colors.blue,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        _selectTime(context);
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
                              )),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: DropdownButtonFormField<String>(
                              value: _selectedPriority,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedPriority = newValue!;
                                });
                              },
                              items: <String>[
                                'High',
                                'Medium',
                                'Low'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: "Priority",
                                prefixIcon: const Icon(
                                  Icons.assessment,
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
                                ),
                              ),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: categoryController,
                                enabled: false,
                                readOnly: true,
                                decoration: InputDecoration(
                                    labelText: "Category",
                                    prefixIcon: const Icon(
                                      Icons.category_outlined,
                                      size: 24,
                                    ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),),
                              )),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: SwitchListTile(
                              title: const Text(
                                "Reminder",
                                style: TextStyle(fontSize: 20),
                              ),
                              value: _reminders,
                              activeColor: Colors.redAccent,
                              onChanged: (value) {
                                setState(() {
                                  _reminders = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _selectedCategory = widget.categoryName;
                                });
                                _addTask(_selectedCategory);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                alignment: AlignmentDirectional.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text("Add Task"),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate(context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2033));

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        String formattedTime = formatTime(_selectedTime);
        timeController.text = formattedTime;
      });
    }
  }

  String formatTime(TimeOfDay time) {
    int hour = time.hour;
    int minute = time.minute;
    String period = 'AM';

    if (hour >= 12) {
      period = 'PM';
      if (hour > 12) {
        hour -= 12;
      }
    }

    return '${hour.toString()}:${minute.toString().padLeft(2, '0')} $period';
  }


  void _addTask(String selectedCategory) {
    Task newTask = Task(
      id: UniqueKey().toString(),
      name: taskNameController.text,
      description: descriptionController.text,
      date: _selectedDate,
      priority: _selectedPriority,
      reminders: _reminders,
      isDone: false,
      selectedTime: _selectedTime,
      category: categoryController.text,
    );

    Provider.of<TaskProvider>(context, listen: false).addTask(newTask);

    Navigator.pop(context);
  }
}
