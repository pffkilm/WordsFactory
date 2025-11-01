import 'package:flutter/material.dart';
import 'package:project/Dictionary.dart';
import 'package:project/intro2.dart';
import 'package:project/sign_up.dart';

class Intro3 extends StatelessWidget {
  const Intro3({super.key});

  void _goToPage(BuildContext context, Widget page) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx > 10) {
          _goToPage(context, const Intro2()); // Свайп вправо
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1), // Белый фон
        body: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 40, right: 16),
                child: GestureDetector(
                  onTap: () => _goToPage(context, const SignUp( )),
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Rubik',
                      color: Color.fromRGBO(120, 116, 109, 1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),

            Spacer(),

            // Content
            Column(
              children: [
                Image.asset('assets/images/img.png'),
                const SizedBox(height: 20),
                const Column(
                  children: [
                    Text(
                      'Improve your skills',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: Color.fromRGBO(51, 51, 51, 1),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Quarantine is the perfect time to spend your \nday learning something new, from anywhere!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color.fromRGBO(109, 109, 120, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Dots indicator
            Container(
              margin: const EdgeInsets.only(bottom: 20, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDot(false), // Первая точка - неактивная
                  const SizedBox(width: 8),
                  _buildDot(false), // Вторая точка - неактивная
                  const SizedBox(width: 8),
                  _buildDot(true),  // Третья точка - активная
                ],
              ),
            ),

            Spacer(),

            // Let's Start button
            Container(
              width: 311,
              height: 56,
              margin: const EdgeInsets.only(bottom: 32),
              child: ElevatedButton(
                onPressed: () => _goToPage(context, const SignUp()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(227, 86, 42, 1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Let\'s Start',
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Функция для создания точек
  Widget _buildDot(bool isActive) {
    return Container(
      width: isActive ? 16 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive
            ? const Color.fromRGBO(101, 170, 234, 1)
            : const Color.fromRGBO(213, 212, 212, 1),
        borderRadius: BorderRadius.circular(isActive ? 4 : 3),
      ),
    );
  }
}