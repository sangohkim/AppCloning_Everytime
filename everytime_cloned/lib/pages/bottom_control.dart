import 'package:flutter/material.dart';
import 'package:everytime_cloned/pages/main_page.dart';
import 'package:everytime_cloned/pages/time_table.dart';
import 'package:everytime_cloned/pages/board_list.dart';
import 'package:everytime_cloned/pages/alarm_list.dart';
import 'package:everytime_cloned/pages/campus_pick.dart';

class BottomControl extends StatefulWidget {
  const BottomControl({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _BottomControlState();
}

class _BottomControlState extends State<BottomControl> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    MainPage(),
    TimeTable(),
    BoardList(),
    AlarmList(),
    CampusPick(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart_outlined),
            label: 'Time table',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Board',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.alarm_outlined),
            label: 'Alarm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outlined),
            label: 'Campus pick',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 26,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
