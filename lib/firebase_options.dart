import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return FirebaseOptions(
      apiKey: "AIzaSyBciC_wSo7kh_er3QGEOY6eAFcYdJNBcwc",
      authDomain: "bienestar-canino.firebaseapp.com",
      databaseURL: "https://bienestar-canino-default-rtdb.firebaseio.com",
      projectId: "bienestar-canino",
      storageBucket: "bienestar-canino.firebasestorage.app",
      messagingSenderId: "273835896234",
      appId: "1:273835896234:web:2fa0945f941dc0d4160fd3",
      measurementId: "G-2KK26FSLKX"
    );
  }
}
