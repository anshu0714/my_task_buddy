import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:my_task_buddy/add_new_task.dart';

class CategorySelect extends StatefulWidget {
  const CategorySelect({super.key});

  @override
  State<CategorySelect> createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Tasks"),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      drawer: appDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: const Text(
                ("Select the category for your task:"),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _categories(context, "Meditation", Colors.blue),
                    _categories(context, "Art", Colors.redAccent),
                    _categories(context, "Study", Colors.orange),
                    _categories(context, "Sports", Colors.pinkAccent),
                    _categories(context, "Task", Colors.deepOrangeAccent),
                    _categories(context, "Work", Colors.green),
                    _categories(context, "Home", Colors.indigoAccent),
                    _categories(context, "Others", Colors.teal)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _navigateToCategory(BuildContext context, String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTask(categoryName: categoryName)),
    );
  }

  Widget _categories(BuildContext context, String name, Color color) {
    return GestureDetector(
      onTap: () {
        _navigateToCategory(context, name);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadiusDirectional.circular(5),
          color: color,
          boxShadow: const [
            BoxShadow(
                blurRadius: 3,
                color: Colors.black12,
                spreadRadius: 3,
                offset: Offset(2, 2),
                blurStyle: BlurStyle.normal)
          ],
        ),
        child: Text(name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 0.3,
            )),
      ),
    );
  }
}
