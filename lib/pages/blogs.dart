import 'dart:io'; // Required for File operations


import 'package:elim_trust_2/pages/searchpageblogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle; // Required for rootBundle
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// Required for OpenFile
import 'package:path_provider/path_provider.dart'; // Required for getTemporaryDirectory
import 'package:url_launcher/url_launcher.dart'; // Required for launching URLs

class BlogsPage extends StatefulWidget {
  const BlogsPage({super.key});

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> with TickerProviderStateMixin {
  //  int _selectedIndex = 0; // Define _selectedIndex with an initial value
    int _selectedIndex = 3; // Define _selectedIndex2 with an initial value
    late AnimationController _menuIconFeedbackController;
    late Animation<double> _menuIconRotationAnimation;
    String? _lastSelectedMenuItemValue; // To store the value of the last tapped menu item

  @override
  void initState() {
    super.initState();

    _menuIconFeedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400), // Duration for the rotation
    );
    _menuIconRotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate( // 0.0 to 1.0 for a full 360-degree turn
      CurvedAnimation(parent: _menuIconFeedbackController, curve: Curves.easeInOut),
    );
  }

  void _handleMenuSelection(String value) {
    // Trigger the rotation feedback animation for the menu icon
    _menuIconFeedbackController.forward(from: 0.0);

    switch (value) {
      // Navigation logic remains the same
      case 'signup_signin':
        // Navigate to the authentication page (Sign Up/Sign In)
        Navigator.pushNamed(context, '/auth');
        // print('Selected: Sign Up/Sign In'); // Optional: keep for debugging
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
            backgroundColor: const Color.fromARGB(255, 4, 135, 242),
            centerTitle: true,
            title: const Text(
              'Our Blogs ✍️',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 40,
                width: 40,
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
                alignment: Alignment.center, // Center the icon within the container
                child: IconButton(
                  icon: const Icon(Icons.volunteer_activism, color: Colors.blue, size: 24),
                  padding: EdgeInsets.zero, // Remove default padding
                  constraints: const BoxConstraints(), // Remove default constraints
                  onPressed: () {
                    Navigator.pushNamed(context, '/donations');
                  },
                ),
              ),
            ),
            actions: [
         Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: PopupMenuButton<String>(
                      onSelected: _handleMenuSelection,
                      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'signup_signin',
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              color: _lastSelectedMenuItemValue == 'signup_signin' ? Colors.red : Colors.blue,
                              // Add other consistent style properties if needed, e.g., fontSize
                            ),
                            child: const Text('Sign Up/Sign In'),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'gallery_media',
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              color: _lastSelectedMenuItemValue == 'gallery_media' ? Colors.red : Colors.blue,
                            ),
                            child: const Text('Gallery/Media'),
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'donate',
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              color: _lastSelectedMenuItemValue == 'donate' ? Colors.red : Colors.blue,
                            ),
                            child: const Text('Donate/Support Us'),
                          ),
                        ),

                          PopupMenuItem<String>(
                          value: 'settings',
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              color: _lastSelectedMenuItemValue == 'settings' ? Colors.red : Colors.blue,
                            ),
                            child: const Text('Settings'),
                          ),
                        ),
                        
                      
                        PopupMenuItem<String>(
                          value: 'contact_us',
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              color: _lastSelectedMenuItemValue == 'contact_us' ? Colors.red : Colors.blue,
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
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // No need to define screenWidth variable here if used only once directly,
          // but if used multiple times, defining it at the start of the build method
          // `final screenWidth = MediaQuery.of(context).size.width;` would be good practice.
          children: [
            // Search Bar Section
            GestureDetector(
              onTap: () {
                // Add functionality for the search bar tap here
              },
              child: Container(
                margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue,
                      // Colors.blue, // Redundant
                      Color.fromARGB(255, 10, 21, 228),
                      Colors.blue,
                      // Colors.blue, // Redundant
                    ],
                  ),
                ),
                child: GestureDetector(
                     onTap: () {
                  // Add functionality for the search bar tap here
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Searchpageblogs()),
                  );
                     },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.search_rounded, color: Colors.white, size: 30),
                      const SizedBox(width: 8.0),
                      Text( // Removed 'const' as GoogleFonts style is not constant
                  'Search for blogs...',
                  style: GoogleFonts.dancingScript(
                    fontSize: 19,
                    color: Colors.white, // Note: Consider changing for better contrast
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                                ),
                    ],
                  ),
                ),
              ),
            ),
            // News Content Section

            GestureDetector(
              onTap: () {
                // Add functionality for the blog post tap here
                Navigator.pushNamed(context, '/story'); // Corrected route
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
                children: [
                  Expanded( // Allow text column to take available space and wrap text
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, // Align text to the left
                      children: [
                        Text(
                          'Story',
                          style: GoogleFonts.dancingScript(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 132, 181, 221),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4.0, right: 8.0,left: 8.0),// Adjusted padding
                          child: Text(
                            '''I remember stumbling upon Elim Trust Blogs dur...''',
                            style: TextStyle( // Made const
                              fontSize: 18, // Adjusted for balance
                              color: Color.fromARGB(255, 33, 133, 214),
                            ),
                            maxLines: 3, // Limit lines for summary
                            overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Spacer removed as Expanded widget handles space distribution
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 12.0), // Provide spacing from text and screen edge
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25, // Image width as 25% of screen width
                      child: AspectRatio(
                        aspectRatio: 1.0, // For a square image (width:height = 1:1)
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage('images/testimony.jpg'), // Ensure path is correct and in pubspec.yaml
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [ // Consider a softer shadow
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5.0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add functionality for the button here
                      Navigator.pushNamed(context, '/readmoreblogs');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: const Text(
                      'Read More 👇',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
            ),

            const SizedBox(height: 20.0), // Add some space between the button and the bottom navigation bar
             GestureDetector(
              onTap: () {
                // Add functionality for the blog post tap here
                Navigator.pushNamed(context, '/secondreadmoreblogs'); // Corrected route
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
                children: [
                  Expanded( // Allow text column to take available space and wrap text
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, // Align text to the left
                      children: [
                        Text(
                          'Article',
                          style: GoogleFonts.dancingScript(
                            fontSize: 20,
                            color: const Color.fromARGB(255, 132, 181, 221),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 4.0, right: 8.0,left: 8.0),// Adjusted padding
                          child: Text(
                            ''' Hope in Action: How Elim Trust is Changing Lives, One Step at a Time.At Elim Trust Orga...''',
                            style: TextStyle( // Made const
                              fontSize: 18, // Adjusted for balance
                              color: Color.fromARGB(255, 33, 133, 214),
                            ),
                            maxLines: 3, // Limit lines for summary
                            overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Spacer removed as Expanded widget handles space distribution
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 12.0), // Provide spacing from text and screen edge
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25, // Image width as 25% of screen width
                      child: AspectRatio(
                        aspectRatio: 1.0, // For a square image (width:height = 1:1)
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage('images/changedlife.jpg'), // Ensure path is correct and in pubspec.yaml
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [ // Consider a softer shadow
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: 5.0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add functionality for the button here
                      Navigator.pushNamed(context, '/secondreadmoreblogs');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: const Text(
                      'Read More 👇',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
            ),

            const SizedBox(height: 400.0), // Add some space between the button and the bottom navigation bar
          ],
        ),
      ),
      // Move the bottomNavigationBar here, outside the body
      bottomNavigationBar: SizedBox(
        height: 150, // You can adjust this value to your desired height
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // This is fine, SizedBox will control the outer height
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0), // Adjusted padding
                child: Text(
                  'Live. Love. Live.',
                  style: GoogleFonts.dancingScript(
                    textStyle: const TextStyle(
                      fontSize: 16, // Slightly increased font size
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(
                color: Colors.blue,
                thickness: 1,
                indent: 16, // Padding on the left
                endIndent: 16,
              ),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 4),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 5.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.phone, color: Colors.white)),
                  ),
                  const SizedBox(width: 4), // Spacing between icon a nd text
                  const Text('+254 705 558 885', // Made const
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    )),
                  const Spacer(), // Spacing between phone and email
                  Padding(
                        padding: const EdgeInsets.only( right: 4),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                                   onTap: () async {
                              const String emailAddress = 'info@elim-trust.org';
                              final Uri emailLaunchUri = Uri(
                                scheme: 'mailto',
                                path: emailAddress,
                                // You can also pre-fill subject and body if needed:
                                // queryParameters: {
                                //   'subject': 'Inquiry from App User',
                                //   'body': 'Hello Elim Trust,\n\nI have a question...'
                                // }
                              );

                              if (!await launchUrl(emailLaunchUri)) {
                                print('Could not launch $emailLaunchUri');
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Could not open email app for $emailAddress. Please ensure an email app is configured.'),
                                    ),
                                  );
                                }
                               }
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.red,
                                    blurRadius: 5.0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.email_rounded, color: Colors.white)),
                          ),
                        ),
                  ),
                  const SizedBox(width: 4), // Spacing between icon and text
                  const Padding( // Made const
                      padding: EdgeInsets.only(right: 20),
                      child: Text('info@elim-trust.org',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10), // Spacing between rows
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Changed to spaceEvenly for better distribution
                children: [ 
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.linkedin, color: Colors.blue),
                    onPressed: () async {
                      // Replace with your LinkedIn URL
                      final Uri url = Uri.parse('https://www.linkedin.com/in/elim-trust-org/?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app'); 
                      if (!await launchUrl(url)) {
                        print('Could not launch $url');
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.instagram, color: Colors.blue),
                    onPressed: () async {
                      // Replace with your Instagram URL
                      final Uri url = Uri.parse('https://www.instagram.com/elimtrustorg?igsh=d2Q5djF1OGdmODJz&utm_source=qr');
                      if (!await launchUrl(url)) {
                        print('Could not launch $url');
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.xTwitter, color: Colors.blue),
                    onPressed: () async {
                      final Uri url = Uri.parse('https://x.com/elim_trust_org?s=21');
                      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                        // Optionally show a snackbar or dialog to the user
                        print('Could not launch $url');
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Could not open link: $url')),
                          );
                        }
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.blue),
                    onPressed: () async {
                      // Example: Launch WhatsApp (replace with your specific link or number)
                      // For a specific number: 'https://wa.me/1XXXXXXXXXX' (international format)
                      // Or a general link: 'https://whatsapp.com/'
                      const String whatsappNumber = '254705558885'; // Elim Trust WhatsApp number
                      final Uri url = Uri.parse('https://wa.me/$whatsappNumber');
                      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                        print('Could not launch $url');
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Could not open WhatsApp for $whatsappNumber. Please ensure WhatsApp is installed.')),
                          );
                        }
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.facebook, color: Colors.blue),
                    onPressed: () async {
                      // Replace with your Facebook page URL
                      final Uri url = Uri.parse('https://www.facebook.com/ElimTrustOrg/'); 
                      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                        print('Could not launch $url');
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Could not open Facebook: $url')),
                          );
                        }
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.locationDot, color: Colors.red),
                    onPressed: () async {
                      // Example: Open Google Maps with a specific location
                      // You can use a query string for a place name or coordinates
                      final Uri url = Uri.parse('https://maps.google.com/?q=Elim+Trust+Nairobi'); // Example query
                      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                        print('Could not launch $url');
                        // Add SnackBar for error if needed
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
