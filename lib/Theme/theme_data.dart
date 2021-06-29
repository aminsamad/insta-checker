import 'package:flutter/material.dart';
import 'package:insta_checker/Theme/storage_manager.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF1A1A2E),
      textTheme: TextTheme(
        headline4: TextStyle(color: Color(0xFFFFFFFF)),
        headline3: TextStyle(color: Color(0xffcdd8e5)),
      ),
      shadowColor: Color(0xFF2B2B44),
      backgroundColor: Color(0xFF0E0E1F),
      iconTheme: IconThemeData(color: Color(0xffd3dee9)),
      primaryColor: Color(0xffe08ba7),
      highlightColor: Color(0xffd9b6c4),
      buttonColor: Color(0xfff67fac),
      fontFamily: "english");

  final lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Color(0xFFfafbfd),
      textTheme: TextTheme(
        headline4: TextStyle(color: Color(0xff475b6f)),
        headline3: TextStyle(color: Color(0xffcdd8e5)),
      ),
      shadowColor: Colors.grey[300],
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Color(0xFF6E7174)),
      primaryColor: Color(0xffe08ba7),
      highlightColor: Color(0xffd9b6c4),
      buttonColor: Color(0xfff67fac),
      fontFamily: "english");

  ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
