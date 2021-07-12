import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golekos/pages/dashboard_page.dart';
import 'package:golekos/pages/profile_page.dart';

class ButtomBar extends StatefulWidget {
  final User user;
  ButtomBar({this.user});
  @override
  _ButtomBarState createState() => _ButtomBarState();
}

class _ButtomBarState extends State<ButtomBar> {
  int _currentIndex = 0;
  List<Widget> _listTab;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _listTab = [
      Dashboard(widget.user),
      Profile(widget.user),
    ];
  }

  // Get data from API

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 55.0),
            child: _listTab[_currentIndex],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomNavigationBar(
                items: _bottomNavItem,
                currentIndex: _currentIndex,
                selectedItemColor: Color(0xff2DC6F2),
                unselectedItemColor: Colors.grey,
                onTap: _onItemTapped,
                elevation: 15.0,
                type: BottomNavigationBarType.fixed),
          )
        ],
      ),
    );
  }

  final _bottomNavItem = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(Icons.account_circle_rounded),
      icon: Icon(Icons.account_circle_outlined),
      label: 'Profile',
    ),
  ];
}
