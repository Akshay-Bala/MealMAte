import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  Widget _buildInputField({
    required String hintText,
    required IconData icon,
  }) {
    return TextFormField(
      controller: _emailController,
      style: GoogleFonts.poppins(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          color: Colors.black26,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildSubmitBtn() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _sendResetLink,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: EdgeInsets.all(15),
        ),
        child: Text(
          "Submit",
          style: GoogleFonts.poppins(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> _sendResetLink() async {
    String email = _emailController.text.trim();
    if (email.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        title: 'Warning',
        text: 'Please enter your email.',
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Password reset link sent to $email. Check your inbox.',
        onConfirmBtnTap: () {},
      );
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Error: ${e.toString()}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.0),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                color: Colors.indigoAccent,
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Image.asset(
                "assets/pictures/forgot-password.png",
                height: MediaQuery.of(context).size.height * 0.25,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Forgot\nPassword?",
              style: GoogleFonts.poppins(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Don’t worry. Please enter the address associated with your account.",
              style: GoogleFonts.poppins(
                fontSize: 16.5,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 40.0),
            _buildInputField(
              hintText: "Email ID",
              icon: Icons.email,
            ),
            SizedBox(height: 50.0),
            _buildSubmitBtn(),
          ],
        ),
      ),
    );
  }
}
