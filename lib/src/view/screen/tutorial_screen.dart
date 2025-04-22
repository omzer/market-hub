import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce_flutter/src/view/screen/home_screen.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<TutorialPage> _tutorialPages = [
    TutorialPage(
      title: 'مرحباً بك في متجرنا',
      description: 'اكتشف أحدث المنتجات والعروض الحصرية',
      imagePath: 'assets/images/welcome.png',
    ),
    TutorialPage(
      title: 'تصفح المنتجات',
      description: 'تصفح مجموعتنا الواسعة من المنتجات بسهولة',
      imagePath: 'assets/images/browse-products.png',
    ),
    TutorialPage(
      title: 'أضف إلى السلة',
      description: 'أضف المنتجات المفضلة إلى سلة التسوق الخاصة بك',
      imagePath: 'assets/images/add-to-cart.png',
    ),
    TutorialPage(
      title: 'تتبع طلباتك',
      description: 'تابع حالة طلباتك في أي وقت',
      imagePath: 'assets/images/follow-order.png',
    ),
    TutorialPage(
      title: 'ابدأ التسوق',
      description: 'استمتع بتجربة تسوق سهلة وممتعة',
      imagePath: 'assets/images/shop-now.png',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('tutorial_completed', true);
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _tutorialPages.length,
            itemBuilder: (context, index) {
              return _buildPage(_tutorialPages[index]);
            },
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _tutorialPages.length,
                    (index) => _buildDot(index),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: _currentPage == _tutorialPages.length - 1
                        ? _completeTutorial
                        : () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      _currentPage == _tutorialPages.length - 1
                          ? 'ابدأ الآن'
                          : 'التالي',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(TutorialPage page) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            page.imagePath,
            height: 300,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 40),
          Text(
            page.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            page.description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? Theme.of(context).primaryColor
            : Colors.grey.withOpacity(0.3),
      ),
    );
  }
}

class TutorialPage {
  final String title;
  final String description;
  final String imagePath;

  TutorialPage({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}