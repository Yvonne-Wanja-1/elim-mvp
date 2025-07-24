import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:url_launcher/url_launcher.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;

  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _showImageSourceActionSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      _cropImage(File(pickedFile.path));
    }
  }

  Future<void> _cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true,
            cropFrameColor: Colors.blue,
            cropGridColor: Colors.white.withOpacity(0.7)),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        _profileImage = File(croppedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: AppBar(
                centerTitle: true,
                title: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Colors.purple,
                      Colors.orange,
                      Color.fromARGB(255, 11, 110, 192),
                      Colors.red,
                      Colors.yellow,
                    ],
                  ).createShader(bounds),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'Profile',
                        textStyle: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Needed for ShaderMask
                        ),
                        speed: const Duration(milliseconds: 150),
                      ),
                    ],
                    isRepeatingAnimation: true,
                    repeatForever: true,
                  ),
                ),
                backgroundColor: Colors.blue,
                actions: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/settings');
                    },
                  child: Container(
                    margin: const EdgeInsets.only(right: 5),
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                          blurRadius: 2.0,
                          offset: Offset(0, 2), // Shadow position
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.settings),
                      color: Colors.blue,
                      onPressed: () {
                        // Action for settings button
                        Navigator.pushNamed(context, '/settings');
                      },
                    ),
                  ),
                  ),
                ],
                leading: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                          blurRadius: 2.0,
                          offset: Offset(0, 2), // Shadow position
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.blue),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(), // Added bouncing scroll physics
            child: Column(
              children: [
                const SizedBox(height: 10), // Add some space at the top
                // Profile Picture
                Center(
                  child: Stack(
                    clipBehavior: Clip.none, // Allow shadow to render outside the bounds
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!) // Use FileImage if _profileImage is not null
                        : const AssetImage('images/profile.png') as ImageProvider, // Otherwise, use AssetImage
                      ),
                     Positioned(
        bottom: -1 , // Position at the bottom of the CircleAvatar
        right: 1, // Position at the right of the CircleAvatar
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.blue, // Badge color
            shape: BoxShape.circle, // Circular badge
            border: Border.all(color: Colors.white, width: 2), 
            boxShadow: const [ BoxShadow(
              color: Colors.red,
              blurRadius: 2.0,
              offset: Offset(0, 0), // Set to (0,0) to show shadow on all sides
            ),
            ],
          ),
          
          child: IconButton(
            icon: const Icon(Icons.edit, size: 16, color: Colors.white), // Edit icon
            padding: EdgeInsets.zero, // Remove default padding
            constraints: const BoxConstraints(), // Allow button to shrink to icon size
            onPressed: () {
              _showImageSourceActionSheet(context);
            },
          ),
        ),
      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Member since Janurary, 2023',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Arial',
                        fontStyle: FontStyle.italic,
                        color: Color.fromARGB(255, 130, 174, 210), // Lighter color for address
                      ),
                    ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, ),
                      child: Row(
                        
                        
                        children: [
                          const Expanded(
                            child: Text(
                              'Personal Information:',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red,
                                    blurRadius: 2.0,
                                    offset: Offset(0, 0), // Set to (0,0) to show shadow on all sides
                                  ),
                                ],
                              ),
                              child: Center(
                                child: IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.white),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/editinfo', arguments: {
                                      'email': _emailController.text,
                                      'password': _passwordController.text,
                                      'name': _nameController.text,
                                      'phone': _phoneController.text,
                                      'address': _addressController.text,
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20), // Align content far to the left
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 0),
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'john@gmail.com',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Arial',
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700], // Lighter color for email
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '+254 712 345 678',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Arial',
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700], // Lighter color for phone number
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Address',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '123 Main Street, Nairobi, Kenya',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Arial',
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700], // Lighter color for address
                          ),
                        ),
        
                        const SizedBox(height: 25),
                        const Text(
                          'Your Contributions:',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Total Donations',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '10',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Arial',
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700], // Lighter color for address
                          ),
                        ),
                         const SizedBox(height: 10),
                        const Text(
                          'Total Amount Contributed',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '123,000 KES',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Arial',
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700], // Lighter color for address
                          ),
                        ),
                        //const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton:
            FloatingActionButton(
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
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            color: const Color.fromARGB(255, 4, 135, 242),
            height: 60,
            index: 4,
            items: const <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.folder_open, size: 30, color: Colors.white),
                  Text(
                    'Projects',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.attach_money_rounded, size: 30, color: Colors.white),
                  Text(
                    'Donations',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.home, size: 30, color: Colors.white),
                  Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FontAwesomeIcons.peopleGroup, size: 30, color: Colors.white),
                  Text(
                    'Community',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, size: 30, color: Colors.white),
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.pushReplacementNamed(context, '/projects');
                  break;
                case 1:
                  Navigator.pushReplacementNamed(context, '/donations');
                  break;
                case 2:
                  Navigator.pushReplacementNamed(context, '/home');
                  break;
                case 3:
                  Navigator.pushReplacementNamed(context, '/community');
                  break;
                case 4:
                  break;
              }
            },
          ),
        ),
    );
  }
}


      
    
  
