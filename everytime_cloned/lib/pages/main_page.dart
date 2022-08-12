import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:everytime_cloned/pages/user_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            text: '에브리타임\n',
            style: TextStyle(
              color: Colors.red,
              fontSize: 10,
            ),
            children: const <TextSpan>[
              TextSpan(
                text: 'KAIST',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {},
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            icon: Icon(
              Icons.person_outline,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UserPage();
                  },
                ),
              );
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        child: Center(
          child: Text("Hi, there!"),
        ),
      ),
    );
  }
}
