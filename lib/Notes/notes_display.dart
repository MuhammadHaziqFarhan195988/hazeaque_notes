import 'package:flutter/material.dart';

class NotesDisplay extends StatelessWidget {
  const NotesDisplay(this.title,this.content,{super.key});
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.teal,), onPressed: () => Navigator.pop(context),),
        flexibleSpace: Container(
          height: 110,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
              colors: [Colors.black, Colors.teal])
          ),
        ),
        title: Text(title, style: const TextStyle(color: Colors.teal),),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding:const EdgeInsets.all(20.0),
        color: Colors.blue,
        child: Text(content, style: const TextStyle(fontSize: 23),),
      ),
    );
  }
}