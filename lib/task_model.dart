import 'package:flutter/material.dart';

class Task {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final String priority;
  final bool reminders;
  bool isDone;
  TimeOfDay selectedTime;
  final String category;

  Task({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.priority,
    required this.reminders,
    required this.isDone,
    required this.selectedTime,
    required this.category,
  });

  // Convert Task to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'priority': priority,
      'reminders': reminders,
      'isDone': isDone,
      'selectedTimeHour': selectedTime.hour,
      'selectedTimeMinute': selectedTime.minute,
      'category': category,
    };
  }

  // Create Task from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      priority: json['priority'],
      reminders: json['reminders'],
      isDone: json['isDone'],
      selectedTime: TimeOfDay(
        hour: json['selectedTimeHour'],
        minute: json['selectedTimeMinute'],
      ),
      category: json['category'],
    );
  }
}
