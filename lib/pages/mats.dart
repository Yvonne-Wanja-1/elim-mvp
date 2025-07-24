import 'package:flutter/material.dart';
import 'package:elim_trust_2/widgets/appbar.dart'; // Make sure this file defines 'CustomAppBar'

class MatsDialoguePage extends StatefulWidget {
  const MatsDialoguePage({super.key});

  @override
  State<MatsDialoguePage> createState() => _MatsDialoguePageState();
}

class _MatsDialoguePageState extends State<MatsDialoguePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Appbar(
          title: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: const Text(
                "MATS DIALOGUE PROGRAM",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          leadingIcon: Icons.arrow_back,
          actions: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.red,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.volunteer_activism, color: Colors.blue),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  Navigator.pushNamed(context, '/donations');
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            children: [
              Container(
                height: 250,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'images/dialog.png',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: 250,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'MATS Dialogue “Circles Of Support”',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationThickness: 2,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  '''Women across Africa face trauma mainly driven by gender-based violence, conflict, and limited resources. Unfortunately, access to mental health services remain scarce leading to long term mental health struggles such as PTSD, anxiety, and depression.''',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                    fontFamily: 'Arial',
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'What it Offers:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    decorationThickness: 2,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOfferPoint(
                        'MATS Dialogue sees women’s circle of support created in safe, familiar spaces where teen mums and women first reclaim their voices and then engage in guided conversations, expressive arts, and shared storytelling. These sessions are about being heard, seen, and supported within a community that understands.'),
                    const SizedBox(height: 8),
                    _buildOfferPoint(
                        'Circle Keepers: Circle Keepers are local women trained to facilitate the MATS Dialogue. They hold space for young mothers and women to process trauma, share their stories, and reconnect with their inner strength. As guides, listeners, and nurturers, Circle Keepers are at the heart of every healing circle.'),
                    const SizedBox(height: 8),
                    _buildOfferPoint(
                        'Mats dialogue is more than a method—it’s a movement grounded in culture and compassion.'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/donations');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 22, 119, 198),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(200, 60),
                ),
                child: const Text(
                  '❤️ Donate to MATS Dialogue❤️',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ // Removed const because children are no longer all const
                    Text(
                      '''MATS helps restore emotional balance, rebuild trust, and empowers women to reclaim their voice.''',
                      style: TextStyle( // Added const
                        fontStyle: FontStyle.italic,
                        //fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                   // const SizedBox(height: 16), // Added some space between the texts
                    Text(
                      '''Join us in supporting women’s Mats Dialogue to mitigate trauma recovery for more women across Africa 😊''',
                      style: TextStyle( // Added const
                        //fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontFamily: 'Arial',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),





              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfferPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "• ",
          style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.black87,
              fontFamily: 'Arial',
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}