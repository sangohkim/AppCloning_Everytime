import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KAIST',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Icon(Icons.search),
          Icon(Icons.people),
        ],
      ),
      body: Container(
        child: Center(
          child: Text("Hi, there!"),
        ),
      ),
    );
  }
}
