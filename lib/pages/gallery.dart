
import 'package:elim_trust_2/pages/donations.dart';
import 'package:elim_trust_2/pages/outreach.dart';
import 'package:elim_trust_2/pages/standbyme.dart';
import 'package:elim_trust_2/pages/training.dart';
import 'package:elim_trust_2/pages/vunjacala.dart';
import 'package:elim_trust_2/pages/yprepp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// Import the destination pages (these should be created separately)


class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  // Added 'page' to each item for navigation
  static const List<Map<String, dynamic>> galleryItems = [
    {
      'imagePath': 'images/training.jpg',
      'caption': 'Education Workshop',
      'page': TrainingPage(),
    },
    {
      'imagePath': 'images/outreach.jpg',
      'caption': 'Community Outreach',
      'page': OutreachPage(),
    },
    {
      'imagePath': 'images/yprepp.jpg',
      'caption': 'Y-PREP',
      'page': YpreppPage(),
    },
    {
      'imagePath': 'images/vunjaa.jpg',
      'caption': 'Vunja Calabash',
      'page': VunjacalaPage(),
    },
    {
      'imagePath': 'images/standbyme.jpg',
      'caption': 'Stand By Me',
      'page': StandbymePage(),
    },
    {
      'imagePath': 'images/donationss.jpg',
      'caption': 'Donations & Giving',
      'page': DonationsPage(),
    },
  ];

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late List<YoutubePlayerController> _controllers;

  final List<String> _youtubeUrls = [
    'https://youtu.be/rIsrPeYP0_U',
    'https://youtu.be/3W5ILEOZQ8g',
    'https://youtu.be/ZJG2Qd5FZmY',
    'https://youtu.be/A0FYzjLruaE',
    'https://youtu.be/NSLAP_KWDk0',
  ];

  final List<String> _videoTitles = [
    'Innovative approach to resource scarcity',
    'Water Security at Kalobeyei Camp',
    'Super Power',
    'Draught to disaster',
    'Introducing Elim Trust Organisation',
  ];

  @override
  void initState() {
    super.initState();
    _controllers = _youtubeUrls.map((url) {
      final videoId = YoutubePlayer.convertUrlToId(url) ?? '';
      return YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
      );
    }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.red,
                              blurRadius: 5.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          splashRadius: 24,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Gallery',
                        style: GoogleFonts.dancingScript(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  'Photo Gallery 📸',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore our collection of beautiful images 🙂',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 400,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: GalleryPage.galleryItems.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      final item = GalleryPage.galleryItems[index];
                      return GestureDetector(
                        // Added tap to navigate to a specific page
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => item['page'],
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  item['imagePath'],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, exception, stackTrace) {
                                    return const Center(
                                      child: Text('Failed to load image'),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item['caption'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.lato().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Video Gallery 📸',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore our collection of beautiful videos 🙂',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                    fontFamily: GoogleFonts.lato().fontFamily,
                  ),
                ),
                const SizedBox(height: 24),
                // Dynamically render video cards
                for (int i = 0; i < _controllers.length; i++) ...[
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 8.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: YoutubePlayer(
                      controller: _controllers[i],
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.blue,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.blue,
                        handleColor: Colors.blueAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _videoTitles[i],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontFamily: GoogleFonts.lato().fontFamily,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
