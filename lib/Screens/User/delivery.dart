import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/Screens/User/Profile.dart';
import 'package:mealmate/Screens/User/menu.dart';

class Delivery extends StatelessWidget {
  Delivery({super.key});
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);
  final List<String> imgList = [
    "https://wallpaperaccess.com/full/826921.jpg",
    "https://wallpapercave.com/wp/wp7029319.jpg",
    "https://wallpaperaccess.com/full/767575.jpg",
    "https://wallpaperaccess.com/full/767265.jpg",
    "https://wallpapercave.com/wp/wp8329822.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          "MealMate",
          style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.location_on),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: const CircleAvatar(
              child: Text(
                "A",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Search bar
              Card(
                margin: const EdgeInsets.all(8.0),
                elevation: 4,
                shadowColor: Colors.grey,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search for food or restaurants",
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.redAccent.withOpacity(0.1),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Carousel Slider
              Container(
                height: 200,
                child: CarouselSlider(
                  items: imgList.map((item) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    height: double.infinity,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      _currentIndexNotifier.value = index;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Section Title
              const Text(
                "Popular Dishes",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.redAccent),
              ),
              const SizedBox(height: 10),

              // Grid of Dishes
              SizedBox(
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Menu()),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    "https://img.freepik.com/premium-photo/chicken-biryani-plate-isolated-white-background-delicious-spicy-biryani-isolated_667286-5772.jpg?w=2000",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Dish Name",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Restaurant Cards
              const Text(
                "Nearby Restaurants",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.redAccent),
              ),
              const SizedBox(height: 10),

              // Restaurant Card List
              Column(
                children: [
                  RestaurantCard(
                    restaurantName: "Hotel Rahmath",
                    imageUrl: "https://th.bing.com/th/id/OIP.ZaRCXNn4N1B6eMraYw0ZNQHaFj?rs=1&pid=ImgDetMain",
                  ),
                  RestaurantCard(
                    restaurantName: "Hotel Arya Bhavan",
                    imageUrl: "https://th.bing.com/th/id/OIP.JQupWRHVtrRFXJb_oHVVkgHaEo?rs=1&pid=ImgDetMain",
                  ),
                  RestaurantCard(
                    restaurantName: "Soofi Mandhi",
                    imageUrl: "https://i0.wp.com/foodntravel.in/wp-content/uploads/2022/12/3.jpg",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final String restaurantName;
  final String imageUrl;

  const RestaurantCard({Key? key, required this.restaurantName, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Menu()),
          );
        },
        child: Stack(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                color: Colors.white.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  restaurantName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
