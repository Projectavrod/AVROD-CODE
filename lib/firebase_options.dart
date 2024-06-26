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
    apiKey: 'AIzaSyD8godhi6j7mTVRawAHwsVaEEOBhQmkflg',
    appId: '1:176315844467:web:24b67365a798e23124e706',
    messagingSenderId: '176315844467',
    projectId: 'avrod-5c1c9',
    authDomain: 'avrod-5c1c9.firebaseapp.com',
    storageBucket: 'avrod-5c1c9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjSyDLAYRqT5_ZBOVxZhKW6PKzdhjmstU',
    appId: '1:176315844467:android:de25a3d0fc6ad80024e706',
    messagingSenderId: '176315844467',
    projectId: 'avrod-5c1c9',
    storageBucket: 'avrod-5c1c9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAzTXvNCxUgcWbx5Q2wmFAGCdhTT1mopH4',
    appId: '1:176315844467:ios:92b62d534af7f76e24e706',
    messagingSenderId: '176315844467',
    projectId: 'avrod-5c1c9',
    storageBucket: 'avrod-5c1c9.appspot.com',
    iosBundleId: 'com.example.avrod',
  );
}
