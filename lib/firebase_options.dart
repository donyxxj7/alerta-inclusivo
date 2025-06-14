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
    apiKey: 'AIzaSyBCC5BfjaPKNWYX1Z-AknzcWJjrzi7ibMY',
    appId: '1:448050847358:web:9a3bcff6e5249fffac822f',
    messagingSenderId: '448050847358',
    projectId: 'alerta-inclusivo-app',
    authDomain: 'alerta-inclusivo-app.firebaseapp.com',
    storageBucket: 'alerta-inclusivo-app.firebasestorage.app',
    measurementId: 'G-TLBVE683SQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC49MbdJ7vfm1i01zUINzlFDrkD-wfJugs',
    appId: '1:448050847358:android:9c663590724b1082ac822f',
    messagingSenderId: '448050847358',
    projectId: 'alerta-inclusivo-app',
    storageBucket: 'alerta-inclusivo-app.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBEv_yAE-PCUTjZIZje1cMNcnBt5o0BiEU',
    appId: '1:448050847358:ios:f502340f53343857ac822f',
    messagingSenderId: '448050847358',
    projectId: 'alerta-inclusivo-app',
    storageBucket: 'alerta-inclusivo-app.firebasestorage.app',
    iosBundleId: 'com.example.alertaInclusivo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBEv_yAE-PCUTjZIZje1cMNcnBt5o0BiEU',
    appId: '1:448050847358:ios:f502340f53343857ac822f',
    messagingSenderId: '448050847358',
    projectId: 'alerta-inclusivo-app',
    storageBucket: 'alerta-inclusivo-app.firebasestorage.app',
    iosBundleId: 'com.example.alertaInclusivo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBCC5BfjaPKNWYX1Z-AknzcWJjrzi7ibMY',
    appId: '1:448050847358:web:79e60b7e32e051e9ac822f',
    messagingSenderId: '448050847358',
    projectId: 'alerta-inclusivo-app',
    authDomain: 'alerta-inclusivo-app.firebaseapp.com',
    storageBucket: 'alerta-inclusivo-app.firebasestorage.app',
    measurementId: 'G-8LKWYZDPY7',
  );
}
