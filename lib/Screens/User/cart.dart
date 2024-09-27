import 'package:flutter/material.dart';
import 'package:mealmate/Screens/User/paymentoption.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
          backgroundColor: Colors.deepOrange.shade500,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: const Text('name'),
                  subtitle: const Text("Price"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {},
                      ),
                      const Text("quantity"),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: totalAmount",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
               
              ],
            ),
            
          ),
           Padding(
             padding: const EdgeInsets.all(20),
             child: InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Payment(),));
             },
               child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green[400]
               
                ),
                child: Center(child: Text("Pay",style: TextStyle(color: Colors.white),)),
               ),
             ),
           )
        ],
      ),
    );
  }
}
