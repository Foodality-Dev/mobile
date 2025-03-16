import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:mobile/screens/restaurant.dart';

class Discover extends StatefulWidget {
  const Discover({super.key});

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  List<Map<String, dynamic>> restaurants = [
    {
      "name": "Izakaya",
      "image": "assets/images/restaurant-mock3.jpg",
      "distance": "1.2 mi",
      "tags": ["Japanese", "Casual Dining"]
    },
    {
      "name": "Cafe Kacao",
      "image": "assets/images/restaurant-mock2.png",
      "distance": "3.5 mi",
      "tags": ["Brunch", "Coffee"]
    },
    {
      "name": "Sushi Place",
      "image": "assets/images/restaurant-mock.png",
      "distance": "2.0 mi",
      "tags": ["Sushi", "Japanese"]
    }
  ];

  List<Map<String, dynamic>> filteredRestaurants = [];
  final TextEditingController _searchController = TextEditingController();
  final CardSwiperController _swiperController = CardSwiperController();

  @override
  void initState() {
    super.initState();
    filteredRestaurants = restaurants;
  }

  void _filterRestaurants(String query) {
    setState(() {
      filteredRestaurants = restaurants.where((restaurant) {
        return restaurant["name"].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🌆 Background Image
        Positioned.fill(
          child: Image.asset(
            "assets/splash_screen/background.png", // 🔥 Set your background image
            fit: BoxFit.cover,
          ),
        ),

        Column(
          children: [
            // 🔍 Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Discover your Foodality",
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFFC50102), // 🔴 Red when tapped
                      width: 2.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                cursorColor: Color(0xFFC50102),
                onChanged: _filterRestaurants,
              ),
            ),

            // 📍 Swipe Cards
            Expanded(
              child: _searchController.text.isNotEmpty
                  ? _buildSearchResults()
                  : CardSwiper(
                      controller: _swiperController,
                      allowedSwipeDirection:
                          AllowedSwipeDirection.symmetric(horizontal: true),
                      onSwipe: (previousIndex, targetIndex, direction) {
                        if (direction == CardSwiperDirection.right) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantDetails(
                                restaurant: restaurants[previousIndex],
                              ),
                            ),
                          );
                        }
                        return true;
                      },
                      cardsCount: restaurants.length,
                      cardBuilder: (context, index, _, __) {
                        return _buildRestaurantCard(restaurants[index]);
                      },
                    ),
            ),
          ],
        ),
      ],
    );
  }

  /// 🔍 **Search List**
  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: filteredRestaurants.length,
      itemBuilder: (context, index) {
        var restaurant = filteredRestaurants[index];
        return ListTile(
          leading: Image.asset(
            restaurant["image"],
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title:
              Text(restaurant["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("${restaurant["tags"].join(" • ")} • ${restaurant["distance"]}"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RestaurantDetails(restaurant: restaurant),
              ),
            );
          },
        );
      },
    );
  }

  /// 🎴 **Restaurant Card - Bigger & Cleaner**
  Widget _buildRestaurantCard(Map<String, dynamic> restaurant) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼 Larger Image
            Image.asset(
              restaurant["image"],
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 5 / 9, // **Takes up More Space**
              fit: BoxFit.cover,
            ),

            // 📌 Restaurant Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant["name"],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    restaurant["tags"].join(" • "),
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    restaurant["distance"],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC50102),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
