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
    apiKey: 'AIzaSyBUQS0YzcrbzH0WdvaY5sc8fRssIdhTJ-w',
    appId: '1:635113512590:web:0c9d208083b6ffff6a33df',
    messagingSenderId: '635113512590',
    projectId: 'socialmediaapp-101c1',
    authDomain: 'socialmediaapp-101c1.firebaseapp.com',
    storageBucket: 'socialmediaapp-101c1.appspot.com',
    measurementId: 'G-Z1RYV7SKGT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8j5pH6XJDf0rtRht_rmEtB03WDeCJDZE',
    appId: '1:635113512590:android:eb5551da8b06f3326a33df',
    messagingSenderId: '635113512590',
    projectId: 'socialmediaapp-101c1',
    storageBucket: 'socialmediaapp-101c1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBgQWYoRDwDIFV8RzGyf_gNIi9yPY4c4rI',
    appId: '1:635113512590:ios:6dbbe87e5a155e1e6a33df',
    messagingSenderId: '635113512590',
    projectId: 'socialmediaapp-101c1',
    storageBucket: 'socialmediaapp-101c1.appspot.com',
    androidClientId: '635113512590-bidi391vo1hc2s85ql04p3jtjmflbeli.apps.googleusercontent.com',
    iosClientId: '635113512590-gf4ms6stdiqggrnso72pc3p16rh5dnjm.apps.googleusercontent.com',
    iosBundleId: 'com.flutter.socialapp.socialApp',
  );
}
