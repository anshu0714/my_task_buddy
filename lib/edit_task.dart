import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_task_buddy/task_model.dart';
import 'package:my_task_buddy/task_provider.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  const EditTaskPage({required this.task, Key? key}) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  late TextEditingController taskNameController;
  late TextEditingController descriptionController;
  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController categoryController;
  late String _selectedPriority;
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late bool _reminders;

  @override
  void initState() {
    super.initState();
    taskNameController = TextEditingController(text: widget.task.name);
    descriptionController =
        TextEditingController(text: widget.task.description);
    dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(widget.task.date));
    timeController =
        TextEditingController(text: formatTime(widget.task.selectedTime));
    categoryController = TextEditingController(text: widget.task.category);
    _selectedPriority = widget.task.priority;
    _selectedDate = widget.task.date;
    _selectedTime = widget.task.selectedTime;
    _reminders = widget.task.reminders;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Add Task"),
                  content: const Text("Do you want to skip updating the task?"),
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
        appBar: AppBar(
          title: const Text("Edit Task"),
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: taskNameController,
                decoration: const InputDecoration(labelText: "Task Name"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: dateController,
                readOnly: true,
                onTap: _selectDate,
                decoration: const InputDecoration(
                  labelText: "Task Date",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: timeController,
                readOnly: true,
                onTap: _selectTime,
                decoration: const InputDecoration(
                  labelText: "Task Time",
                  suffixIcon: Icon(Icons.access_time),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedPriority,
                onChanged: (newValue) {
                  setState(() {
                    _selectedPriority = newValue!;
                  });
                },
                items: ['High', 'Medium', 'Low']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: "Priority"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                enabled: false,
                controller: categoryController,
                readOnly: true,
                decoration: const InputDecoration(labelText: "Category"),
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                activeColor: Colors.redAccent,
                title: const Text("Reminders"),
                value: _reminders,
                onChanged: (value) {
                  setState(() {
                    _reminders = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _updateTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text("Update Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2033),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  void _selectTime() async {
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

  void _updateTask() {
    Task newTask = Task(
      id: widget.task.id,
      name: taskNameController.text,
      description: descriptionController.text,
      date: _selectedDate,
      priority: _selectedPriority,
      reminders: _reminders,
      isDone: widget.task.isDone,
      selectedTime: _selectedTime,
      category: categoryController.text,
    );

    Provider.of<TaskProvider>(context, listen: false)
        .editTask(widget.task, newTask);

    Navigator.pop(context);
  }
}
