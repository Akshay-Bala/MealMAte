import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealmate/Screens/login.dart';

class DeliveryboyAccount extends StatefulWidget {
   DeliveryboyAccount({super.key});

  @override
  _DeliveryBoyProfileState createState() => _DeliveryBoyProfileState();
}

class _DeliveryBoyProfileState extends State<DeliveryboyAccount> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();

  bool _isEditing = false; // Track if we are in edit mode

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("Delivery_boy").doc(user.email).get();
      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        _nameController.text = data["Name"];
        _emailController.text = data["Email"];
        _placeController.text = data["Phone number"];
      }
    }
  }

  Future<void> _updateProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Map<String, dynamic> data = {
        "Name": _nameController.text,
        "Email": _emailController.text,
        "Place": _placeController.text,
      };

      try {
        await FirebaseFirestore.instance.collection("Delivery_boy").doc(user.email).update(data);
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Profile updated successfully")));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Update failed: ${e.toString()}")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlueAccent, Colors.purpleAccent.withOpacity(0.5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top section with icon
                  Container(
                    padding:  EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child:  Icon(
                      Icons.delivery_dining,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                   SizedBox(height: 30),

                  // Form Section
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Name Field
                        buildInputField(
                          controller: _nameController,
                          label: currentuserdata['name'],
                          icon: Icons.person,
                          enabled: _isEditing,
                          validator: (value) => value == null || value.isEmpty ? 'Enter your name' : null,
                        ),
                         SizedBox(height: 16),

                        // Email Field
                        buildInputField(
                          controller: _emailController,
                          label: currentuserdata['email'],
                          icon: Icons.email,
                          enabled: false, // Email should be read-only
                          validator: (value) => value == null || value.isEmpty ? 'Enter a valid email' : null,
                        ),
                         SizedBox(height: 16),

                        // Phone Field
                        buildInputField(
                          controller: _placeController,
                          label: currentuserdata['place'],
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          enabled: _isEditing,
                          validator: (value) => value == null || value.isEmpty ? 'Enter your phone number' : null,
                        ),
                         SizedBox(height: 24),

                        // Edit/Save Button
                        ElevatedButton(
                          onPressed: () {
                            if (_isEditing) {
                              if (formKey.currentState!.validate()) {
                                _updateProfile();
                              }
                            }
                            setState(() {
                              _isEditing = !_isEditing; // Toggle editing state
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.shade800,
                            padding:  EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            _isEditing ? 'Save Changes' : 'Edit Profile',
                            style:  TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                         SizedBox(height: 20),

                        // Logout Button
                        TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.pop(context); // Go back to login screen
                          },
                          child:  Text(
                            'Logout',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
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

  // Input Field Helper Function
  Widget buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    bool enabled = true,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        prefixIcon: Icon(icon, color: Colors.green.shade800),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }
}