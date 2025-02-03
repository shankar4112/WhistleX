import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'counter_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int totalPages = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView to slide between intro pages
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              _buildPageContent(
                image: 'assets/whistle1.png', // Updated image name
                title: "Effortless Whistle Tracking",
                content:
                    "Easily keep track of the number of whistles detected with just a tap.",
              ),
              _buildPageContent(
                image: 'assets/whistle2.png', // Updated image name
                title: "Real-Time Counter",
                content: "Watch the counter update in real time as whistles are detected.",
              ),
              _buildPageContent(
                image: 'assets/whistle3.png', // Updated image name
                title: "Ideal for Events",
                content: "Perfect for managing activities or events where you need to count whistles.",
              ),
            ],
          ),

          Positioned(
            top: 50,
            right: 20,
            child: _currentPage != totalPages - 1
                ? TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(totalPages - 1);
                    },
                    child: const Text("Skip"),
                  )
                : Container(),
          ),
          Positioned(
            bottom: 80,
            left: MediaQuery.of(context).size.width * 0.45,
            child: Row(
              children: List.generate(totalPages, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.blue : const Color.fromARGB(255, 255, 255, 255),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage < totalPages - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                } else {
                  _completeOnboarding(context);
                }
              },
              child: Text(
                _currentPage == totalPages - 1 ? "Get Started" : "Next",
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Save onboarding status and navigate to counter page
  Future<void> _completeOnboarding(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true); // Set onboarding as seen
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CounterPage())); // Navigate to counter page
  }

  Widget _buildPageContent(
      {required String image, required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 250),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            content,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
