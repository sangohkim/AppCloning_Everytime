import 'package:flutter/material.dart';

class CampusPick extends StatefulWidget {
  const CampusPick({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CampusPickState();
}

class _CampusPickState extends State<CampusPick> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            text: '대학생 SNS\n',
            style: TextStyle(
              color: Colors.lightBlue,
              fontSize: 10,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '캠퍼스픽',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.message,
              color: Colors.lightBlue,
            ),
            onPressed: () {},
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Center(
        child: Text('Hi, there!'),
      ),
    );
  }
}
