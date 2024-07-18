import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';


class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;

  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      activeIcon: Image(
        image: AssetImage('assets/icons/home_selected.png'),
        width: 35,
        height: 35,
      ),
      icon: Image(
        image: AssetImage('assets/icons/home_unselected.png'),
        width: 35,
        height: 35,
      ),
      label: 'Home'
    ),
    const BottomNavigationBarItem(
      activeIcon: Image(
        image: AssetImage('assets/icons/geocommunity_selected.png'),
        width: 35,
        height: 35,
      ),
      icon: Image(
        image: AssetImage('assets/icons/geocommunity_unselected.png'),
        width: 35,
        height: 35,
      ),
      label: 'Geocommunity'
    ),
    const BottomNavigationBarItem(
      activeIcon: Image(
        image: AssetImage('assets/icons/stats_selected.png'),
        width: 35,
        height: 35,
      ),
      icon: Image(
        image: AssetImage('assets/icons/stats_unselected.png'),
        width: 35,
        height: 35,
      ),
      label: 'Stats'
    ),
    const BottomNavigationBarItem(
      activeIcon: Image(
        image: AssetImage('assets/icons/profile_selected.png'),
        width: 35,
        height: 35,
      ),
      icon: Image(
        image: AssetImage('assets/icons/profile_unselected.png'),
        width: 35,
        height: 35,
      ),
      label: 'Profile'
    ),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {         
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
        // for the below line: https://stackoverflow.com/questions/44978216/flutter-remove-back-button-on-appbar
        automaticallyImplyLeading: true,
      ),
      body: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(                                                
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onTabTapped,
        unselectedItemColor: const Color(0xFFBDBDBD),
        selectedItemColor: const Color(0xFF000000), // Color(0xFFf76c00),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: items,
        backgroundColor: const Color(0xFFF9F9F9),                                                         
      ),                                                                                                                                                   
    );
  }
}
