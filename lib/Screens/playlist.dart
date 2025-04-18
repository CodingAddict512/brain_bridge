import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final List<String> languages = [
    'Flutter',
    'C++',
    'Python',
    'Laravel',
    'React Native'
  ];
  String selectedLanguage = 'Flutter';

  final List<Map<String, String>> playlists = [
    {
      'title': 'Flutter Basics Tutorial',
      'description': 'Learn Flutter from scratch.',
      'url': 'https://www.youtube.com/watch?v=fq4N0hgOWzU',
      'videoId': 'fq4N0hgOWzU',
    },
    {
      'title': 'Flutter State Management',
      'description': 'Understand state management in Flutter.',
      'url': 'https://www.youtube.com/watch?v=d_m5csmrf7I',
      'videoId': 'd_m5csmrf7I',
    },
    {
      'title': 'C++ Basics for Beginners',
      'description': 'Start learning C++ programming.',
      'url': 'https://www.youtube.com/watch?v=mUQZ1qmKlLY',
      'videoId': 'mUQZ1qmKlLY',
    },
    {
      'title': 'Advanced C++ Techniques',
      'description': 'Explore advanced concepts in C++.',
      'url':
          'https://youtube.com/playlist?list=PLfVsf4Bjg79AxxmZwARAh3J9SHNGarty8&si=U7UU-h5PZl5FF3Pr',
      'videoId': 'tFYRTWFXSgY',
    },
    {
      'title': 'Python Programming Tutorial',
      'description': 'Master Python programming.',
      'url': 'https://www.youtube.com/watch?v=_uQrJ0TkZlc',
      'videoId': '_uQrJ0TkZlc',
    },
    {
      'title': 'Laravel Crash Course',
      'description': 'Learn Laravel from basics to advanced.',
      'url': 'https://www.youtube.com/watch?v=MFh0Fd7BsjE',
      'videoId': 'MFh0Fd7BsjE',
    },
    {
      'title': 'React Native Basics',
      'description': 'Start developing mobile apps with React Native.',
      'url': 'https://www.youtube.com/watch?v=0-S5a0eXPoc',
      'videoId': '0-S5a0eXPoc',
    },
  ];

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playlist Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: playlists.length,
                itemBuilder: (context, index) {
                  final item = playlists[index];
                  final thumbnail =
                      'https://img.youtube.com/vi/${item['videoId']}/0.jpg';
                  return InkWell(
                    onTap: () => _launchURL(item['url']!),
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            child: Image.network(
                              thumbnail,
                              width: 120,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'] ?? '',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['description'] ?? '',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
