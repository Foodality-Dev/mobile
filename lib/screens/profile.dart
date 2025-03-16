import 'package:flutter/material.dart';
import 'package:mobile/screens/settings.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String profilePic = 'assets/images/profile_pic.png'; // Profile Image
  final String firstName = "John";
  final String lastName = "Doe";
  final String bio = "Foodie | Explorer | Always looking for the best bites in town.";

  final List<String> pastVisits = [
    "Cafe Kacao",
    "Izakaya Den",
    "Sushi Samba",
    "Boulangerie Paris",
    "Pasta e Basta"
  ];

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Settings()),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: _openSettings, // Open settings page
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(profilePic),
            ),
            const SizedBox(height: 12),
    
            Text(
              "$firstName $lastName",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
    
            Text(
              bio,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),
    
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Past Visits",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
    
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: pastVisits.length,
              separatorBuilder: (context, index) => const Divider(height: 16, color: Colors.black12),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.location_on, color: Color(0xFFC50102)),
                  title: Text(pastVisits[index], style: const TextStyle(fontSize: 16)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}