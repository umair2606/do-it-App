import 'package:do_it_app/service2.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class service1 extends StatefulWidget {
  const service1({super.key});

  @override
  State<service1> createState() => _Screen2State();
}

class _Screen2State extends State<service1> {
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
                const SizedBox(height: 10),
                Image.asset("assets/images/check.png", height: 300),
                const SizedBox(height: 100),
                Text(
                  "Plan your tasks to do, that \nway you’ll stay organized\nand you won’t skip any",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 157),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/slider.png"),
                    SizedBox(width: 1),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => service2()),
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
