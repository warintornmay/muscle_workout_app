import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCNGGVb5-rwC1-DAUX1h8yIWs-FC2-nyKk",
            authDomain: "workout02-4b425.firebaseapp.com",
            projectId: "workout02-4b425",
            storageBucket: "workout02-4b425.appspot.com",
            messagingSenderId: "244756081703",
            appId: "1:244756081703:web:f45f6d5f2a975891e33202"));
  } else {
    await Firebase.initializeApp();
  }
}
