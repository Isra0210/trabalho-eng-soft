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
        return macos;
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
    apiKey: 'AIzaSyD6olqB7f9n78BmePYiBzMo44S4208Rf_A',
    appId: '1:822131415984:web:d20767a6b0ee7e68ad5475',
    messagingSenderId: '822131415984',
    projectId: 'hackday-9566f',
    authDomain: 'hackday-9566f.firebaseapp.com',
    storageBucket: 'hackday-9566f.appspot.com',
    measurementId: 'G-60RRZZ4L54',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbZZo-F3Obl3_Ucehn5fKWCyN158vaZiQ',
    appId: '1:822131415984:android:eeafd1c75c74f6c3ad5475',
    messagingSenderId: '822131415984',
    projectId: 'hackday-9566f',
    storageBucket: 'hackday-9566f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDx1Mez7bBS5mvP-LeGypI65qfHAHlNTiA',
    appId: '1:822131415984:ios:9d1f33cbb8674cebad5475',
    messagingSenderId: '822131415984',
    projectId: 'hackday-9566f',
    storageBucket: 'hackday-9566f.appspot.com',
    androidClientId: '822131415984-ga2819r3sikk8e86ps2pldkhes8njkma.apps.googleusercontent.com',
    iosClientId: '822131415984-pbb1sl7fuhaipfid1qo9av0d1iuah28k.apps.googleusercontent.com',
    iosBundleId: 'com.example.hackday',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDx1Mez7bBS5mvP-LeGypI65qfHAHlNTiA',
    appId: '1:822131415984:ios:9d1f33cbb8674cebad5475',
    messagingSenderId: '822131415984',
    projectId: 'hackday-9566f',
    storageBucket: 'hackday-9566f.appspot.com',
    androidClientId: '822131415984-ga2819r3sikk8e86ps2pldkhes8njkma.apps.googleusercontent.com',
    iosClientId: '822131415984-pbb1sl7fuhaipfid1qo9av0d1iuah28k.apps.googleusercontent.com',
    iosBundleId: 'com.example.hackday',
  );
}