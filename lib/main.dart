

import 'package:elim_trust_2/auth/get_started_page.dart';
import 'package:elim_trust_2/auth/signin_page.dart';
import 'package:elim_trust_2/firebase_options.dart';
import 'package:elim_trust_2/pages/albert.dart';
import 'package:elim_trust_2/pages/blogs.dart';
import 'package:elim_trust_2/pages/capacity.dart';
import 'package:elim_trust_2/pages/changepassword.dart';
import 'package:elim_trust_2/pages/communitypage.dart';
import 'package:elim_trust_2/pages/contact.dart';
import 'package:elim_trust_2/pages/donations.dart';
import 'package:elim_trust_2/pages/editinfo.dart';
import 'package:elim_trust_2/pages/faqs.dart';
import 'package:elim_trust_2/pages/feedback.dart';
import 'package:elim_trust_2/pages/gallery.dart';
import 'package:elim_trust_2/pages/homepage.dart';
import 'package:elim_trust_2/pages/jane.dart';
import 'package:elim_trust_2/pages/latestnews.dart';
import 'package:elim_trust_2/pages/manageaccount.dart';
import 'package:elim_trust_2/pages/mats.dart';
import 'package:elim_trust_2/pages/pastor.dart';
import 'package:elim_trust_2/pages/profilepage.dart';
import 'package:elim_trust_2/pages/projects.dart';
import 'package:elim_trust_2/pages/readmoreblogs.dart';
import 'package:elim_trust_2/pages/readmorelatestnews.dart';
import 'package:elim_trust_2/pages/secondreadmoreblogs.dart';
import 'package:elim_trust_2/pages/settings.dart';
import 'package:elim_trust_2/pages/story.dart';
import 'package:elim_trust_2/pages/vunja.dart';
import 'package:elim_trust_2/pages/yprep.dart';
import 'package:elim_trust_2/widgets/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 👈 must-have
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // 👈 This connects to your Firebase project

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elim Trust Org',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SplashScreen(
        child: SignInPage(),
      ),
      routes: {
        '/signin': (context) => const SignInPage(),
        '/get-started': (context) => const GetStartedPage(),
        '/home': (context) => const HomePage(),
        '/projects': (context) => const ProjectsPage(),
        '/donations': (context) => const DonationsPage(),
        '/community': (context) => const CommunityPage(),
        '/profile': (context) => const ProfilePage(),
        '/yprep': (context) => const YprepPage(),
        '/matsdialogue': (context) => const MatsDialoguePage(),
        '/vunja': (context) => const VunjaPage(),
        '/capacity': (context) => const CapacityPage(),
        '/latestnews': (context) => const LatestnewsPage(),
        '/blogs': (context) => const BlogsPage(),
        '/gallery': (context) => const GalleryPage(),
        '/contact': (context) => const ContactPage(), 
        '/editinfo': (context) => const EditInfo(),
        '/story': (context) => const StoryPage(),
        '/settings': (context) => const SettingsPage(),
        '/feedback': (context) => const FeedbackPage(),
        '/faqs': (context) => const FaqsPage(),
        '/change_password': (context) => const PasswordPage(),
        '/manage_account': (context) => const ManageAccountPage(),
        '/readmorelatestnews': (context) => const Readmorelatestnews(),
        '/readmoreblogs': (context) => const Readmoreblogs(),
        '/secondreadmoreblogs': (context) => const SecondReadmoreblogs(),
        '/albert': (context) => const AlbertPage(),
        '/pastor': (context) => const PastorPage(),
        '/jane': (context) => const JanePage(),
      },
    );
  }
}
