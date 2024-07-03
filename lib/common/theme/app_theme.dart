import 'package:flutter/material.dart';

abstract class AppTheme {
  static final light = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.grey[100],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[100],
      ),
      inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          )));
}
