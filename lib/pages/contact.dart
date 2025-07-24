import 'package:elim_trust_2/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white, // Ensure Scaffold background is white
        appBar: AppBar(
          backgroundColor: Colors.white, // Ensure AppBar background is white
          title: const Text('Contact Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              )),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.blue),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical, // Changed to vertical scrolling
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Text(
                    'Get in Touch',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                  '''We would love to hear from you! Please reach out with any questions, suggestions or feedback 😊.
                If you have any inquiries or need assistance, feel free to contact us through any of the following channels:''',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          
              const SizedBox(height: 20),
          
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween, // Uncommented this line
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 40, // Adjusted height for better appearance
                      width: 40, // Adjusted width for better appearance
          
                      //border radius:
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 5.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
          
                      child: const Icon(Icons.phone, color: Colors.white, size: 30),
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        'Call Us',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        ' +254 705 558 885',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          
              SizedBox(height: 20), // Spacing between rows
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween, // Uncommented this line
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 40, // Adjusted height for better appearance
                      width: 40, // Adjusted width for better appearance
          
                      //border radius:
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 5.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
          
                      child: const Icon(Icons.email, color: Colors.white, size: 30),
                    ),
                  ),
                  Column(
                    children: [
                      const Text(
                        'Email Us',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        ' info@elim-trust.org',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween, // Uncommented this line
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 40, // Adjusted height for better appearance
                      width: 40, // Adjusted width for better appearance
          
                      //border radius:
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.red,
                            blurRadius: 5.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
          
                      child: const Icon(Icons.location_on, color: Colors.white, size: 30),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 39.0),
                        child: const Text(
                          'Address',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text(
                        'Jacaranda drive 71, Mushroom Gardens, Kiambu, Kenya',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Text(
                    'Contact Form',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text(
                  'Your Name:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
             // const SizedBox(height: 10),
              Mytextfield(
                hintText: 'eg John Doe',
                labelText: 'Name',
               // helperText: 'Enter your full name',
               // errorText: 'Name cannot be empty',
                controller: TextEditingController(),
                prefixIcon: Icons.person,
                keyboardType: TextInputType.name,
              ),



              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text(
                  'Your Email:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
             // const SizedBox(height: 10),
              Mytextfield(
                hintText: 'eg john.doe@example.com',
                labelText: 'Email',
               // helperText: 'Enter your email address',
               // errorText: 'Email cannot be empty',
                controller: TextEditingController(),
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),


const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text(
                  'Subject :',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
             // const SizedBox(height: 10),
              Mytextfield(
                hintText: 'eg Inquiry about services',
                labelText: 'Subject',
          
                controller: TextEditingController(),
                prefixIcon: Icons.subject,
                keyboardType: TextInputType.name,
              ),


              
const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text(
                  'Message :',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

    // ...existing code...
Padding(
  padding: const EdgeInsets.all(10.0),
  child: TextField(
    controller: TextEditingController(),
    maxLines: 6,
    decoration: InputDecoration(
      hintText: 'Type your message here...',
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.blue, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.blue, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    ),
    style: const TextStyle(fontSize: 16),
  ),
),
// ...existing code...



Center(
  child: ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
    ),
    child: const Text('Submit', 
    style: TextStyle(color: Colors.black,
      fontWeight: FontWeight.bold, fontSize: 16
            )),
  ),
),


SizedBox(height: 35),


 const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Text(
                    'Follow Us',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),


SizedBox(height: 30),
Container(
  height: 50,
  width: 50,
  decoration: BoxDecoration(
    color: const Color.fromARGB(255, 98, 173, 234),
    borderRadius: BorderRadius.circular(50),
    boxShadow: const [
      BoxShadow(
        color: Colors.red,
        blurRadius: 5.0,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: GestureDetector(
    
    onTap: () async {
      final Uri url = Uri.parse(
          'https://www.instagram.com/ElimTrustOrg/?locale=en_GB');
      if (!await launchUrl(url)) {
        print('Could not launch $url');
      }
    },
child: Icon(FontAwesomeIcons.instagram, color: Colors.black))),

SizedBox(height: 20),




  Container(
  height: 50,
  width: 50,
  decoration: BoxDecoration(
    color: const Color.fromARGB(255, 98, 173, 234),
    borderRadius: BorderRadius.circular(50),
    boxShadow: const [
      BoxShadow(
        color: Colors.red,
        blurRadius: 5.0,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: GestureDetector(
    onTap: () async {
      final Uri url = Uri.parse(
        'https://x.com/ElimTrustOrg?s=20');
      if (!await launchUrl(url)) {
        print('Could not launch $url');
      }
    },
    child: Icon(FontAwesomeIcons.x, color: Colors.black))),



SizedBox(height: 20),


Container(
  height: 50,
  width: 50,
  decoration: BoxDecoration(
    color: const Color.fromARGB(255, 98, 173, 234),
    borderRadius: BorderRadius.circular(50),
    boxShadow: const [
      BoxShadow(
        color: Colors.red,
        blurRadius: 5.0,
        offset: Offset(0, 2),
      ),
    ],
  ),
  child: GestureDetector(
    onTap: () async {
      final Uri url = Uri.parse(
          'https://www.linkedin.com/in/elim-trust-org/?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app');
      if (!await launchUrl(url)) {
        print('Could not launch $url');
      }
    },
    child: Icon(FontAwesomeIcons.linkedin, color: Colors.black),
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

                    // Assuming GoogleFonts.dancingScript is available or replace with TextStyle
                    style: GoogleFonts.dancingScript(
                      //fontFamily: 'DancingScript', // Example if GoogleFonts is not directly used here
                      fontSize: 16, // Slightly increased font size
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
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
                    const SizedBox(width: 4), // Spacing between icon and text
                    const Text('+254 705 558 885',
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
                const SizedBox(height: 10), // Spacing between rows
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.linkedin,
                          color: Colors.blue),
                      onPressed: () async {
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
                        const String whatsappNumber = '254705558885';
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
                        final Uri url =
                            Uri.parse('https://www.facebook.com/ElimTrustOrg/');
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) {
                          print('Could not launch $url');
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Could not open Facebook: $url')),
                            );
                          }
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.locationDot,
                          color: Colors.red),
                      onPressed: () async {
                        final Uri url = Uri.parse(
                            'https://maps.google.com/?q=Elim+Trust+Nairobi');
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) {
                          print('Could not launch $url');
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
