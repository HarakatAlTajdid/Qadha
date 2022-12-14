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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDL_z9jvQ3gObXVI8LcS1AE_BYFn_aHPrs',
    appId: '1:95505930885:android:e337b190f516a8349b27ec',
    messagingSenderId: '95505930885',
    projectId: 'qadha-bad5c',
    storageBucket: 'qadha-bad5c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZdsXqjsTg39uCK5UKqTNayNks_e80Ojw',
    appId: '1:95505930885:ios:43ac9ca1f992a1a39b27ec',
    messagingSenderId: '95505930885',
    projectId: 'qadha-bad5c',
    storageBucket: 'qadha-bad5c.appspot.com',
    androidClientId: '95505930885-epvauk63u8nb334am2ip13r7lmnn48pe.apps.googleusercontent.com',
    iosClientId: '95505930885-s168fim5p4dn1bmip9u3psgne1gfuj49.apps.googleusercontent.com',
    iosBundleId: 'com.hiraislam.qadha',
  );
}
