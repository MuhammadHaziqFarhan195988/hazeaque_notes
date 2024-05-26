import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hazeaque_note/home_page.dart';



void main() async {
WidgetsFlutterBinding.ensureInitialized();

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
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
{
  @override
  void initState(){
    super.initState();

    displaySplash();
  }

  displaySplash(){
    Timer(const Duration(seconds: 5), () async {
      Route route = MaterialPageRoute(builder: (_) => const HomePage());
      Navigator.pushReplacement(context, route);

    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient:  LinearGradient(
              colors: [Colors.black, Colors.teal],
           begin: Alignment(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.file_copy),
              SizedBox(height: 20.0),
              Text("Hazeaque Notes",
              style: TextStyle(color: Colors.white),),

            ],
          ),
        ),
      ),
    );
  }
}

