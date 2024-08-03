import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_task_buddy/task_model.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task task;

  const TaskDetailsScreen({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow('Task Name:', task.name),
            const SizedBox(height: 20),
            _buildRow('Date:', DateFormat('yyyy-MM-dd').format(task.date)),
            const SizedBox(height: 20),
            _buildRow('Time:', formatTime(task.selectedTime)),
            const SizedBox(height: 20),
            _buildRow('Priority:', task.priority),
            const SizedBox(height: 20),
            _buildRow('Category', task.category),
            const SizedBox(height: 20),
            _buildRow('Reminders:', task.reminders ? 'Enabled' : 'Disabled'),
            const SizedBox(height: 20),
            _buildRow('Description:', ''),
            const SizedBox(height: 10),
            _buildDescription(task.description),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String heading, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(String description) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        description,
        style: const TextStyle(fontSize: 16),
      ),
    );
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
}
