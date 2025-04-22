import 'dart:async';
import 'package:brain_bridge_update/Onboarding.dart';
import 'package:brain_bridge_update/Screens/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AuthScreen/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize bouncing animation for the logo
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: 20).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );

    // Initialize sliding animation for the text
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from off-screen (bottom)
      end: const Offset(0, 0), // End at its original position
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _slideController.forward();

    // Initialize color transition animation for the background
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _colorAnimation = ColorTween(
      begin: const Color(0xFFFFF6F0), // Light orange
      end: const Color(0xFFFCEFEF), // Light pink
    ).animate(_colorController);

    // Set a timer for 10 seconds to navigate to the LoginPage
    // Timer(const Duration(seconds: 10), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => OnBoardingPage()),
    //   );
    // });
    _startNavigation();
  }

  void _startNavigation() async {
    bool firstRun = await IsFirstRun.isFirstRun();

    // Delay for splash screen
    await Future.delayed(const Duration(seconds: 3));

    if (firstRun) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingPage()),
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      final savedEmail = prefs.getString('user_email') ?? '';
      final savedPassword = prefs.getString('user_password') ?? '';

      if (savedEmail.isNotEmpty && savedPassword.isNotEmpty) {
        try {
          // Try Firebase login with saved credentials
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: savedEmail,
            password: savedPassword,
          );

          await prefs.setString('user_email', savedEmail);
          await prefs.setString('user_password', savedPassword);
          // Navigate to home screen on successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigationBarScreen()),
          );
        } on FirebaseAuthException catch (e) {
          // If login fails, go to LoginScreen
          print('Auto login failed: $e');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } else {
        // If no saved credentials, go to LoginScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _slideController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.cyan],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _bounceAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, -_bounceAnimation.value),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              "assets/images/logo.jpg",
                              fit: BoxFit.fill,
                              width: 200,
                              height: 200,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  SlideTransition(
                    position: _slideAnimation,
                    child: const Text(
                      "Loading, please wait...",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  PulsatingDots(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Pulsating Dots Indicator
class PulsatingDots extends StatefulWidget {
  const PulsatingDots({super.key});

  @override
  State<PulsatingDots> createState() => _PulsatingDotsState();
}

class _PulsatingDotsState extends State<PulsatingDots>
    with TickerProviderStateMixin {
  late AnimationController _dotController;
  late Animation<double> _dotAnimation;

  @override
  void initState() {
    super.initState();
    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _dotAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _dotController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _dotAnimation,
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                width: 10 * _dotAnimation.value,
                height: 10 * _dotAnimation.value,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEB5A1),
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
