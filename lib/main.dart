import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_checker/Theme/theme_data.dart';
import 'package:insta_checker/Screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => new ThemeNotifier(),
    child: HomeScreen(),
  ));
}
