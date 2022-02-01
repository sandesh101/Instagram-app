import 'package:flutter/material.dart';
import 'package:instagram_app/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackground,
      ),
      home: const Scaffold(body: Text('Instagram Clone')),
    );
  }

  ThemeData buildThemeData() => ThemeData.dark();
}
