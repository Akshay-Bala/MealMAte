
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Deliveryboysignup extends StatefulWidget {
  
  const Deliveryboysignup({super.key});

  @override
  _DeliveryboysignupState createState() => _DeliveryboysignupState();
}

class _DeliveryboysignupState extends State<Deliveryboysignup> {
   final form_key = GlobalKey<FormState>();
  // Controllers for each text field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Top section with a rounded corner
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange.shade900,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Form Section
              Form(
                key: form_key,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Name Field
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                
                      // Email Field
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                
                      // Phone Field
                      TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: "Phone No",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                
                      // Password Field
                      TextField(
                        controller: _passwordController,
                        obscureText: true, // Hide password input
                        decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                
                      // Register Button
                      ElevatedButton(
                        onPressed: () async{
                        if (form_key.currentState!.validate()){
                          print('started');
                         Map<String, dynamic> data = {
                  "Name": _nameController.text,
                  "email": _emailController.text,
                  "Phone number": _phoneController.text,
                 // "Password": _passwordController.text,
                };
                
                          print(data);
                          await Deliveryboy_signup(context, data,
                              _emailController.text, _passwordController.text);
                
                          // Add your signup logic here
                        }
                      },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade900,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}





final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore Fstore = FirebaseFirestore.instance;
// final FirebaseStorage storage = FirebaseStorage.instance; 

Future<void> Deliveryboy_signup(BuildContext context,data,String eMail,String passWord,) async {
  try {
try {
   UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: eMail, password: passWord);   
  
} catch (e) {
  print(e);
  
}
   

    await Fstore.collection("Delivery_boy").doc(eMail).set(data);
   

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("User registered successfully")));
        Navigator.pop(context);
  } catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Registration failed: ${e.toString()}")),
    );
    print(e);
  }
}

