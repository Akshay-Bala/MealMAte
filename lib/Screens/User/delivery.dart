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
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Home",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Address of Kozhikode",
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            )
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            Icons.location_on,
            color: Colors.deepOrange[500],
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(),
                  ));
            },
            child: const CircleAvatar(
              child: Text(
                "A",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(8.0),
                shadowColor: Colors.black,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    suffixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 120,
                          width: 150,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: NetworkImage(
                                  "https://wallpaperaccess.com/full/4622468.jpg",
                                ),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                        ),
                        const Text("Item Name")
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "WHAT'S ON YOUR MIND ? ? ? ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 120,
                          width: 150,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: NetworkImage(
                                  "https://img.freepik.com/premium-photo/chicken-biryani-plate-isolated-white-background-delicious-spicy-biryani-isolated_667286-5772.jpg?w=2000",
                                ),
                                fit: BoxFit.fill),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                        ),
                        const Text("Name of dish")
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(),
                  child: CarouselSlider(
                    items: imgList.map((item) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          item,
                          fit: BoxFit.fill,
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
                  )),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Menu(),
                        ));
                  },
                  child: Column(
                    children: [
                      Stack(children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            image: const DecorationImage(
                                image: NetworkImage(
                                  "https://th.bing.com/th/id/OIP.ZaRCXNn4N1B6eMraYw0ZNQHaFj?rs=1&pid=ImgDetMain",
                                ),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Positioned(
                          bottom: -1,
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12)),
                              color: Colors.white,
                            ),
                            child: Center(child: Text("data")),
                          ),
                        ),
                      ]),
                      Container(
                        height: 95,
                        width: 310,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Center(child: Text("Hotel Rahmath",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Menu(),
                        ));
                  },
                  child: Column(
                    children: [
                      Stack(children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            image: const DecorationImage(
                                image: NetworkImage(
                                  "https://th.bing.com/th/id/OIP.JQupWRHVtrRFXJb_oHVVkgHaEo?rs=1&pid=ImgDetMain",
                                ),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Positioned(
                          bottom: -1,
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12)),
                              color: Colors.white,
                            ),
                            child: Center(child: Text("data")),
                          ),
                        ),
                      ]),
                      Container(
                        height: 95,
                        width: 310,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Center(child: Text("Hotel Arya bhavan",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Menu(),
                        ));
                  },
                  child: Column(
                    children: [
                      Stack(children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            image: const DecorationImage(
                                image: NetworkImage(
                                  "https://i0.wp.com/foodntravel.in/wp-content/uploads/2022/12/3.jpg",
                                ),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Positioned(
                          bottom: -1,
                          child: Container(
                            height: 30,
                            width: 100,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12)),
                              color: Colors.white,
                            ),
                            child: Center(child: Text("data")),
                          ),
                        ),
                      ]),
                      Container(
                        height: 95,
                        width: 310,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Center(child: Text("Soofi Mandhi",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
