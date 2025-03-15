import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile/screens/home.dart';
import 'package:mobile/screens/profile.dart';


class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  late List<Widget> widgetOptions;
  int _selectedIndex = 0;

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      activeIcon: Image.asset(
        'assets/icons/home.png',
        width: 32.5,
        height: 32.5,
      ),
      icon: Image.asset(
        'assets/icons/home.png',
        width: 32.5,
        height: 32.5,
      ),
      label: 'Home'
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset(
        'assets/icons/discover.png',
        width: 32.5,
        height: 32.5,
      ),
      icon: Image.asset(
        'assets/icons/discover.png',
        width: 32.5,
        height: 32.5,
      ),
      label: 'Discover'
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset(
        'assets/icons/notification_bell.png',
        width: 32.5,
        height: 32.5,
      ),
      icon: Image.asset(
        'assets/icons/notification_bell.png',
        width: 32.5,
        height: 32.5,
      ),
      label: 'Notifications'
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset(
        'assets/icons/profile.png',
        width: 32.5,
        height: 32.5,
      ),
      icon: Image.asset(
        'assets/icons/profile.png',
        width: 32.5,
        height: 32.5,
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
    widgetOptions = const <Widget>[
        Home(),
        Center(child: Text("This is the Discovery Page!")),
        Center(child: Text("This is the Notifications Page!")),
        Profile()
      ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
        // for the below line: https://stackoverflow.com/questions/44978216/flutter-remove-back-button-on-appbar
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: _selectedIndex == 0 ? 
        FloatingActionButton(
          onPressed: () async {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) {
            //     // return const QrCodeScanPage();
            //   }),
            // );
          },
          backgroundColor: const Color(0xFFC50102),
          child: const Icon(Icons.qr_code, color: Colors.white, size: 36)
        )
        : null,
      body: widgetOptions.elementAt(_selectedIndex),
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
