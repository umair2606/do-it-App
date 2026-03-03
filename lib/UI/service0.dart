import 'package:do_it_app/service1.dart';
import 'package:flutter/material.dart';

class service0 extends StatefulWidget {
  const service0({super.key});

  @override
  State<service0> createState() => _service0State();
}

class _service0State extends State<service0> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => service1()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 411,
        height: 1500,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1253AA), Color(0xFF05243E)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            Image.asset("assets/images/icon.png", width: 100, height: 100),
            const SizedBox(height: 20),
            const Text(
              "DO IT",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            const Text(
              "v 1.0.0",
              style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold,fontFamily: 'Poppins'),
            ),
            const SizedBox(height: 250),
          ],
        ),
      ),
    );
  }
}
