import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
    clientId:
        '283301104366-t2e0k3t67bcpf2liqtm9gatgrk8t5qrq.apps.googleusercontent.com', // Replace with your Web Client ID
  );

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Check if user is signed in and email is verified
  bool get isSignedIn => currentUser != null && currentUser!.emailVerified;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Keep track of last verification email sent time
  static final Map<String, DateTime> _lastEmailSentTime = {};

  // Send email verification with custom settings
  Future<void> sendEmailVerification({User? user}) async {
    try {
      final userToSend = user ?? currentUser;
      if (userToSend == null) {
        throw FirebaseAuthException(
          code: 'no-user',
          message: 'No user provided or currently signed in',
        );
      }

      // Check cooldown period (1 minute between emails)
      final lastSent = _lastEmailSentTime[userToSend.email];
      if (lastSent != null) {
        final timeSinceLastEmail = DateTime.now().difference(lastSent);
        if (timeSinceLastEmail < const Duration(minutes: 1)) {
          final secondsToWait = 60 - timeSinceLastEmail.inSeconds;
          throw FirebaseAuthException(
            code: 'cooldown-period',
            message:
                'Please wait $secondsToWait seconds before requesting another verification email.',
          );
        }
      }

      // Send verification email with basic settings
      await userToSend.sendEmailVerification();

      // Update last sent time
      _lastEmailSentTime[userToSend.email!] = DateTime.now();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        throw FirebaseAuthException(
          code: 'too-many-requests',
          message:
              'You\'ve reached the limit for verification emails. Please try again after 24 hours.',
        );
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // Check if email is verified and refresh user data
  Future<bool> checkEmailVerified() async {
    await currentUser?.reload();
    return currentUser?.emailVerified ?? false;
  }

  // Check if email is verified without refreshing
  bool get isEmailVerified => currentUser?.emailVerified ?? false;

  // Create user with email and password
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      // First check if the email is already in use
      final methods = await _auth.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        throw FirebaseAuthException(
          code: 'email-already-in-use',
          message:
              'This email is already registered. Please try signing in instead.',
        );
      }

      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Immediately send verification email
      if (credential.user != null) {
        try {
          // Try to send verification email directly
          await credential.user!.sendEmailVerification();
          // Store the initial send time
          _lastEmailSentTime[credential.user!.email!] = DateTime.now();
        } catch (e) {
          print('Error sending verification email: $e');
          // Don't delete the user, just log the error and continue
          // The user can request another verification email later
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

      // Check if email is verified, but don't prevent sign in
      if (!credential.user!.emailVerified) {
        print('Warning: Email not verified for user ${credential.user!.email}');
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
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser =
          await _googleSignIn.signIn().catchError((error) {
        print('Google Sign In Error: $error');
        throw FirebaseAuthException(
          code: 'google-sign-in-failed',
          message: 'Failed to sign in with Google: ${error.toString()}',
        );
      });

      if (googleUser == null) throw 'Google sign in aborted';

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication.catchError((error) {
        print('Google Auth Error: $error');
        throw FirebaseAuthException(
          code: 'google-auth-failed',
          message: 'Failed to get Google authentication: ${error.toString()}',
        );
      });

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
