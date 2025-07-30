import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:elim_trust_2/services/auth_service.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage>
    with TickerProviderStateMixin {
  int _selectedIndex = 3;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late AnimationController _menuIconFeedbackController;
  late Animation<double> _menuIconRotationAnimation;
  String? _lastSelectedMenuItemValue;

  final AuthService _authService = AuthService();
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();

    // Initialize auth state
    _isSignedIn = _authService.isSignedIn;

    // Listen to auth state changes
    _authService.authStateChanges.listen((user) {
      setState(() {
        _isSignedIn = user != null;
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // Makes the animation loop back and forth

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.29).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _menuIconFeedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400), // Duration for the rotation
    );
    _menuIconRotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      // 0.0 to 1.0 for a full 360-degree turn
      CurvedAnimation(
          parent: _menuIconFeedbackController, curve: Curves.easeInOut),
    );
  }

  Future<void> _handleMenuSelection(String value) async {
    // Trigger the rotation feedback animation for the menu icon
    _menuIconFeedbackController.forward(from: 0.0);

    switch (value) {
      case 'signup_signin':
        if (_isSignedIn) {
          // If user is signed in, sign out and navigate to auth page
          await _authService.signOut();
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Successfully signed out')),
            );
            Navigator.pushNamed(context, '/auth');
          }
        } else {
          // If user is not signed in, navigate to auth page
          Navigator.pushNamed(context, '/auth');
        }
        break;
      case 'gallery_media':
        // Navigate to the gallery/media page
        Navigator.pushNamed(context, '/gallery');
        // print('Selected: Gallery/Media'); // Optional: keep for debugging
        break;
      case 'donate':
        Navigator.pushNamed(context, '/donations');
        break;

      case 'settings':
        Navigator.pushNamed(context, '/settings');
        break;
      case 'contact_us':
        // Navigate to the contact us page
        Navigator.pushNamed(context, '/contact');
        // print('Selected: Contact Us'); // Optional: keep for debugging
        break;
    }
    // Update the state to reflect the last selected item
    setState(() {
      _lastSelectedMenuItemValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: AppBar(
            backgroundColor: const Color.fromARGB(
                255, 4, 135, 242), // Optional: Added a background color
            centerTitle: true,
            title: ScaleTransition(
              scale: _scaleAnimation,
              child: const Text(
                'Community',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            //donation icon and label below it
            leading: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                //margin: const EdgeInsets.only(left: 8.0), // Reduced margin to fit AppBar's leading area
                height: 30, // Adjusted for a more standard icon button size
                width: 30, // Adjusted for a more standard icon button size
                decoration: BoxDecoration(
                  color: Colors.white, // Optional: Added a background color

                  borderRadius: BorderRadius.circular(
                      30), // Make it circular (half of height/width)
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.red,
                      blurRadius: 5.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  padding: EdgeInsets
                      .zero, // Remove default IconButton padding for better control
                  icon: const Icon(Icons.volunteer_activism,
                      color: Colors.blue, size: 24), // Standard icon size
                  onPressed: () {
                    //take to the donation page
                    Navigator.pushNamed(
                        context, '/donations'); // Corrected route
                  },
                ),
              ),
            ),
            //menu icon

            actions: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: PopupMenuButton<String>(
                  onSelected: _handleMenuSelection,
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'signup_signin',
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: _lastSelectedMenuItemValue == 'signup_signin'
                              ? Colors.red
                              : Colors.blue,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _isSignedIn ? Icons.logout : Icons.login,
                              color:
                                  _lastSelectedMenuItemValue == 'signup_signin'
                                      ? Colors.red
                                      : Colors.blue,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(_isSignedIn ? 'Sign Out' : 'Sign In'),
                          ],
                        ),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'gallery_media',
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: _lastSelectedMenuItemValue == 'gallery_media'
                              ? Colors.red
                              : Colors.blue,
                        ),
                        child: const Text('Gallery/Media'),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'donate',
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: _lastSelectedMenuItemValue == 'donate'
                              ? Colors.red
                              : Colors.blue,
                        ),
                        child: const Text('Donate/Support Us'),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'settings',
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: _lastSelectedMenuItemValue == 'settings'
                              ? Colors.red
                              : Colors.blue,
                        ),
                        child: const Text('Settings'),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'contact_us',
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: TextStyle(
                          color: _lastSelectedMenuItemValue == 'contact_us'
                              ? Colors.red
                              : Colors.blue,
                        ),
                        child: const Text('Contact Us'),
                      ),
                    ),
                  ],
                  tooltip: 'Open menu',
                  child: RotationTransition(
                    turns: _menuIconRotationAnimation,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 5.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.menu, color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          ), // Closing parenthesis for AppBar
        ), // Closing parenthesis for ClipRRect
      ), // Closing parenthesis for PreferredSize
      body: SingleChildScrollView(
        // Added SingleChildScrollView for vertical scrolling
        physics:
            const BouncingScrollPhysics(), // Optional: for a nice scroll effect
        child: Column(
          children: [
            const Padding(
              padding:
                  EdgeInsets.all(16.0), // Increased padding for better spacing
              child: Center(
                child: Text(
                  'Our Team 💞',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: 21.0, vertical: 8.0), // Added padding
              physics: const BouncingScrollPhysics(), // Optional
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Removed this
                children: [
                  _buildTeamMember('images/julia.png',
                      'Dr. Julia Kagunda\nExecutive Director'),
                  const SizedBox(width: 24), // Added explicit spacing
                  _buildTeamMember('images/stella.png',
                      'Ms. Stella Kihara\n   Board Member'),
                  const SizedBox(width: 24), // Added explicit spacing
                  _buildTeamMember('images/prof.png',
                      'Prof. Kennedy Kaduki\n  Board Member'),
                  const SizedBox(width: 24), // Added explicit spacing
                  _buildTeamMember(
                      'images/clara.png', 'Clara Gachoki\nPrograms Director'),
                  const SizedBox(width: 24), // Added explicit spacing
                  _buildTeamMember(
                      'images/james.png', 'Dr. James Mwangi\n  Board Member'),
                  const SizedBox(width: 24), // Added explicit spacing
                  _buildTeamMember(
                      'images/mercy.png', 'Mercy Wanjiru\nResearch director'),
                  // const SizedBox(width: 24), // Added explicit spacing
                  // _buildTeamMember('images/ben.png', 'Ben Mwangi'),
                ],
              ),
            ),
            const SizedBox(height: 8), // Increased space
            //grid view of the our impact section:
            const Padding(
              padding: EdgeInsets.all(8.0), // Increased padding
              child: Center(
                child: Text(
                  'Our Impact 🌍',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 8.0), // Added padding
              physics: BouncingScrollPhysics(), // Optional
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Removed this
                children: [
                  _AnimatedImpactCard(
                      title: 'Lives Transformed', valueString: '5000+'),
                  SizedBox(width: 16), // Added explicit spacing
                  _AnimatedImpactCard(
                      title: 'Projects Completed',
                      valueString: '75+'), // Example data
                  SizedBox(width: 16), // Added explicit spacing
                  _AnimatedImpactCard(
                      title: 'Volunteers Involved',
                      valueString: '2100+'), // Example data
                ],
              ),
            ),

            const SizedBox(height: 20), // Add some padding at the bottom
            const Center(
              child: Text(
                'Our Key Impact Pillars 🌟',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),

            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: 30.0, vertical: 3.0), // Added padding
              physics: const BouncingScrollPhysics(), // Optional
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Removed this
                children: [
                  GestureDetector(
                    onDoubleTap: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      child: SizedBox(
                        width: 220,
                        height: 200,
                        //padding: const EdgeInsets.all(16.0),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Research',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                'Our studies in climate change, mental health, planetary health and SRH don’t just generate data they are packaged to influence policies empower common …',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Added space between cards

                  GestureDetector(
                    onDoubleTap: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      child: SizedBox(
                        width: 220,
                        height: 200,
                        //padding: const EdgeInsets.all(16.0),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Capacity Building',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                'By training religious and community leaders, we create a network of skilled individuals capable of providing essential psychosocial support and …',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16), // Added space between cards
                  GestureDetector(
                    onDoubleTap: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 4,
                      child: SizedBox(
                        width: 220,
                        height: 200,
                        //padding: const EdgeInsets.all(16.0),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Implementation',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.all(3.0),
                              child: Text(
                                'Our programs like Y-PREP equip youth in vulnerable communities with psycho-resilience and entrepreneurial skills, unlocking their potential to lead …',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20), // Add some padding at the bottom
            const Center(
              child: Text(
                'Impact Stories ❤️',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                  horizontal: 30.0, vertical: 8.0), // Added padding
              physics: const BouncingScrollPhysics(), // Optional
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Removed this
                children: [
                  GestureDetector(
                    onDoubleTap: () {
                      //navigation:
                      Navigator.pushNamed(context, '/albert');
                    },
                    child: Card(
                      // color: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation:
                          8, // Slightly increased elevation for better pop
                      shadowColor: Colors.blueGrey.withOpacity(0.4),
                      child: Container(
                        // Added a Container for consistent padding and width
                        width: 280, // Define a width for the card
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Removed const
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('images/man1.png'),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Albert Ruabe',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .blue, // Changed to white for better contrast on blue
                              ),
                            ),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Mats Dialogue Participant',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontStyle: FontStyle.italic,
                                  //  textAlign: TextAlign.center,
                                  fontSize: 13, // Slightly smaller for role
                                  color: Color.fromARGB(255, 146, 196, 237),
                                ),
                              ),
                            ),
                            Center(
                              // Wrap the Row with a Center widget
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // To make the Row only as wide as its children
                                children: List.generate(
                                  5,
                                  (index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 24.0,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              'Through Y-PREP, I have grown in self-awareness and resilience.I\'ve learned to solve problems; not just for myself, but for my younger siblings and friends too. Despite ...',
                              textAlign: TextAlign.center,
                              maxLines: 4, // Limit lines to prevent overflow
                              overflow: TextOverflow
                                  .ellipsis, // Add ellipsis if text is too long
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Arial',
                                fontStyle: FontStyle.italic,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Added space between cards
                  GestureDetector(
                    // Second Impact Story Card
                    onDoubleTap: () {
                      //navigation:
                      Navigator.pushNamed(context, '/pastor');
                    },
                    child: Card(
                      // color: Colors.blue, // Removed color to match the first card (default white)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      shadowColor: Colors.blueGrey.withOpacity(0.4),
                      child: Container(
                        width: 280,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Changed to non-const to allow for variable image
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                  'images/pastor.png'), // Placeholder for different image
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Pastor Peter Kamau',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue, // Match first card
                              ),
                            ),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                // Removed redundant Center
                                'Spiritual Leadership Trainee', // Example role
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 13,
                                  color: Color.fromARGB(
                                      255, 146, 196, 237), // Match first card
                                ),
                              ),
                            ),
                            Center(
                              // Wrap the Row with a Center widget
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // To make the Row only as wide as its children
                                children: List.generate(
                                  5,
                                  (index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 24.0,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              // Example story text
                              'Seeing trauma in his congregation, Pastor Kamau joined Elim Trust\'s Leadership training. With new tools, he now fosters healing and resilience within his community, creating a supportive environment for all.',
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Arial',
                                fontStyle: FontStyle.italic,
                                color: Colors.black, // Match first card
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Added space between cards
                  GestureDetector(
                    // Third Impact Story Card
                    onDoubleTap: () {
                      Navigator.pushNamed(context, '/jane');
                    },
                    child: Card(
                      // color: Colors.blue, // Removed color to match the first card (default white)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 5,
                      shadowColor: Colors.blueGrey.withOpacity(0.4),
                      child: Container(
                        width: 280,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Changed to non-const to allow for variable image
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                  'images/girl.png'), // Placeholder for different image
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Jane Achieng ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue, // Match first card
                              ),
                            ),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                // Removed redundant Center
                                'Mats Dialogue Participant',
                                style: TextStyle(
                                  fontFamily: 'Arial',
                                  fontStyle: FontStyle.italic,
                                  fontSize: 13,
                                  color: Color.fromARGB(
                                      255, 146, 196, 237), // Match first card
                                ),
                              ),
                            ),

                            Center(
                              // Wrap the Row with a Center widget
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // To make the Row only as wide as its children
                                children: List.generate(
                                  5,
                                  (index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 24.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                                height:
                                    8), // Added some space between stars and text

                            const Text(
                              // Example story text
                              'At 17, Achieng faced trauma and isolation as a teen mother. Through Elim Trust\'s MATS Dialogue program, she found a supportive community, regained her confidence, and is now pursuing her education.',
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Arial',
                                fontStyle: FontStyle.italic,
                                color: Colors.black, // Match first card
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ), // Closes third GestureDetector
                ],
              ), // Closes Row for Impact Stories
            ),

            // Closes SingleChildScrollView for Impact Stories

            const SizedBox(height: 20), // Add some padding at the bottom
            const Center(
              child: Text(
                'Our Patners 🤝',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),

            const SizedBox(
                height: 20), // Added space between title and partners section

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior:
                  Clip.none, // Allow shadow to render outside the bounds
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 25, left: 10),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue, // Shadow color
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(
                              0, 0), // Set to (0,0) to show shadow on all sides
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'images/toronto.png',
                        fit: BoxFit.contain, // Changed fit to contain
                        height: 150, // Adjusted height
                        width: 150, // Adjusted width
                      ),
                    ), // Example image for a partner
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 25),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue, // Shadow color
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(
                              0, 0), // Set to (0,0) to show shadow on all sides
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'images/uon.png',
                          fit: BoxFit.contain, // Changed fit to contain
                          filterQuality: FilterQuality.high,
                          height: 130, // Adjusted height
                          width: 120, // Adjusted width
                        ),
                      ),
                    ), // Example image for a partner
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 25),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue, // Shadow color
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(
                              0, 0), // Set to (0,0) to show shadow on all sides
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'images/african women.png',
                        fit: BoxFit.contain, // Changed fit to contain
                        height: 150, // Adjusted height
                        width: 150, // Adjusted width
                      ),
                    ), // Example image for a partner
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 25),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue, // Shadow color
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(
                              0, 0), // Set to (0,0) to show shadow on all sides
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'images/un women.png',
                        fit: BoxFit.contain, // Changed fit to contain
                        height: 150, // Adjusted height
                        width: 150, // Adjusted width
                      ),
                    ), // Example image for a partner
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 25),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue, // Shadow color
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(
                              0, 0), // Set to (0,0) to show shadow on all sides
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'images/action aid.png',
                        fit: BoxFit.contain, // Changed fit to contain
                        height: 150, // Adjusted height
                        width: 150, // Adjusted width
                      ),
                    ), // Example image for a partner
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 25),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue, // Shadow color
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(
                              0, 0), // Set to (0,0) to show shadow on all sides
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        'images/center.png',
                        fit: BoxFit.contain, // Changed fit to contain
                        height: 150, // Adjusted height
                        width: 150, // Adjusted width
                      ),
                    ), // Example image for a partner
                  ),
                ],
              ),
            ),
          ], // Closes children of the main Column
        ),
      ), // Closes the main Column

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
              Icon(FontAwesomeIcons.peopleGroup, size: 30, color: Colors.white),
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
    ); // Closes the body's SingleChildScrollView
  }

  @override
  void dispose() {
    _animationController.dispose();
    _menuIconFeedbackController.dispose();
    super.dispose();
  }
}

// Helper widget for team members to reduce repetition
Widget _buildTeamMember(String imagePath, String name) {
  return Column(
    children: [
      CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(imagePath),
      ),
      const SizedBox(height: 8),
      Text(
        name,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.blue,
          fontFamily: 'Arial',
          fontStyle: FontStyle.italic,
        ),
      ),
    ],
  );
}

// StatefulWidget for the animated impact card
class _AnimatedImpactCard extends StatefulWidget {
  final String title;
  final String valueString;

  const _AnimatedImpactCard({
    required this.title,
    required this.valueString,
  });

  @override
  _AnimatedImpactCardState createState() => _AnimatedImpactCardState();
}

class _AnimatedImpactCardState extends State<_AnimatedImpactCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _targetValue = 0;
  String _suffix = '';

  @override
  void initState() {
    super.initState();

    // Parse the valueString to get the number and suffix
    final numericPart = widget.valueString.replaceAll(RegExp(r'[^0-9]'), '');
    if (numericPart.isNotEmpty) {
      _targetValue = int.tryParse(numericPart) ?? 0;
      _suffix = widget.valueString.replaceFirst(numericPart, '');
    } else {
      _targetValue = 0;
      _suffix = widget.valueString; // If no numbers, show original string
    }

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500), // Animation duration
      vsync: this,
    );

    // Determine the starting point for the animation (e.g., 85% of the target value)
    // This ensures the animation doesn't start from 0 if _targetValue is positive.
    double animationStartValue =
        _targetValue > 0 ? _targetValue.toDouble() * 0.85 : 0.0;

    _animation =
        Tween<double>(begin: animationStartValue, end: _targetValue.toDouble())
            .animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    )..addListener(() {
            setState(() {}); // Rebuild widget on animation ticks
          });

    _controller.addStatusListener((status) {
      if (!mounted) return; // Ensure widget is still in the tree

      if (status == AnimationStatus.completed) {
        // Finished counting up
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            _controller.reverse();
          }
        });
      } else if (status == AnimationStatus.dismissed) {
        // Finished counting down
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            _controller.forward();
          }
        });
      }
    });

    // Start the first animation cycle after an initial 2-second delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      width: 170,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // Optional: add a little shadow for depth
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0), // Adjusted padding
              child: Text(
                '${_animation.value.toInt()}$_suffix', // Display animated value + suffix
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
