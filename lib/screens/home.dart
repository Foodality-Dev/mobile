import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> restaurants = [
    {
      "name": "Izakaya",
      "image": "assets/images/restaurant-mock3.jpg",
      "distance": "1.2 mi",
      "tags": "Japanese • Casual Dining"
    },
    {
      "name": "Cafe Kacao",
      "image": "assets/images/restaurant-mock2.png",
      "distance": "3.5 mi",
      "tags": "Brunch • Coffee"
    },
    {
      "name": "Sushi Place",
      "image": "assets/images/restaurant-mock.png",
      "distance": "2.0 mi",
      "tags": "Sushi • Japanese"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        primary: false,
        centerTitle: false,
        title: Image.asset(
          "assets/logos/foodality_text_logo.png",
          height: 42,
          color: Colors.black,
        ),
      ),
      body: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[300], // Light grey, subtle
          thickness: 1, // Thin but visible
        ),
        itemCount: 15, // Keep list length
        itemBuilder: (context, index) {
          final restaurant = restaurants[index % restaurants.length]; // Cycle through sample images

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                child: Text(
                  restaurant["name"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 16 / 9, // Keeps image ratio consistent
                child: Image.asset(
                  restaurant["image"],
                  width: double.infinity,
                  fit: BoxFit.cover, // Fills width while keeping proportions
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      restaurant["tags"],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      restaurant["distance"],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
