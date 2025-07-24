import 'package:flutter/material.dart';
import 'package:elim_trust_2/widgets/appbar.dart'; // Make sure this file defines 'CustomAppBar'

class CapacityPage extends StatefulWidget {
  const CapacityPage({super.key});

  @override
  State<CapacityPage> createState() => _CapacityPageState();
}

class _CapacityPageState extends State<CapacityPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800), // Consider making animation durations constants
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
                "Capacity Building ",
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
                  Navigator.pushNamed(context, '/capacity');
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
                    'images/capacity.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Healing at the Grassroots”',
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
                  '''Equipping Spiritual and Community Leaders for Better Health

Elim Trust empowers Spiritual  leaders, and community champions to address the deep challenges of sexual abuse, mental health, and trauma—particularly among children and families. Through a powerful blend of education, advocacy, and psychosocial support, we champion holistic well-being in Kenya’s most underserved communities.

Having worked extensively in the Rift Valley— communities continue to grapple with generational land conflict trauma— in Northern Kenya among pastoralist populations affected by displacement, violence, and climate-induced stress. Elim Trust equips Spiritual leaders, community elders, and grassroots champions with tools for psychosocial support, advocacy, and trauma-informed care.''',
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
                  'Focus Areas:',
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
                        'Child protection and mental health in faith spaces'),
                    const SizedBox(height: 8),
                    _buildOfferPoint(
                        'SGBV awareness and trauma-informed response'),

                    const SizedBox(height: 8),
                    _buildOfferPoint(
                        'Interventions in communities affected by land conflict, displacement, and climate crises'),
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
                      '''When trauma is left unspoken, it grows. ''',
                      style: TextStyle( // Added const
                        fontStyle: FontStyle.italic,
                        //fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                   // const SizedBox(height: 16), // Added some space between the texts
                    Text(
                      '''When trauma is left unspoken, it grows. 😊''',
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