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
    apiKey: 'AIzaSyDGdFZGzS9kE6PqEg0JA5knwjFZpApFU4U',
    appId: '1:571675802801:web:137ef79038755bc47bf690',
    messagingSenderId: '571675802801',
    projectId: 'flutterfirebase-2fe6d',
    authDomain: 'flutterfirebase-2fe6d.firebaseapp.com',
    storageBucket: 'flutterfirebase-2fe6d.appspot.com',
    measurementId: 'G-K0PVSVJ0X0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCOJVwsuomCFqYU1xkM3ZlLyhJRB6PDsiM',
    appId: '1:571675802801:android:3f0579dbd4e8d83a7bf690',
    messagingSenderId: '571675802801',
    projectId: 'flutterfirebase-2fe6d',
    storageBucket: 'flutterfirebase-2fe6d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxHqM5aujDA-vOkBX3eV9h2QI9Vm-rik4',
    appId: '1:571675802801:ios:8582a9bfe1bf0f4e7bf690',
    messagingSenderId: '571675802801',
    projectId: 'flutterfirebase-2fe6d',
    storageBucket: 'flutterfirebase-2fe6d.appspot.com',
    iosBundleId: 'com.example.flutterWithFirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxHqM5aujDA-vOkBX3eV9h2QI9Vm-rik4',
    appId: '1:571675802801:ios:8582a9bfe1bf0f4e7bf690',
    messagingSenderId: '571675802801',
    projectId: 'flutterfirebase-2fe6d',
    storageBucket: 'flutterfirebase-2fe6d.appspot.com',
    iosBundleId: 'com.example.flutterWithFirebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDGdFZGzS9kE6PqEg0JA5knwjFZpApFU4U',
    appId: '1:571675802801:web:5f9a21c5e0bb94837bf690',
    messagingSenderId: '571675802801',
    projectId: 'flutterfirebase-2fe6d',
    authDomain: 'flutterfirebase-2fe6d.firebaseapp.com',
    storageBucket: 'flutterfirebase-2fe6d.appspot.com',
    measurementId: 'G-BLYBBEBE63',
  );
}
