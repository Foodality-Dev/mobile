import 'package:flutter/material.dart';
import 'package:mobile/intro/google_auth.dart';
import 'package:mobile/intro/login.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  void _openPrivacyPolicy() {
    print("Open Privacy Policy Link");
  }

  void _openTermsOfUse() {
    print("Open Terms of Use Link");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Settings",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.privacy_tip, color: Color(0xFFC50102)),
              title: const Text("Privacy Policy"),
              onTap: _openPrivacyPolicy,
            ),
            ListTile(
              leading: const Icon(Icons.description, color: Color(0xFFC50102)),
              title: const Text("Terms of Use"),
              onTap: _openTermsOfUse,
            ),
            const Divider(),

            // 🔴 Sign Out Button
            Center(
              child: ElevatedButton(
                onPressed: () async { 
                  await Authentication.signOut(context: context);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login())
                  );
                },
                style: TextButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Color(0xFFC50102),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Sign Out", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
