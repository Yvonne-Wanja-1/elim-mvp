import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Check if user is signed in and email is verified
  bool get isSignedIn => currentUser != null && currentUser!.emailVerified;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Send email verification with custom settings
  Future<void> sendEmailVerification() async {
    try {
      if (currentUser == null) {
        throw FirebaseAuthException(
          code: 'no-user',
          message: 'No user is currently signed in',
        );
      }

      // Send verification email with custom settings
      await currentUser!.sendEmailVerification(ActionCodeSettings(
        url:
            'https://elimtrust.page.link/verify', // Replace with your actual dynamic link
        handleCodeInApp: true,
        androidPackageName: 'com.example.elim_trust_2',
        androidInstallApp: true,
        androidMinimumVersion: '12',
        iOSBundleId: 'com.example.elim_trust_2',
      ));
    } catch (e) {
      rethrow;
    }
  }

  // Check if email is verified
  bool get isEmailVerified => currentUser?.emailVerified ?? false;

  // Create user with email and password
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Immediately send verification email
      if (credential.user != null) {
        try {
          await credential.user!.sendEmailVerification();
        } catch (e) {
          // If sending verification email fails, delete the user and throw
          await credential.user!.delete();
          throw FirebaseAuthException(
            code: 'verification-email-failed',
            message: 'Failed to send verification email. Please try again.',
          );
        }
      }

      return credential;
    } catch (e) {
      rethrow;
    }
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if email is verified
      if (!credential.user!.emailVerified) {
        await signOut();
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Please verify your email before signing in.',
        );
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        throw FirebaseAuthException(
          code: 'too-many-requests',
          message:
              'Access has been temporarily disabled due to many failed login attempts. '
              'Please wait a few minutes before trying again, or reset your password.',
        );
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Reload user
  Future<void> reloadUser() async {
    await currentUser?.reload();
  }

  // Sign in with Google
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw 'Google sign in aborted';

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
