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
    apiKey: 'AIzaSyCSpJkbD0PpFP6gmod6KYE_6GBnqxOmURc',
    appId: '1:963985215657:web:4fe8dee6e032fb9ea459b8',
    messagingSenderId: '963985215657',
    projectId: 'projetos-tcc-tcc',
    authDomain: 'projetos-tcc-tcc.firebaseapp.com',
    storageBucket: 'projetos-tcc-tcc.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDbauLqLZMn5-lJOfDVpxXokwT6g12_5sQ',
    appId: '1:963985215657:android:9b75d8e0c10fc70ba459b8',
    messagingSenderId: '963985215657',
    projectId: 'projetos-tcc-tcc',
    storageBucket: 'projetos-tcc-tcc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrv6Q-D3tthXiAiXOSUsr7iqMFTcJciaE',
    appId: '1:963985215657:ios:1749ef5c4bbd8dd8a459b8',
    messagingSenderId: '963985215657',
    projectId: 'projetos-tcc-tcc',
    storageBucket: 'projetos-tcc-tcc.appspot.com',
    iosClientId:
        '963985215657-2147s8i4mev4kn2s5mj3i780ku21ooda.apps.googleusercontent.com',
    iosBundleId: 'com.example.projetoTcc',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrv6Q-D3tthXiAiXOSUsr7iqMFTcJciaE',
    appId: '1:963985215657:ios:1749ef5c4bbd8dd8a459b8',
    messagingSenderId: '963985215657',
    projectId: 'projetos-tcc-tcc',
    storageBucket: 'projetos-tcc-tcc.appspot.com',
    iosClientId:
        '963985215657-2147s8i4mev4kn2s5mj3i780ku21ooda.apps.googleusercontent.com',
    iosBundleId: 'com.example.projetoTcc',
  );
}
