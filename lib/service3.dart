import 'package:do_it_app/service4.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class service3 extends StatefulWidget {
  const service3({super.key});

  @override
  State<service3> createState() => _Screen2State();
}

class _Screen2State extends State<service3> {
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
                Image.asset("assets/images/team-manegement.png", height: 250),
                const SizedBox(height: 100),
                Text(
                  "Create a team task,invite\n people and manage your\n work together.",
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
                          MaterialPageRoute(builder: (context) => service4()),
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
