import 'package:flutter/material.dart';

enum ThemeModeType {// enum is used to represent different theme modes for your app.
  light,
  dark,
}

class ThemeProvider extends ChangeNotifier {//
  ThemeModeType _themeMode = ThemeModeType.light;//_themeMode is a private variable which holds the current theme mode

  ThemeModeType getThemeMode() { //getThemeMode method is used to retrieve the current theme mode.
    return _themeMode;
  }

  void setThemeMode(ThemeModeType mode) {//setThemeMode method is used to update the theme mode.
    _themeMode = mode;
    notifyListeners(); //inform any listeners (widgets that are listening to this provider) that the state has changed, so they can rebuild themselves accordingly.
  }
}
