import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Matches IG's clean look
        elevation: 0, // No shadow
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          "Foodality", // Change to your app name
          style: TextStyle(
            // fontFamily: 'Billabong', // Instagram's signature font (optional)
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Dark text like IG
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          controller: _scrollController, // Attach scroll controller
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 5,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/restaurant-mock.png',
                    height: 250,
                    width: 250,
                    fit: BoxFit.fill,
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 1)),
                const Text('Cafe Kacao'),
              ],
            );
          },
        ),
      ),
    );
  }
}
