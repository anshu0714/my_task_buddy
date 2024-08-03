import 'package:flutter/material.dart';
import 'package:my_task_buddy/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [];
  SharedPreferences? _prefs;

  TaskProvider() {
    _loadTasks();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadTasks() async {
    await _initSharedPreferences();
    final tasksJson = _prefs?.getString('tasks');
    if (tasksJson != null) {
      final List<dynamic> taskListJson = jsonDecode(tasksJson);
      _tasks.addAll(taskListJson.map((taskJson) => Task.fromJson(taskJson)));
      notifyListeners();
    }
  }

  Future<void> _saveTasks() async {
    await _initSharedPreferences();
    final taskListJson = _tasks.map((task) => task.toJson()).toList();
    _prefs?.setString('tasks', jsonEncode(taskListJson));
  }

  List<Task> get tasks => _tasks;

  List<Task> get sortedTasks {
    _tasks.sort((a, b) {
      return priorityValue(b.priority).compareTo(priorityValue(a.priority));
    });
    return _tasks;
  }

  int priorityValue(String priority) {
    switch (priority) {
      case 'High':
        return 3;
      case 'Medium':
        return 2;
      case 'Low':
        return 1;
      default:
        return 0;
    }
  }

  void addTask(Task task) {
    _tasks.add(task);
    _saveTasks();
    notifyListeners();
  }

  void updateTaskStatus(Task task, bool isDone) {
    final index = _tasks.indexOf(task);
    if (index != -1) {
      _tasks[index].isDone = isDone;
      _saveTasks();
      notifyListeners();
    }
  }

  void editTask(Task oldTask, Task newTask) {
    final index = _tasks.indexOf(oldTask);
    if (index != -1) {
      _tasks[index] = newTask;
      _saveTasks();
      notifyListeners();
    }
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    _saveTasks();
    notifyListeners();
  }
}
