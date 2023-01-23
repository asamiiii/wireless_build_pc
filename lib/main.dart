import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:wireless_build/login%20screen/login_screen.dart';
import 'firebase_manager/firebase_manager.dart';


void main() async{
    WidgetsFlutterBinding.ensureInitialized();
   Firestore.initialize(projectId);
   
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:LogingScreen(),
    );
  }
}

