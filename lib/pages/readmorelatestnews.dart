import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Readmorelatestnews extends StatelessWidget {
  const Readmorelatestnews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blog Post',
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '''🌱 Prioritizing Mental Health: A Call for Awareness and Action''',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'By Sarah Johnson - Published on January 15,2025',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: (Image.asset('images/blogsmental.jpg')),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '💡 What is Mental Health?',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '''Mental health refers to our emotional, psychological, and social well-being. It influences how we think, feel, and act — and how we handle stress, relate to others, and make choices. Good mental health does not mean we are happy all the time, but that we have the strength and support to cope with life’s ups and downs.''',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '🚩 Why Mental Health Awareness Matters',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '''1 in 4 people will experience a mental health issue at some point in their lives.

Untreated mental health conditions can affect education, employment, relationships, and physical health.

Stigma and lack of information stop many people from seeking the help they need.

By raising awareness, we can break these barriers and create a community that cares.''',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '🧠 Common Mental Health Challenges',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '''Depression: Persistent sadness, loss of interest in activities, feelings of worthlessness.

Anxiety: Constant worry, fear, restlessness, and difficulty concentrating.

Stress: Feeling overwhelmed or unable to cope with pressure.

Trauma-related issues: Emotional wounds from past events that affect present well-being.''',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '🤝 How We Can Support Each Other',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '''✅ Listen without judgment — Sometimes, a listening ear is the best help.
✅ Encourage seeking help — Let’s normalize visiting a counselor or mental health professional.
✅ Be kind — Small acts of kindness can make a big difference to someone struggling.
✅ Educate yourself and others — The more we know, the better we can support.''',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () {
                const String blogTitle =
                    '🌱 Prioritizing Mental Health: A Call for Awareness and Action';
                const String blogUrl =
                    'https://www.elim-trust.org/blog/mental-health-awareness'; // A placeholder URL
                final String shareText =
                    'Check out this insightful blog post: "$blogTitle".\n\nRead more here: $blogUrl';

                Share.share(shareText,
                    subject: 'An Important Read on Mental Health');
              },
              icon: const Icon(Icons.share, color: Colors.blue, size: 20),
              label: const Text(
                'Share',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
              ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue),
              ),
            ),
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
