import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealmate/Screens/User/Profile.dart';
import 'package:mealmate/Screens/User/menu.dart';
import 'package:mealmate/Screens/login.dart';

class Delivery extends StatelessWidget {
  Delivery({super.key});

  final List<String> imgList = [
    "https://wallpaperaccess.com/full/826921.jpg",
    "https://wallpapercave.com/wp/wp7029319.jpg",
    "https://wallpaperaccess.com/full/767575.jpg",
    "https://wallpaperaccess.com/full/767265.jpg",
    "https://wallpapercave.com/wp/wp8329822.jpg",
  ];

  // Method to fetch restaurants from Firebase
  Future<List<Map<String, dynamic>>> getRestaurants() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Hotels').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

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
            icon: CircleAvatar(
              child: Text(
                currentuserdata['name'][0],
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
                shadowColor: Colors.white,
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
                height: 200,
              
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  //   childAspectRatio: 0.75,
                  //   crossAxisSpacing: 10,
                  //   mainAxisSpacing: 10, crossAxisCount: 2,
                  // ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => const Menu()),
                      //   );
                      // },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image:  DecorationImage(
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

              // Nearby Restaurants Title
              const Text(
                "Nearby Restaurants",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.redAccent),
              ),
              const SizedBox(height: 10),

              // Fetch and display restaurants from Firestore
              FutureBuilder<List<Map<String, dynamic>>>(
                future: getRestaurants(), // Fetch restaurants
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error fetching restaurants"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No restaurants available"));
                  }

                  final restaurants = snapshot.data!;
                  return SizedBox(
                    height: 300, // Adjust the height as needed
                    child: ListView.builder(

                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurants[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 150,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: ListTile(
                                leading: Image.network(
                                  restaurant['imgUrl'] ?? '',
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.fitWidth,
                                ),
                                title: Text(restaurant['name'] ?? 'No Name',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                onTap: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  Menu(restname: restaurant['name'], restaddress: restaurant['address'], restemail: restaurant['email'] ?? 'No Email',)),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
