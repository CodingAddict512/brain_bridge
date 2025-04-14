import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  // Dropdown values for language selection
  final List<String> languages = [
    'Flutter',
    'C++',
    'Python',
    'Laravel',
    'React Native'
  ];
  String selectedLanguage = 'Flutter';

  // Map of playlists for each language
  final Map<String, List<Map<String, String>>> playlists = {
    'Flutter': [
      {
        'title': 'Flutter Basics Tutorial',
        'thumbnail':
            'https://img.youtube.com/vi/fq4N0hgOWzU/0.jpg', // Example thumbnail
        'url': 'https://youtu.be/eVm10iYZsiE?si=OVlqdWbqIfLncH19',
      },
      {
        'title': 'Flutter State Management',
        'thumbnail': 'https://img.youtube.com/vi/ljYFEOxMpiI/0.jpg',
        'url': 'https://www.youtube.com/watch?v=ljYFEOxMpiI',
      },
    ],
    'C++': [
      {
        'title': 'C++ Basics for Beginners',
        'thumbnail': 'https://img.youtube.com/vi/mUQZ1qmKlLY/0.jpg',
        'url': 'https://www.youtube.com/watch?v=mUQZ1qmKlLY',
      },
      {
        'title': 'Advanced C++ Techniques',
        'thumbnail': 'https://img.youtube.com/vi/3xI7DroCPLk/0.jpg',
        'url': 'https://www.youtube.com/watch?v=3xI7DroCPLk',
      },
    ],
    'Python': [
      {
        'title': 'Python Programming Tutorial',
        'thumbnail': 'https://img.youtube.com/vi/_uQrJ0TkZlc/0.jpg',
        'url': 'https://www.youtube.com/watch?v=_uQrJ0TkZlc',
      },
    ],
    'Laravel': [
      {
        'title': 'Laravel Crash Course',
        'thumbnail': 'https://img.youtube.com/vi/M9lF2AIv8fU/0.jpg',
        'url': 'https://www.youtube.com/watch?v=M9lF2AIv8fU',
      },
    ],
    'React Native': [
      {
        'title': 'React Native Basics',
        'thumbnail': 'https://img.youtube.com/vi/Emua4H_qtg8/0.jpg',
        'url': 'https://www.youtube.com/watch?v=Emua4H_qtg8',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    // Get the playlist for the selected language
    final List<Map<String, String>> currentPlaylist =
        playlists[selectedLanguage] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.cyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Playlist of FLutter",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.cyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Playlist of React Native",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.cyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Playlist of Laravel",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.cyan],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Playlist of Java Script",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
