import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyAUZImA-9X1b5htXBlyffNuVVNolTUJIEc",
    authDomain: "greenhouse-16b3b.firebaseapp.com",
    databaseURL: "https://greenhouse-16b3b-default-rtdb.firebaseio.com",
    projectId: "greenhouse-16b3b",
    storageBucket: "greenhouse-16b3b.appspot.com",
    messagingSenderId: "42598181979",
    appId: "1:42598181979:web:48d02b70de5e58441ce37e",
    measurementId: "G-9HSKTTW30R"
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyAUZImA-9X1b5htXBlyffNuVVNolTUJIEc",
    authDomain: "greenhouse-16b3b.firebaseapp.com",
    databaseURL: "https://greenhouse-16b3b-default-rtdb.firebaseio.com",
    projectId: "greenhouse-16b3b",
    storageBucket: "greenhouse-16b3b.appspot.com",
    messagingSenderId: "42598181979",
    appId: "1:42598181979:web:48d02b70de5e58441ce37e",
    measurementId: "G-9HSKTTW30R"
  );
}