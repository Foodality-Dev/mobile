import 'package:flutter/material.dart';

class RestaurantDetails extends StatelessWidget {
  final Map<String, dynamic> restaurant;
  const RestaurantDetails({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 🔥 Sticky AppBar with Restaurant Image
          SliverAppBar(
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                restaurant["image"],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),

          // 🔥 Restaurant Info
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Restaurant Name
                  Text(
                    restaurant["name"],
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),

                  // Tags (e.g. Japanese • Casual Dining)
                  Text(
                    restaurant["tags"].join(" • "),
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),

                  // Engagement Stats
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 4),
                      Text("4.5 (123 Reviews)", style: TextStyle(fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text(restaurant["distance"], style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Bio / Restaurant Description
                  Text(
                    "A cozy and authentic spot serving some of the best Japanese cuisine. Perfect for dates, groups, and solo diners.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),

                  SizedBox(height: 16),

                  // 🔥 Buttons (Follow, Message)
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text("Follow"),
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Icon(Icons.message),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // 🔥 Image Grid (User Submitted Photos)
                  Text("Photos", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),

          // 🔥 Instagram-like Image Grid
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  restaurant["image"],
                  fit: BoxFit.cover,
                ),
              ),
              childCount: 6, // Show 6 sample images
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
          ),
        ],
      ),
    );
  }
}
