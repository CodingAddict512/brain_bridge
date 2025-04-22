import 'package:brain_bridge_update/Screens/chatboat.dart';
import 'package:brain_bridge_update/Screens/playlist.dart';
import 'package:brain_bridge_update/Screens/profile.dart';
import 'package:brain_bridge_update/Screens/quiz.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    QuizScreen(),
    PlaylistScreen(),
    ChatboatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueAccent,
        color: Theme.of(context).cardColor,
        buttonBackgroundColor: Theme.of(context).cardColor,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.quiz, size: 30, color: Colors.blueAccent),
          Icon(Icons.playlist_play, size: 30, color: Colors.blueAccent),
          Icon(Icons.chat, size: 30, color: Colors.blueAccent),
          Icon(Icons.person, size: 30, color: Colors.blueAccent),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
