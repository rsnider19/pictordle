// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDliT9HSla5Plsw3iBr27bT1SvSJhVU6W0',
    appId: '1:395153571998:web:b1bdfff382cd7424017b8f',
    messagingSenderId: '395153571998',
    projectId: 'pictordle-346508',
    authDomain: 'pictordle-346508.firebaseapp.com',
    storageBucket: 'pictordle-346508.appspot.com',
    measurementId: 'G-0394Z5DYJX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGBgvLvrvtDKXkrDC8-YJtlWF_ojW5urU',
    appId: '1:395153571998:android:74c1f7c39d44b8d2017b8f',
    messagingSenderId: '395153571998',
    projectId: 'pictordle-346508',
    storageBucket: 'pictordle-346508.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpx7dhPlCDyVbZQX3wblHV9mnw9_3LGMQ',
    appId: '1:395153571998:ios:8b34634b5dd58e22017b8f',
    messagingSenderId: '395153571998',
    projectId: 'pictordle-346508',
    storageBucket: 'pictordle-346508.appspot.com',
    iosClientId: '395153571998-kdbkp4hh4el83lnlhoq7cas68nf0vju6.apps.googleusercontent.com',
    iosBundleId: 'com.pictordle.app',
  );
}
