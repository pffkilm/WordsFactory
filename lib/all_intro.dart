import 'package:flutter/material.dart';
import 'package:project/sign_up.dart';

class AllIntroPages extends StatefulWidget {
  const AllIntroPages({super.key});

  @override
  _AllIntroPagesState createState() => _AllIntroPagesState();
}

class _AllIntroPagesState extends State<AllIntroPages> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _goToSignUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Column(
        children: [
          // Skip button
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, right: 16),
              child: GestureDetector(
                onTap: _goToSignUp,
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 14,
                    //  fontFamily: 'Rubik',
                    color: Color.fromRGBO(120, 116, 109, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                // Страница 1
                _buildPage(
                  image: 'assets/images/illustration.png',
                  title: 'Learn anytime \nand anywhere',
                  description: 'Quarantine is the perfect time to spend your \nday learning something new, from anywhere!',
                ),

                // Страница 2
                _buildPage(
                  image: 'assets/images/familya.png',
                  title: 'Find a course \nfor you',
                  description: 'Quarantine is the perfect time to spend your \nday learning something new, from anywhere!',
                ),

                // Страница 3
                _buildPage(
                  image: 'assets/images/img.png',
                  title: 'Improve your skills',
                  description: 'Quarantine is the perfect time to spend your \nday learning something new, from anywhere!',
                ),

              ],
            ),
          ),



          // Navigation button
          _buildNavigationButton(),
        ],
      ),
    );
  }

  Widget _buildPage({required String image, required String title, required String description}) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(image),
        const SizedBox(height: 20),
        Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
               // fontFamily: 'Rubik',
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: Color.fromRGBO(51, 51, 51, 1),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                // fontFamily: 'Rubik',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color.fromRGBO(109, 109, 120, 1),
              ),
            ),
          ],
        ),

        const SizedBox(height: 30,),
        _buildDotsIndicator(),

        const Spacer(),
      ],
    );
  }

  Widget _buildDotsIndicator() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, top: 5),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          _buildDot(_currentPage == 0),
      const SizedBox(width: 8),
      _buildDot(_currentPage == 1),
      const SizedBox(width: 8),
            _buildDot(_currentPage == 2),
          ],
      ),
    );
  }

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

  Widget _buildNavigationButton() {
    return Container(
      width: 311,
      height: 56,
      margin: const EdgeInsets.only(bottom: 32),
      child: ElevatedButton(
        onPressed: _currentPage == 2
            ? _goToSignUp
            : () => _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(227, 86, 42, 1),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          _currentPage == 2 ? 'Let\'s Start' : 'Next',
          style: const TextStyle(
            // fontFamily: 'Rubik',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}