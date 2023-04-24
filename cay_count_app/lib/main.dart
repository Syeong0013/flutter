import 'package:cay_count_app/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'noto',
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontSize: 80.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      home: HomeScreen(),
    ),
  );
}
