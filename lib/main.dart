import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screens/landing_page.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb ){
   await  Firebase.initializeApp(options: FirebaseOptions(
  apiKey: "AIzaSyBIydjpYArrETEL9i36BUf8B4l9I7jh6-A",
  authDomain: "readify-app-9edbb.firebaseapp.com",
  projectId: "readify-app-9edbb",
  storageBucket: "readify-app-9edbb.firebasestorage.app",
  messagingSenderId: "705481807816",
  appId: "1:705481807816:web:eccaaa10e1e219e85352fd"

  )
  );
  }
  else{
await  Firebase.initializeApp();
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Readify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage() // Set the LandingPage as the home screen
    );
  }
}
