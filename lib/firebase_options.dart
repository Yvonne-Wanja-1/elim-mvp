// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCnEtHxNt0iC9h03osqRD02_gOhqk1Yt3c',
    appId: '1:214074738643:android:0df3a27a39ab2bb3bc9126',
    messagingSenderId: '214074738643',
    projectId: 'elim-mvp',
    storageBucket: 'elim-mvp.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvaAZL7z5-QABqKRlM-KUHzG5JCXk_BAk',
    appId: '1:214074738643:ios:0e0c0a37403f7451bc9126',
    messagingSenderId: '214074738643',
    projectId: 'elim-mvp',
    storageBucket: 'elim-mvp.firebasestorage.app',
    iosBundleId: 'com.example.elimMvp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDvaAZL7z5-QABqKRlM-KUHzG5JCXk_BAk',
    appId: '1:214074738643:ios:0e0c0a37403f7451bc9126',
    messagingSenderId: '214074738643',
    projectId: 'elim-mvp',
    storageBucket: 'elim-mvp.firebasestorage.app',
    iosBundleId: 'com.example.elimMvp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBLh2s9v4y1kDfCVPUPIXykotyfChaC-rc',
    appId: '1:214074738643:web:b005b734892ca2a5bc9126',
    messagingSenderId: '214074738643',
    projectId: 'elim-mvp',
    authDomain: 'elim-mvp.firebaseapp.com',
    storageBucket: 'elim-mvp.firebasestorage.app',
    measurementId: 'G-JDL4PN2KF7',
  );
}
