import 'package:flutter/material.dart';
import 'package:project/all_intro.dart';


class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AllIntroPages()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash.png',
            ),
            const SizedBox(height: 20),
            Container(
              width: 375,
              height: 46,
              child: const Opacity(
                opacity: 1.0,
                child: Text(
                  'WordsFactory',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                     // fontFamily: 'Rubik',
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                    height: 1.15,
                    letterSpacing: -1,
                    color: Color(0xFF3C3A36),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}