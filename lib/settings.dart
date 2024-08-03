import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_task_buddy/drawer.dart';
import 'package:my_task_buddy/theme_provider.dart';
import 'package:provider/provider.dart';
import 'notification_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _offlineModeEnabled = true;
  bool _autoSyncEnabled = false;
  bool _notificationSoundEnabled = false;
  late bool _darkModeEnabled;

  @override
  void initState() {
    super.initState();
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _darkModeEnabled = themeProvider.getThemeMode() == ThemeModeType.dark;
    _initializeNotificationSettings();
  }

  Future<void> _initializeNotificationSettings() async {
    await NotificationService().init();
  }

  @override
  Widget build(BuildContext context) {
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
                  child: const Text("No"),
                ),
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
        drawer: appDrawer(context),
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text("About 'My Task Buddy'"),
        ),
        body: ListView(
          children: [
            SwitchListTile(
              title: const Text("Dark Mode", style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: const Text("Switch to dark themes", style: TextStyle(fontWeight: FontWeight.w400)),
              activeColor: Colors.redAccent,
              value: _darkModeEnabled,
              onChanged: (value) {
                setState(() {
                  _darkModeEnabled = value;
                  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                  themeProvider.setThemeMode(
                      value ? ThemeModeType.dark : ThemeModeType.light);
                });
              },
            ),

            SwitchListTile(
              title: const Text("Offline Mode", style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: const Text("Use app features Offline", style: TextStyle(fontWeight: FontWeight.w400)),
              activeColor: Colors.redAccent,
              value: _offlineModeEnabled,
              onChanged: (value) {
                setState(() {
                  _offlineModeEnabled = value;

                });
              },
            ),
            SwitchListTile(
              title: const Text("Auto-Sync", style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: const Text("Enable automatic synchronization", style: TextStyle(fontWeight: FontWeight.w400)),
              activeColor: Colors.redAccent,
              value: _autoSyncEnabled,
              onChanged: (value) {
                setState(() {
                  _autoSyncEnabled = value;

                });
              },
            ),
            SwitchListTile(
              title: const Text("Notification Sound", style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: const Text("Turn on notifications", style: TextStyle(fontWeight: FontWeight.w400)),
              activeColor: Colors.redAccent,
              value: _notificationSoundEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationSoundEnabled = value;
                });
                if (value) {
                  NotificationService().showNotification(
                    'My Task Buddy',
                    'Notification Sound Enabled',
                  );
                }
              },
            ),
            // Add more settings tiles here
          ],
        ),
      ),
    );
  }
}
