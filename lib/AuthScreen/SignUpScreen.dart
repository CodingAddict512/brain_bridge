import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import '../widgets/user_image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? _selectedImage;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.cyan],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              // Profile Image Picker
              UserImagePicker(
                onPickImage: (pickedImage) {
                  setState(() {
                    _selectedImage = pickedImage;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                "Create Your Account",
                style: GoogleFonts.poppins(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black87
                      : Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Sign up to get started",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black87
                      : Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              // First Name Field
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.person, color: Colors.blueAccent),
                  hintText: "Enter First Name",
                  filled: true,
                  // fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First name is required';
                  } else if (value.length < 3) {
                    return 'First name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Last Name Field
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.person, color: Colors.blueAccent),
                  hintText: "Enter Last Name",
                  filled: true,
                  // fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Last name is required';
                  } else if (value.length < 3) {
                    return 'Last name must be at least 3 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Email Field
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email, color: Colors.blueAccent),
                  hintText: "Enter Email Address",
                  filled: true,
                  // fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  } else if (!EmailValidator.validate(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              // Password Field
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
                  hintText: "Enter Password",
                  filled: true,
                  // fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Password is required';
                //   } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}\$')
                //       .hasMatch(value)) {
                //     return 'Password must be at least 8 characters, include letters and numbers';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 15),
              // Confirm Password Field
              TextFormField(
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock, color: Colors.blueAccent),
                  hintText: "Confirm Password",
                  filled: true,
                  // fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please confirm your password';
                //   } else if (value != _passwordController.text) {
                //     return 'Passwords do not match';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 30),
              // Sign Up Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                ),
                onPressed: _submitSignUpForm,
                // () {
                //   if (_formKey.currentState!.validate()) {
                //     // Add sign-up functionality
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(content: Text('Sign-up successful!')),
                //     );
                //   }
                // },
                child: _isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: 18,
                        ),
                      ),
              ),
              const SizedBox(height: 20),
              // Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black87
                          : Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  bool _isLoading = false;
  Future<void> _submitSignUpForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Create user with Firebase Auth
      final authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      final userId = authResult.user!.uid;

      print("✅ Firebase Auth: User created with UID: $userId");

      // 2. Save user data to Firestore (no image)
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'email': _emailController.text.trim(),
        'created_at': Timestamp.now(),
      });

      print("✅ Firestore: User data saved successfully for UID: $userId");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-up successful!')),
      );

      // Optional: Navigate to home screen
      // Navigator.pushReplacement(...);
    } catch (error) {
      print("❌ Error during sign-up: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${error.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
