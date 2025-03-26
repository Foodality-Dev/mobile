import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile/intro/login.dart';
import 'package:mobile/nav.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFC50102),
        primaryTextTheme: TextTheme(  // as shown on #catalog
          titleLarge: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
          titleMedium: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          bodySmall: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontSize: 12,
            color: const Color(0x19FFFFFF),
            fontWeight: FontWeight.bold,
          ),
          labelMedium: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          labelSmall: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      title: 'Foodality',
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            return user == null ? const Login() : const Nav();
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ); // Show loading while checking auth state
        },
      ),
    );
  }
}