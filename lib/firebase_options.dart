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
    apiKey: 'AIzaSyAliRsxMDO5AbSVnGFBzj8kRGsQW1YrU4w',
    appId: '1:1074044623647:web:1279e2e0cffafe4c862e2a',
    messagingSenderId: '1074044623647',
    projectId: 'rossoneri-store',
    authDomain: 'rossoneri-store.firebaseapp.com',
    storageBucket: 'rossoneri-store.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCLBOJlYdQwXADt51EVH24ZtgwTwlYU22A',
    appId: '1:1074044623647:android:08c7352de1b06909862e2a',
    messagingSenderId: '1074044623647',
    projectId: 'rossoneri-store',
    storageBucket: 'rossoneri-store.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVQMAVuccADcgCTnqUlMJc_pvHgtEa0qI',
    appId: '1:1074044623647:ios:533e5fbf978a809a862e2a',
    messagingSenderId: '1074044623647',
    projectId: 'rossoneri-store',
    storageBucket: 'rossoneri-store.appspot.com',
    iosBundleId: 'com.example.rossoneriStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAVQMAVuccADcgCTnqUlMJc_pvHgtEa0qI',
    appId: '1:1074044623647:ios:533e5fbf978a809a862e2a',
    messagingSenderId: '1074044623647',
    projectId: 'rossoneri-store',
    storageBucket: 'rossoneri-store.appspot.com',
    iosBundleId: 'com.example.rossoneriStore',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAliRsxMDO5AbSVnGFBzj8kRGsQW1YrU4w',
    appId: '1:1074044623647:web:0d8e1a5e4b96a123862e2a',
    messagingSenderId: '1074044623647',
    projectId: 'rossoneri-store',
    authDomain: 'rossoneri-store.firebaseapp.com',
    storageBucket: 'rossoneri-store.appspot.com',
  );
}
