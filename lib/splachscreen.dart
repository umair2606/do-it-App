import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'signup.dart';
import 'UI/bottom_navigation.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});
  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  void dp() async{

    await FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => SignUp()
        )
        );//
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => BottomNavigation()
        ));
      }
    });
  }
  @override
  void initState() {
    dp();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Center(child: CircularProgressIndicator(),)
    );
  }
}