import 'package:do_it_app/signup.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class service4 extends StatefulWidget {
  const service4({super.key});

  @override
  State<service4> createState() => _Screen2State();
}

class _Screen2State extends State<service4> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

          child: Container(
            width: 411,
            height: 1500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1253AA), Color(0xFF05243E)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10), // Add spacing from top
                Image.asset("assets/images/protect.png", height: 300),
                const SizedBox(height: 100),
                Text(
                  "You informations are secure with us",
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    wordSpacing: 0,
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 180),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/slider.png"),
                    SizedBox(width: 1),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Image.asset("assets/images/next_button (1).png"),
                    ),
                  ],
                ),
              ],
            ),
          ),

      ),
    );
  }
}
