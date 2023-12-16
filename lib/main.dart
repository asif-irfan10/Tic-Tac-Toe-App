import 'package:flutter/material.dart';
import 'package:flutter_application_1/Assest/my_color.dart';
import 'package:flutter_application_1/Widget/Game.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true),
    home: const MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}
