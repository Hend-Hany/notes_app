import 'package:flutter/material.dart';
import 'package:note_app/widget/app/app_colors.dart';

class Utils {
  static ThemeData get appTheme {
    return ThemeData(
      fontFamily: 'Nunito',
      appBarTheme: const AppBarTheme(
        color: AppColors.black,
        elevation: 0,
      ),
      canvasColor: AppColors.black,
      iconTheme: const IconThemeData(color: AppColors.white),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.darkGray),
    );
  }

  static const List<Color> noteColors = [
    Colors.green,
    Colors.grey,
    Colors.yellow,
    Colors.blue,
    Colors.teal,
    Colors.amber,
    Colors.blueGrey,
    Colors.brown,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
  ];
}
