import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/screens/discover.dart';
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
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      activeIcon: Image.asset('assets/icons/home.png', width: 32.5, height: 32.5),
      icon: Image.asset('assets/icons/home.png', width: 32.5, height: 32.5),
      label: 'Home',
    ),

    BottomNavigationBarItem(
      activeIcon: Image.asset('assets/icons/discover.png', width: 32.5, height: 32.5),
      icon: Image.asset('assets/icons/discover.png', width: 32.5, height: 32.5),
      label: 'Discover',
    ),

    BottomNavigationBarItem(
      icon: Image.asset('assets/logos/foodality_logo.png', width: 42.5, height: 42.5),
      label: 'Create',
    ),

    BottomNavigationBarItem(
      activeIcon: Image.asset('assets/icons/notification_bell.png', width: 32.5, height: 32.5),
      icon: Image.asset('assets/icons/notification_bell.png', width: 32.5, height: 32.5),
      label: 'Notifications',
    ),
    BottomNavigationBarItem(
      activeIcon: Image.asset('assets/icons/profile.png', width: 32.5, height: 32.5),
      icon: Image.asset('assets/icons/profile.png', width: 32.5, height: 32.5),
      label: 'Profile',
    ),
  ];

  void _onTabTapped(int index) async {
    if (index == 2) {
      // 🚀 Opens the camera when tapping the camera icon
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        print("📸 Image taken: ${image.path}");
        // Handle the image (upload, preview, etc.)
      }
      // setState(() {
      //   _selectedIndex = index;
      // });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    widgetOptions = const <Widget>[
      Home(),
      Discover(),
      Center(child: Text("This wasn't supposed to happen...")),
      Center(child: Text("This is the Notifications Page!")),
      Profile(),
    ];

    return Scaffold(
      body: SafeArea(top: true, child: widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onTabTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: items,
        backgroundColor: const Color(0xFFF9F9F9),
      ),
    );
  }
}
