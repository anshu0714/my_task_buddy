import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_task_buddy/category_page.dart';
import 'package:my_task_buddy/drawer.dart';
import 'package:my_task_buddy/task_model.dart';
import 'package:my_task_buddy/task_provider.dart';
import 'package:my_task_buddy/view_task.dart';
import 'package:provider/provider.dart';
import 'edit_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isSearchBarVisible = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearchBar() {
    setState(() {
      _isSearchBarVisible = !_isSearchBarVisible;
      if (!_isSearchBarVisible) {
        _searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(builder: (context, taskProvider, child) {
      List<Task> tasks = taskProvider.sortedTasks;

      if (_isSearchBarVisible) {
        final searchQuery = _searchController.text.toLowerCase();
        tasks = tasks.where((task) {
          final nameMatches = task.name.toLowerCase().contains(searchQuery);
          final categoryMatches =
              task.category.toLowerCase().contains(searchQuery);
          final priorityMatches =
              task.priority.toLowerCase().contains(searchQuery);
          return nameMatches || categoryMatches || priorityMatches;
        }).toList();
      }

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
                          child: const Text("No")),
                      ElevatedButton(
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          child: const Text("Yes")),
                    ],
                  ));
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: _isSearchBarVisible
                ? TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search',
                      fillColor: Colors.white,
                      filled: true,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  )
                : const Text('Home Page'),
            actions: [
              IconButton(
                icon: _isSearchBarVisible
                    ? const Icon(Icons.clear)
                    : const Icon(Icons.search),
                onPressed: _toggleSearchBar,
              ),
            ],
          ),
          drawer: appDrawer(context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (tasks.isEmpty)
                  Container(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, top: 300),
                    alignment: AlignmentDirectional.center,
                    child: const Text(
                      "No task Added - Click on add button to create a new task.",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                          color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        Task task = tasks[index];
                        Color backgroundColor =
                            getBackgroundColor(task.priority);

                        return Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          color: backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TaskDetailsScreen(task: task),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(
                                task.name.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  decoration: task.isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    task.priority,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    '|',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    task.category,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )
                                ],
                              ),
                              leading: StatefulBuilder(
                                builder: (context, setState) {
                                  return Theme(
                                    data: ThemeData(
                                      unselectedWidgetColor: Colors.white,
                                    ),
                                    child: Checkbox(
                                      activeColor: Colors.redAccent,
                                      value: task.isDone,
                                      onChanged: (newValue) {
                                        if (newValue != null) {
                                          setState(() {
                                            Provider.of<TaskProvider>(context,
                                                    listen: false)
                                                .updateTaskStatus(
                                                    task, newValue);
                                          });
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                              trailing: PopupMenuButton<String>(
                                onSelected: (String result) {
                                  if (result == "Edit") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditTaskPage(task: task)));
                                  } else if (result == "Delete") {
                                    Provider.of<TaskProvider>(context,
                                            listen: false)
                                        .deleteTask(task);
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: "Edit",
                                    child: Text("Edit"),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: "Delete",
                                    child: Text("Delete"),
                                  ),
                                ],
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors
                                      .white, // Set the icon color to white
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.redAccent,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategorySelect(),
                  ));
            },
            child: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
        ),
      );
    });
  }

  Color getBackgroundColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.purple;
      case 'Medium':
        return Colors.blue;
      case 'Low':
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }
}
