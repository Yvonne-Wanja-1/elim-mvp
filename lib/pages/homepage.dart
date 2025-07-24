import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// Data model for our impact cards
class _ImpactCardData {
  final String imagePath;
  final String title;
  final String description;

  const _ImpactCardData({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

// Reusable widget for displaying an impact card
class _ImpactCardWidget extends StatelessWidget {
  final _ImpactCardData data;
  final VoidCallback? onCardTap;

  const _ImpactCardWidget({
    required this.data,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Added InkWell for tap effect on the whole card
      onTap: onCardTap, // Use the onCardTap for the whole card
      splashColor: Colors.transparent, // Removes the splash effect
      highlightColor: Colors.transparent, // Removes the highlight effect
      hoverColor: Colors.transparent, // Removes the hover effect
      child: SizedBox(
        width: 300.0, // Set to fixed width matching the image container
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // Image container is fixed size
              height: 300,
              width: 300.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.blue,
                      blurRadius: 5.0,
                      offset: Offset(0, 2), // Shadow position

                      spreadRadius: 2.0, // Shadow spread
                    ),
                  ]),

              clipBehavior: Clip.antiAlias,
              child: Image.asset(data.imagePath,
                  fit: BoxFit.cover), // Image fills the 300x300 container
            ),
            const SizedBox(height: 8), // Space between image and text
            // Text content below the image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                data.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                ),
                textAlign:
                    TextAlign.center, // Consider if center is desired here
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4), // Space between title and description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                data.description,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Arial',
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// The HomePage widget remains a StatefulWidget to manage the selected index for the navigation bar.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // Static list of impact card data
  static final List<_ImpactCardData> _impactCardItems = [
    const _ImpactCardData(
      imagePath: 'images/t.png',
      title: 'Y-PREP',
      description:
          'Bridging trauma healing with entrepreneurship and climate action for youth in informal settlements',
    ),
    const _ImpactCardData(
      imagePath: 'images/dialog.png',
      title: 'Mats Dialogue',
      description:
          'Trauma healing-centred circles for teen mothers and women, rooted in African tradition and storytelling.',
    ),
    const _ImpactCardData(
      imagePath: 'images/equity.jpg',
      title: 'Vunja Kalabash',
      description:
          'Promoting gender equity through mental health and Sexual & Gender Based Violence intervention in learning institutions.',
    ),
    const _ImpactCardData(
      imagePath: 'images/capacity.jpg',
      title: 'Capacity Building of Spiritual & Community Leaders',
      description: 'Equipping leaders to create grassroots healing movements.',
    ),
  ];

  @override
  // Creates the mutable state for this widget.
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          // Provides a bouncing effect when scrolling reaches the end.
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.blue,
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  height: 250,
                  child: Image.asset(
                    'images/elimtrust.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              const Padding(
                // Padding for the section title
                padding: EdgeInsets.only(left: 16.0, top: 8.0),
                child: Text(
                  'Our Impact Programs:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                    fontStyle: FontStyle.italic,
                    color: Colors.blue,
                  ),
                ),
              ),
              // Horizontal scrollable list of impact cards
              const SizedBox(height: 4),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children:
                      HomePage._impactCardItems.asMap().entries.map((entry) {
                    int idx = entry.key;
                    _ImpactCardData data = entry.value;
                    VoidCallback? imageSpecificOnTap;

                    if (data.title == 'Y-PREP') {
                      imageSpecificOnTap = () {
                        Navigator.pushNamed(context, '/yprep');
                      };
                    } else if (data.title == 'Mats Dialogue') {
                      imageSpecificOnTap = () {
                        Navigator.pushNamed(context, '/matsdialogue');
                      };
                    } else if (data.title == 'Vunja Kalabash') {
                      imageSpecificOnTap = () {
                        Navigator.pushNamed(context, '/vunja');
                      };
                    } else if (data.title ==
                        'Capacity Building of Spiritual & Community Leaders') {
                      imageSpecificOnTap = () {
                        Navigator.pushNamed(context, '/capacity');
                      };
                    }

                    return Padding(
                      padding: EdgeInsets.only(
                          right: idx == HomePage._impactCardItems.length - 1
                              ? 0
                              : 16.0),
                      child: _ImpactCardWidget(
                        data: data,
                        onCardTap:
                            imageSpecificOnTap, // Changed from onImageTap to onCardTap
                      ),
                    );
                  }).toList(),
                ),
              ),
              // Latest News section header and button
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/latestnews');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 4, 135, 242),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Latest News',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial',
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text('😊',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 8), // Added spacing
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/latestnews');
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.only(top: 8, bottom: 2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 175, 211, 240),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image above text
                        Container(
                          height: 250,
                          // width: double.infinity, // Let the container take available width within padding/margin
                          margin: const EdgeInsets.symmetric(
                              horizontal:
                                  8.0), // Add horizontal margin to the image
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child:
                                Image.asset('images/UN.jpg', fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Text content below the image
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "🌍 UN H6 Joint Programme on RMNCAH (2015–2020):",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
                              decorationThickness: 2,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ), // Consider TextAlign.start if not centered
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          child: Text(
                            '''
                  In Mandera, we worked with adolescents and young mothers to advance reproductive and maternal health under this multi-agency initiative.''',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Arial',
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Our Blogs section header and button
              const SizedBox(height: 21),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/blogs');
                  },
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Also handle navigation here for clarity and direct button functionality
                          Navigator.pushNamed(context, '/blogs');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 4, 135, 242),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Our Blogs',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Arial',
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('😊',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8), // Added spacing
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/blogs');
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.only(top: 8, bottom: 2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 175, 211, 240),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image above text
                        Container(
                          height: 250,
                          // width: double.infinity, // Let the container take available width within padding/margin
                          margin: const EdgeInsets.symmetric(
                              horizontal:
                                  8.0), // Add horizontal margin to the image
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset('images/blogs.jpg',
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Text content below the image
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "✍️ By: Elim Insights",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
                              decorationThickness: 2,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ), // Consider TextAlign.start if not centered
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          child: Text(
                            '''
                  Harmful Traditional Practices (HTPs)''',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Arial',
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          child: Text(
                            '''
                  Some Gender Based Violence acts are perpetuated by Harmful Traditional Practices''',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Arial',
                              fontStyle: FontStyle.italic,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Add some padding at the very bottom if needed
              const SizedBox(height: 10),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: const Color.fromARGB(255, 4, 135, 242),
          height: 60,
          index: _selectedIndex,
          items: const <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.folder_open, size: 30, color: Colors.white),
                Text('Projects',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.italic)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.attach_money_rounded, size: 30, color: Colors.white),
                Text('Donations',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.italic)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home, size: 30, color: Colors.white),
                Text('Home',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.italic)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(FontAwesomeIcons.peopleGroup,
                    size: 30, color: Colors.white),
                Text('Community',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.italic)),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.person, size: 30, color: Colors.white),
                Text('Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.italic)),
              ],
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/projects');
                break;
              case 1:
                Navigator.pushNamed(context, '/donations');
                break;
              case 2:
                Navigator.pushNamed(context, '/home');
                break;
              case 3:
                Navigator.pushNamed(context, '/community');
                break;
              case 4:
                Navigator.pushNamed(context, '/profile');
                break;
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Direct WhatsApp link to Elim Trust
            const String whatsappNumber =
                '254705558885'; // Elim Trust WhatsApp number
            final Uri url = Uri.parse('https://wa.me/$whatsappNumber');
            if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                        'Could not open WhatsApp for $whatsappNumber. Please ensure WhatsApp is installed.')),
              );
              print('Could not launch $url');
            }
          },
          backgroundColor: Colors.green,
          tooltip: 'Chat on WhatsApp', // WhatsApp-like color
          child: const Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
        ),
      ),
      // The rest of the Scaffold properties like floatingActionButton can go here
    );
  }
}
