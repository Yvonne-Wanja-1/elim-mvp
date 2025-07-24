import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';


class SecondReadmoreblogs extends StatefulWidget {
  const SecondReadmoreblogs({super.key});

  @override
  State<SecondReadmoreblogs> createState() => _SecondReadmoreblogsState();
}

class _SecondReadmoreblogsState extends State<SecondReadmoreblogs> {
  // A state variable to track whether the blog post is favorited.
  // In a real application, you would likely save this to a database or
  // local storage to persist the user's choice.
  bool _isFavorited = false;

  // This method is called when the favorite icon is tapped.
  void _toggleFavorite() {
    // setState rebuilds the widget with the new _isFavorited value.
    setState(() {
      _isFavorited = !_isFavorited;
    });

    // Show a confirmation message to the user for better feedback.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // Set the content to a Text widget with blue color and bold font weight.
        content: Text(
          _isFavorited ? 'Added to your favorites.' : 'Removed from your favorites.',
          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        duration: const Duration(seconds: 1),
        // Make the background transparent.
        backgroundColor: Colors.transparent,
        // Remove the shadow by setting elevation to 0.
        elevation: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Article',
          style: GoogleFonts.dancingScript(
            color: Colors.blue,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(10),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.red,
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
       
            Text(
              'By:  Elim Trust Org - Published on October 12,2024',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 20,),
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: (Image.asset('images/secondreadmore.jpg')),
              ),
            ),
  
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '''Hope in Action: How Elim Trust is Changing Lives, One Step at a Time at Elim Trust Organisation

At Elim Trust Organisation, hope is not just a word — it’s a promise of change. Each day, the dedicated team at Elim works tirelessly to uplift the vulnerable, restore dignity, and offer practical support where it is needed most. From providing food and clothing to supporting education and offering counseling, Elim Trust turns compassion into concrete action.

One of the most remarkable aspects of Elim Trust is its focus on empowering individuals and communities to break free from cycles of poverty and despair. Through skill-building workshops, mentorship programs, and community outreach initiatives, beneficiaries are not just given aid — they are equipped with tools to create lasting change in their own lives.

The impact is evident in the smiles of children who can now attend school, in families who have regained stability, and in communities that are learning to stand together in strength and unity. Every donation, every volunteer hour, and every act of kindness fuels this mission, making a tangible difference one step at a time.

Elim Trust Organisation continues to inspire hope — proving that when people come together with compassion and purpose, no challenge is too great to overcome.''',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
           
        // ...existing code...
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the row
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Replaced ElevatedButton with OutlinedButton.icon for a cleaner look.
                  OutlinedButton.icon(
                    onPressed: () {
                      // The title of the blog post to be shared.
                      // In a real app, this would be passed dynamically to the widget.
                      const String blogTitle =
                          'A Testimony of Hope and Healing';
                      // The main content of the blog post.
                      const String blogContent =
                          '''Hope in Action: How Elim Trust is Changing Lives, One Step at a Time at Elim Trust Organisation
              
              At Elim Trust Organisation, hope is not just a word — it’s a promise of change. Each day, the dedicated team at Elim works tirelessly to uplift the vulnerable, restore dignity, and offer practical support where it is needed most. From providing food and clothing to supporting education and offering counseling, Elim Trust turns compassion into concrete action.
              
              One of the most remarkable aspects of Elim Trust is its focus on empowering individuals and communities to break free from cycles of poverty and despair. Through skill-building workshops, mentorship programs, and community outreach initiatives, beneficiaries are not just given aid — they are equipped with tools to create lasting change in their own lives.
              
              The impact is evident in the smiles of children who can now attend school, in families who have regained stability, and in communities that are learning to stand together in strength and unity. Every donation, every volunteer hour, and every act of kindness fuels this mission, making a tangible difference one step at a time.
              
              Elim Trust Organisation continues to inspire hope — proving that when people come together with compassion and purpose, no challenge is too great to overcome.''';
                      // A placeholder URL for the blog post.
                      const String blogUrl = 'https://elim-trust.org/blogs/testimony-of-hope';
                      // Construct the full text to be shared.
                      final String shareText =
                          '$blogTitle\n\n$blogContent\n\nRead more at: $blogUrl';
              
                      // Use the share_plus package to trigger the native sharing dialog.
                      Share.share(shareText, subject: blogTitle);
                    },
                    // Use a standard share icon for consistency.
                    icon: const Icon(Icons.share, color: Colors.blue, size: 20),
                    label: const Text(
                      'Share',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                      ),
                    ),
                    // Style the button to have a blue outline.
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.blue),
                    ),
                  ),
                        SizedBox(width: 30,),
                  IconButton(
                    // Call the _toggleFavorite method when the button is pressed.
                    onPressed: _toggleFavorite,
                    icon: Icon(
                      // Conditionally display a filled or bordered heart icon.
                      _isFavorited ? Icons.favorite : Icons.favorite_border,
                      // Conditionally set the color based on the favorite status.
                      color: _isFavorited ? Colors.red : Colors.red,
                      size: 24,
                    ),
                  ),
                   SizedBox(width: 30,),
                  ElevatedButton(
                    onPressed: () {
                 Navigator.pushNamed(context, '/donations');
                    },
                    child: const Text(
                      'Donate',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
// ...existing code...
            SizedBox(height: 34),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 150, // You can adjust this value to your desired height
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Expanded(
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // This is fine, SizedBox will control the outer height
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 3.0), // Adjusted padding
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
                      padding: const EdgeInsets.only(right: 4),
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
                                    content: Text(
                                        'Could not open email app for $emailAddress. Please ensure an email app is configured.'),
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
                              child: const Icon(Icons.email_rounded,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4), // Spacing between icon and text
                    const Padding(
                      // Made const
                      padding: EdgeInsets.only(right: 20),
                      child: Text(
                        'info@elim-trust.org',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
            
                // FloatingActionButton(
            
                //               onPressed: () {
                //                 // Add functionality for the WhatsApp button here
                //               },
                const SizedBox(height: 10), // Spacing between rows
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .center, // Changed to spaceEvenly for better distribution
                  children: [
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.linkedin,
                          color: Colors.blue),
                      onPressed: () async {
                        // Replace with your LinkedIn URL
                        final Uri url = Uri.parse(
                            'https://www.linkedin.com/in/elim-trust-org/?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app');
                        if (!await launchUrl(url)) {
                          print('Could not launch $url');
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.instagram,
                          color: Colors.blue),
                      onPressed: () async {
                        // Replace with your Instagram URL
                        final Uri url = Uri.parse(
                            'https://www.instagram.com/elimtrustorg?igsh=d2Q5djF1OGdmODJz&utm_source=qr');
                        if (!await launchUrl(url)) {
                          print('Could not launch $url');
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.xTwitter,
                          color: Colors.blue),
                      onPressed: () async {
                        final Uri url =
                            Uri.parse('https://x.com/elim_trust_org?s=21');
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) {
                          // Optionally show a snackbar or dialog to the user
                          print('Could not launch $url');
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Could not open link: $url')),
                            );
                          }
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.whatsapp,
                          color: Colors.blue),
                      onPressed: () async {
                        // Example: Launch WhatsApp (replace with your specific link or number)
                        // For a specific number: 'https://wa.me/1XXXXXXXXXX' (international format)
                        // Or a general link: 'https://whatsapp.com/'
                        const String whatsappNumber =
                            '254705558885'; // Elim Trust WhatsApp number
                        final Uri url =
                            Uri.parse('https://wa.me/$whatsappNumber');
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) {
                          print('Could not launch $url');
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Could not open WhatsApp for $whatsappNumber. Please ensure WhatsApp is installed.')),
                            );
                          }
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.facebook,
                          color: Colors.blue),
                      onPressed: () async {
                        // Replace with your Facebook page URL
                        final Uri url =
                            Uri.parse('https://www.facebook.com/ElimTrustOrg/');
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) {
                          print('Could not launch $url');
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Could not open Facebook: $url')),
                            );
                          }
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.locationDot,
                          color: Colors.red),
                      onPressed: () async {
                        // Example: Open Google Maps with a specific location
                        // You can use a query string for a place name or coordinates
                        final Uri url = Uri.parse(
                            'https://maps.google.com/?q=Elim+Trust+Nairobi'); // Example query
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) {
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
    );
  }
}
