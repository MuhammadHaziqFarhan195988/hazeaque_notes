import 'package:flutter/material.dart';
import 'package:hazeaque_note/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  Hive.initFlutter;

  var box = await Hive.openBox('kotak');//error

  runApp(const Hazeaque());
}

class Hazeaque extends StatelessWidget {
  const Hazeaque({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
