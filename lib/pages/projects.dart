import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProjectsPage extends StatefulWidget {
  
  
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _MyWidgetState();




  
}

class _MyWidgetState extends State<ProjectsPage> with TickerProviderStateMixin {
  // Fix: Changed to TickerProviderStateMixin as multiple AnimationControllers are used.
  // Fix: Consolidated state variables from the nested class.
  // Fix: Initial _selectedIndex for ProjectsPage should be 0.
  bool isOngoingSelected = true;
  int _selectedIndex = 0; 
  late AnimationController _titleFadeSlideAnimationController; // For the title fade/slide animation
  late Animation<Offset> _slideAnimation;
  late AnimationController _titleScaleAnimationController; // For the title scale animation
  late Animation<double> _scaleAnimation;
  late AnimationController _menuIconFeedbackController; // For menu icon rotation
  late Animation<double> _menuIconRotationAnimation;
  String? _lastSelectedMenuItemValue; // To store the value of the last tapped menu item

  @override
  void initState() {
    super.initState();

    // Initialize for title fade/slide animation (from original _MyWidgetState)
    _titleFadeSlideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation( // Fix: Use _titleFadeSlideAnimationController
      parent: _titleFadeSlideAnimationController,
      curve: Curves.easeInOut,
    ));

    // Initialize for title scale animation (from duplicated _ProjectsPageState)
    _titleScaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // Makes the animation loop back and forth

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.29).animate(
        CurvedAnimation(parent: _titleScaleAnimationController, curve: Curves.easeInOut));

    // Initialize for menu icon rotation (from duplicated _ProjectsPageState)
    _menuIconFeedbackController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400), // Duration for the rotation
    );
    _menuIconRotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate( // 0.0 to 1.0 for a full 360-degree turn
      CurvedAnimation(parent: _menuIconFeedbackController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _titleFadeSlideAnimationController.dispose();
    _titleScaleAnimationController.dispose(); // Fix: Dispose the new controller
    _menuIconFeedbackController.dispose(); // Fix: Dispose the new controller
    super.dispose();
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
            title: FadeTransition(
              opacity: _titleFadeSlideAnimationController, // Fix: Use the correct controller
              child: SlideTransition(
                position: _slideAnimation,
                child: const Text(
                  'Projects 📋',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(12.0),
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
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.volunteer_activism, color: Colors.blue, size: 24),
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                buildToggle("Ongoing", true),
                buildToggle("Completed", false),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: isOngoingSelected
                  ? buildOngoingProjects()
                  : buildCompletedProjects(),
            ),
          ),
        ],
      ),
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
              Text('Projects', style: TextStyle(color: Colors.white, fontSize: 10, fontStyle: FontStyle.italic)),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.attach_money_rounded, size: 30, color: Colors.white),
              Text('Donations', style: TextStyle(color: Colors.white, fontSize: 10, fontStyle: FontStyle.italic)),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.home, size: 30, color: Colors.white),
              Text('Home', style: TextStyle(color: Colors.white, fontSize: 10, fontStyle: FontStyle.italic)),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(FontAwesomeIcons.peopleGroup, size: 30, color: Colors.white),
              Text('Community', style: TextStyle(color: Colors.white, fontSize: 10, fontStyle: FontStyle.italic)),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person, size: 30, color: Colors.white),
              Text('Profile', style: TextStyle(color: Colors.white, fontSize: 10, fontStyle: FontStyle.italic)),
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
    );
  }

  Widget buildToggle(String title, bool isOngoing) {
    final selected = isOngoingSelected == isOngoing;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isOngoingSelected = isOngoing;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: selected
                ? const Border(bottom: BorderSide(color: Colors.blue, width: 2))
                : null,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                color: selected ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildOngoingProjects() {
    return [
      sectionTitle("Education"),
      projectCard("Empowering Minds", "Providing quality education to underprivileged children."),
      projectCard("Literacy for All", "Promoting literacy among adults and youth."),
    ];
  }

  List<Widget> buildCompletedProjects() {
    return [
      sectionTitle("Community"),
      projectCard("Completed Project A", "This project has been successfully completed."),
      projectCard("Completed Project B", "Another project completed recently."),
    ];
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget projectCard(String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: TextButton(
          onPressed: () {},
          child: const Text('View Details'),
        ),
      ),
    );
  }
}
