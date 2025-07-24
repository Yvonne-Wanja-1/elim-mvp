import 'package:flutter/material.dart';
import 'package:elim_trust_2/widgets/appbar.dart'; // Make sure this file defines 'CustomAppBar'

class YprepPage extends StatefulWidget {
  const YprepPage({super.key});

  @override
  State<YprepPage> createState() => _YprepPageState();
}

class _YprepPageState extends State<YprepPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // Adjust duration as you like
    );

    // Slide animation: from slightly above (e.g., -0.3 of its height) to its final position (Offset.zero)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3), // Start 30% of its height above
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic, // A nice smooth curve
    ));

    // Fade animation: from transparent (0.0) to fully opaque (1.0)
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    ));

    // Start the animation when the page is initialized
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose(); // Important to dispose the controller
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
                "Y-PREP PROGRAM",
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
                Navigator.pushNamed(context, '/donations'); // Navigate to donations page
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
              // Removed Expanded widget
              Container( 
                height: 250, // Now this height will be respected
                margin: const EdgeInsets.all(8.0), // Added some margin for better spacing
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFFF7F7F7), // Kept for background if image doesn't fill
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipRRect( // Ensures the image respects the container's border radius
                 // borderRadius: BorderRadius.circular(20),
                  child: Image.asset('images/t.png',
                    fit: BoxFit.contain, // Changed from BoxFit.cover to prevent stretching and show the whole image
                    width: double.infinity, // The image will be contained within this width
                    height: 250, // The image will be contained within this height
                  ),
                ),
              ),
              // You can add more widgets here if needed
      
           const Center( // This will center the Text widget block
             child: Text (
               'Y-PREP (Youth Psychosocial Resilience & Empowerment Program)',
               textAlign: TextAlign.center, // Ensures text lines are centered within the Text widget
               style: TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.bold,
                 color: Colors.blue, // Changed to blue for better visibility
                 decoration: TextDecoration.underline, // Added underline for emphasis
                 decorationColor: Colors.blue, // Underline color
                 decorationThickness: 2, // Thickness of the underline
               ),
             ),
           ),
        
              const SizedBox(height: 20), // Added space between the image and text
              
                 const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      '''Y-PREP is an initiative that bridges trauma healing with entrepreneurship and climate action to empower youth in vulnerable communities. Designed for young people living in informal settlements, conflict-affected regions, and climate-stressed areas, Y-PREP equips them with the tools to heal, grow and lead.  
                      
                      At its core, Y-PREP nurtures resilient youth who can turn adversity into opportunity—building micro-enterprises, challenging harmful social norms, and becoming catalysts for healing and economic transformation.
                      
                      Rooted in the belief that trauma does not have to define the future! Y-PREP blends psychological support, creative expression, trauma-sensitive entrepreneurship training and climate awareness to help youth:''',
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic, // Changed to normal for better readability
                        color: Colors.black87,
                        fontFamily: 'Arial', // Changed to Arial for better readability
                        height: 1.5, // Adjust line height for better readability
                      ),
                      textAlign: TextAlign.center, // Center align the text
                    ),
                  ),
                ),
              







              const Center( // This will center the Text widget block
             child: Text (
               'What it Offers:',
               textAlign: TextAlign.center, // Ensures text lines are centered within the Text widget
               style: TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.bold,
                 color: Colors.blue, // Changed to blue for better visibility
                 decoration: TextDecoration.underline, // Added underline for emphasis
                 decorationColor: Colors.blue, // Underline color
                 decorationThickness: 2, // Thickness of the underline
               ),
             ),
           ),
        
              const SizedBox(height: 20), // Added space between the image and text
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0), // Added padding for the list
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Align points to the start
                  children: [
                    _buildOfferPoint(
                        'Heal from psychological wounds through culturally sensitive drama therapy, storytelling, and group dialogue.'),
                    const SizedBox(height: 8), // Space between points
                    _buildOfferPoint(
                        'Gain life and business skills to build sustainable livelihoods.'),
                    const SizedBox(height: 8), // Space between points
                    _buildOfferPoint(
                        'Reclaim power over their future by becoming innovators, leaders, and advocates in their communities.'),
                  ],
                ),
              ),



            ElevatedButton(
              
              onPressed: () {
                Navigator.pushNamed(context, '/donations'); // Navigate to donations page
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 22, 119, 198),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  
                ),
                minimumSize: const Size(200, 60), // Set a minimum size for the button
              ),
              child: const Text(
                '❤️ Donate to Y-PREP ❤️',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Changed to white for better contrast
                ),
              ),
            ),
            ],
            ),
           
        ),




        
      ),
    );
  }

  // Helper widget to build each point in the "What it Offers" section
  Widget _buildOfferPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• ", style: TextStyle(fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold)), // Bullet point
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
              
