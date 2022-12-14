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
    apiKey: 'AIzaSyBJQPSt5CgkaxqjEBpZzp99gyJ3nq4uUGA',
    appId: '1:113785121744:web:683431166eb858d641a7d5',
    messagingSenderId: '113785121744',
    projectId: 'everytime-cloned',
    authDomain: 'everytime-cloned.firebaseapp.com',
    storageBucket: 'everytime-cloned.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDpVCVvyCUPjHOWHAc57GMmBSgFhjSo9WI',
    appId: '1:113785121744:android:21fa873eb334177141a7d5',
    messagingSenderId: '113785121744',
    projectId: 'everytime-cloned',
    storageBucket: 'everytime-cloned.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD1tSm3JByVw8eHXyyUuN3AL3X2AVf5Y6Y',
    appId: '1:113785121744:ios:39e5b8aac1d6c19e41a7d5',
    messagingSenderId: '113785121744',
    projectId: 'everytime-cloned',
    storageBucket: 'everytime-cloned.appspot.com',
    iosClientId: '113785121744-3ueiub87oc3haphs5hq8pcpkidb5mb61.apps.googleusercontent.com',
    iosBundleId: 'com.example.everytimeCloned',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD1tSm3JByVw8eHXyyUuN3AL3X2AVf5Y6Y',
    appId: '1:113785121744:ios:39e5b8aac1d6c19e41a7d5',
    messagingSenderId: '113785121744',
    projectId: 'everytime-cloned',
    storageBucket: 'everytime-cloned.appspot.com',
    iosClientId: '113785121744-3ueiub87oc3haphs5hq8pcpkidb5mb61.apps.googleusercontent.com',
    iosBundleId: 'com.example.everytimeCloned',
  );
}
