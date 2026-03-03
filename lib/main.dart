import 'dart:developer';
import 'package:do_it_app/UI/home.dart';
import 'package:do_it_app/complete_tasks.dart';
import 'package:do_it_app/homescreen.dart';
import 'package:do_it_app/last_page.dart';
import 'package:do_it_app/profile_screen.dart';
import 'package:do_it_app/create_task_page.dart';
import 'package:do_it_app/UI/service0.dart';
import 'package:do_it_app/UI/my_calender.dart';
import 'package:do_it_app/UI/my_setting.dart';
import 'package:do_it_app/UI/tasks_page.dart';
import 'package:do_it_app/UI/bottom_navigation.dart';
import 'package:do_it_app/signup.dart';
import 'package:do_it_app/verification_page.dart';
import 'package:do_it_app/service1.dart';
import 'package:do_it_app/service2.dart';
import 'package:do_it_app/service3.dart';
import 'package:do_it_app/service4.dart';
import 'package:do_it_app/signin.dart';
import 'package:do_it_app/splachscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home:BottomNavigation());
  }
}
