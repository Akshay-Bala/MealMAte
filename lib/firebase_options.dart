
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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAi0wqhYJeERSBXqvXv2tS-qbnyJ3kq7-Q',
    appId: '1:1052662632138:web:133a8b7daec25c4419ae33',
    messagingSenderId: '1052662632138',
    projectId: 'mealmate-96318',
    authDomain: 'mealmate-96318.firebaseapp.com',
    storageBucket: 'mealmate-96318.appspot.com',
    measurementId: 'G-BV0KKJ3YV3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXRRiHTKJ0hIIc-NyGCjPrGswJzMe0DEw',
    appId: '1:1052662632138:android:3cfc3407697f761319ae33',
    messagingSenderId: '1052662632138',
    projectId: 'mealmate-96318',
    storageBucket: 'mealmate-96318.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAp2m00_wPoMPGLdELluOQsM42CM-AvRyY',
    appId: '1:1052662632138:ios:232bab197d5aee2719ae33',
    messagingSenderId: '1052662632138',
    projectId: 'mealmate-96318',
    storageBucket: 'mealmate-96318.appspot.com',
    iosBundleId: 'com.example.mealmate',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAp2m00_wPoMPGLdELluOQsM42CM-AvRyY',
    appId: '1:1052662632138:ios:232bab197d5aee2719ae33',
    messagingSenderId: '1052662632138',
    projectId: 'mealmate-96318',
    storageBucket: 'mealmate-96318.appspot.com',
    iosBundleId: 'com.example.mealmate',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAi0wqhYJeERSBXqvXv2tS-qbnyJ3kq7-Q',
    appId: '1:1052662632138:web:301bf4f5d399986c19ae33',
    messagingSenderId: '1052662632138',
    projectId: 'mealmate-96318',
    authDomain: 'mealmate-96318.firebaseapp.com',
    storageBucket: 'mealmate-96318.appspot.com',
    measurementId: 'G-W0HD736SYG',
  );
}
