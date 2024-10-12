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
        backgroundColor: Colors.green.shade700,
        title:  Text(
          "MealMate",
          style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon:  Icon(Icons.location_on),
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon:  Icon(Icons.notifications),
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
           SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Search bar
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Search for food or restaurants",
                  suffixIcon:  Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.green.withOpacity(.2),
                ),
              ),
               SizedBox(height: 20),

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
               SizedBox(height: 20),

              // Section Title
               Text(
                "Popular Dishes",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
              ),
               SizedBox(height: 10),

              // Grid of Dishes
              SizedBox(
                height: 200,
              
                child: ListView.builder(
  scrollDirection: Axis.horizontal,
  itemCount: 8,
  itemBuilder: (context, index) {
    return GestureDetector(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // To align text to the start
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://img.freepik.com/premium-photo/chicken-biryani-plate-isolated-white-background-delicious-spicy-biryani-isolated_667286-5772.jpg?w=2000",
                height: 150,
                width: 200, // You can adjust the width to your requirement
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.broken_image, size: 150); // Placeholder for error
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(), // Show loading indicator
                  );
                },
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Dish Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  },
),

              ),
               SizedBox(height: 20),

              // Nearby Restaurants Title
               Text(
                "Nearby Restaurants",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
              ),
               SizedBox(height: 10),

              // Fetch and display restaurants from Firestore
              FutureBuilder<List<Map<String, dynamic>>>(
                future: getRestaurants(), // Fetch restaurants
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return  Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return  Center(child: Text("Error fetching restaurants"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return  Center(child: Text("No restaurants available"));
                  }

                  final restaurants = snapshot.data!;
                  return SizedBox(
                    height: 300, // Adjust the height as needed
                    child: ListView.builder(

                      itemCount: restaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurants[index];
                        return Padding(
                          padding:  EdgeInsets.all(8.0),
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
