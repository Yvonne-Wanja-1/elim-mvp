import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true; // Initial state of the switch

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Row( // Added children property
              children: [
                 Padding(
                   padding: const EdgeInsets.only(left: 15.0, top: 16.0),
                   child: Container(
                        //margin: const EdgeInsets.only(left: 8.0), // Reduced margin to fit AppBar's leading area
                         height: 30, // Adjusted for a more standard icon button size
                         width: 30,  // Adjusted for a more standard icon button size
                        decoration: BoxDecoration(
                          color: Colors.blue, // Optional: Added a background color
                          
                          borderRadius: BorderRadius.circular(30), // Make it circular (half of height/width)
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.red,
                              blurRadius: 5.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero, // Remove default IconButton padding for better control
                          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24), // Standard icon size
                          onPressed: () {
                            //take to the donation page
                            //Navigator.pushNamed(context, '/donations'); // Corrected route
                            Navigator.pop(context); // Go back to the previous page
                          },
                        ),
                      ),

                 ),

                const Expanded( // 1. Wrap with Expanded
                  child: Center(
                   // padding: EdgeInsets.only(left: 8.0, top: 16.0),
                    child: Text(
                      'Settings 🛠️',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                const SizedBox( // 2. Add SizedBox to balance the leading widget
                  width: 30.0 + 15.0, // Width of back button container + left padding
                ),

                
              ],
            ),

SizedBox(height: 24,),

    Padding(
      padding: const EdgeInsets.only(left:12),
      child: Text('Notifications 🔔', 
      style: TextStyle(fontSize: 22, 
      fontWeight: FontWeight.bold,
      color: Colors.black), 
      //textAlign: TextAlign.center,
       ),
    ),
              
    SizedBox(height: 10),

Padding(
  padding: const EdgeInsets.only(left:12),
  child: Text('Push Notifications:', 
  style: TextStyle(fontSize: 16, 
 // fontWeight: FontWeight.bold,
 fontStyle: FontStyle.italic,
   color:  Colors.grey.shade700),
  ), 
   //textAlign: TextAlign.center,
   ),
          

 SizedBox(height: 16,),
 Padding(
  padding: const EdgeInsets.only(left: 12.0, right: 23.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
    children: [
      Expanded( // Wrap the Text widget with Expanded in order to use the remaining space
        child: Text('''Enable or disable push notifications for important updates, alerts and events''',
          style: TextStyle(
            fontSize: 14,
            color: Colors.blue,
          ),
        ),
      ),
      SizedBox(width: 16), // Add some spacing between text and switch
      // Switch widget for toggling notifications
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Switch(
                  value: _notificationsEnabled, // Use the state variable
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value; // Update the state
                    });
                  },
                  activeColor: Colors.blue, // Color when switch is on
                  inactiveThumbColor: Colors.grey, // Color of the thumb when off
                  inactiveTrackColor: Colors.grey.shade300, // Color of the track when off
                ),
              ),
    ],
  ),
),






SizedBox(height: 24,),
Padding(
      padding: const EdgeInsets.only(left:12),
      child: Text('Apperance 🌗', 
      style: TextStyle(fontSize: 22, 
      fontWeight: FontWeight.bold,
      color: Colors.black), 
      //textAlign: TextAlign.center,
       ),
    ),
              
    SizedBox(height: 10),

Padding(
  padding: const EdgeInsets.only(left:12),
  child: Text('App Theme:', 
  style: TextStyle(fontSize: 16, 
 // fontWeight: FontWeight.bold,
 fontStyle: FontStyle.italic,
   color:  Colors.grey.shade700),
  ), 
   //textAlign: TextAlign.center,
   ),
          

 SizedBox(height: 16,),
 Padding(
  padding: const EdgeInsets.only(left: 12.0, right: 23.0),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
    children: [
      Expanded( // Wrap the Text widget with Expanded in order to use the remaining space
        child: Text('''Choose between Light and Dark mode for the app''',
          style: TextStyle(
            fontSize: 14,
            color: Colors.blue,
          ),
        ),
      ),
      SizedBox(width: 16), // Add some spacing between text and switch
      // Switch widget for toggling notifications
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Switch(
                  value: _notificationsEnabled, // Use the state variable
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value; // Update the state
                    });
                  },
                  activeColor: Colors.blue, // Color when switch is on
                  inactiveThumbColor: Colors.grey, // Color of the thumb when off
                  inactiveTrackColor: Colors.grey.shade300, // Color of the track when off
                ),
              ),
    ],
  ),
),


SizedBox(height: 24,),
    Padding(
      padding: const EdgeInsets.only(left:12),
      child: Text('Account 🔐', 
      style: TextStyle(fontSize: 22, 
      fontWeight: FontWeight.bold,
      color: Colors.black), 
      //textAlign: TextAlign.center,
       ),
    ),

    SizedBox(height: 10),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:12.0),
          child: Text('Manage Account:',
            style: TextStyle(fontSize: 20,
          //  fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.blue),
          ),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right, 
          size: 60,
          color: Colors.blue),
          onPressed: () {
            // Navigate to account management page
            Navigator.pushNamed(context, '/manage_account');
          },
        ),
      ]
        
        ),
        //SizedBox(height: 3,),

         Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:12.0),
          child: Text('Change Password:',
            style: TextStyle(fontSize: 20,
          //  fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.blue),
          ),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right, 
          size: 60,
          color: Colors.blue),
          onPressed: () {
            // Navigate to account management page
            Navigator.pushNamed(context, '/change_password');
          },
        ),
      ]
        
        ),






        SizedBox(height: 24,),
    Padding(
      padding: const EdgeInsets.only(left:12),
      child: Text('Help and Support ❓', 
      style: TextStyle(fontSize: 22, 
      fontWeight: FontWeight.bold,
      color: Colors.black), 
      //textAlign: TextAlign.center,
       ),
    ),

    SizedBox(height: 10),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:12.0),
          child: Text('FAQs:',
            style: TextStyle(fontSize: 20,
          //  fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.blue),
          ),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right, 
          size: 60,
          color: Colors.blue),
          onPressed: () {
            // Navigate to account management page
            Navigator.pushNamed(context, '/faqs');
          },
        ),
      ]
        
        ),
        //SizedBox(height: 3,),

         Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:12.0),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/contact'),
            child: Text('Contact Support:',
              style: TextStyle(fontSize: 20,
            //  fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.blue),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigate to contact support page
            Navigator.pushNamed(context, '/contact');
          },
          child: IconButton(
            icon: Icon(Icons.chevron_right, 
            size: 60,
            color: Colors.blue),
            onPressed: () {
              // Navigate to account management page
              Navigator.pushNamed(context, '/contact');
            },
          ),
        ),
      ]
        
        ),


                 Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:12.0),
          child: Text('Feedback:',
            style: TextStyle(fontSize: 20,
          //  fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.blue),
          ),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right, 
          size: 60,
          color: Colors.blue),
          onPressed: () {
            // Navigate to account management page
            Navigator.pushNamed(context, '/feedback');
          },
        ),
      ]
        
        ),
        SizedBox(height: 34,),










          ],
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
    );
  }
}