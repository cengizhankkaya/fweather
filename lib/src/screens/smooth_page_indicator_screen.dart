import 'package:flutter/material.dart';

import 'package:fweather/src/constants/paths.dart';
import 'package:fweather/src/constants/text.dart';
import 'package:fweather/src/screens/MainScreen.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _buildPage(
                color: Colors.red,
                image: AssetPaths.wolfImage,
                text: page1text,
                textColor: Colors.white, // Metin rengi
                buttonLabel: "Next",
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              _buildPage(
                color: Colors.blue,
                image: AssetPaths.smoothImage2,
                text: page2text,
                textColor: Colors.white, // Metin rengi
                buttonLabel: "Next",
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
              _buildPage(
                color: Colors.green,
                image: AssetPaths.smoothImage3,
                text: page3text,
                textColor: Colors.white, // Metin rengi
                buttonLabel: "Get Started",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: const WormEffect(),
                onDotClicked: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required Color color,
    required String image,
    required String text,
    required Color textColor, // Metin rengi için parametre
    required String buttonLabel,
    required VoidCallback onPressed,
  }) {
    return Container(
      color: color,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 300,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: textColor, // Burada metin rengini ayarladım
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(buttonLabel),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Butonun arka plan rengi
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  textStyle: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
