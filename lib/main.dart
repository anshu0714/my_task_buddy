import 'package:flutter/material.dart';
import 'package:my_task_buddy/task_provider.dart';
import 'package:my_task_buddy/theme_provider.dart';
import 'package:provider/provider.dart';
import 'Splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),//ChangeNotifierProvider is allowing other widgets to listen to and interact with its state changes.
        ChangeNotifierProvider(create: (_) => TaskProvider()),//Create is responsible for creating the class that you want to make available as a provider
      ],
      child: Consumer<ThemeProvider>(//Consumer this widget listens to changes in the state of ThemeProvider and rebuilds its child widget when the state changes
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'My Task Buddy',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeProvider.getThemeMode() == ThemeModeType.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const Splash(),
          );
        },
      ),
    );
  }
}
