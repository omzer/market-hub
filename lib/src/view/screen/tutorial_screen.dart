import 'package:flutter/material.dart';
import 'package:e_commerce_flutter/src/view/screen/home_screen.dart';
import 'package:e_commerce_flutter/services/prefs_box.dart';

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
      backgroundColor: const Color(0xFFFEF9EB),
    ),
    TutorialPage(
      title: 'ابدأ التسوق',
      description: 'وكأنك موجود في قلب المتجر',
      backgroundColor: const Color(0xFFFEFAED),
      imagePath: 'assets/images/shop-now.png',
    ),
    TutorialPage(
      title: 'تصفح المنتجات',
      description: 'تصفح مجموعتنا الواسعة من المنتجات بسهولة',
      imagePath: 'assets/images/browse-products.png',
      backgroundColor: const Color(0xFFFDFDF4),
    ),
    TutorialPage(
      title: 'أضف إلى السلة',
      description: 'أضف المنتجات المفضلة إلى سلة التسوق الخاصة بك',
      imagePath: 'assets/images/add-to-cart.png',
      backgroundColor: const Color(0xFFFDFEFD),
    ),
    TutorialPage(
      title: 'تتبع طلباتك',
      description: 'تابع حالة طلباتك في أي وقت',
      imagePath: 'assets/images/follow-order.png',
      backgroundColor: Colors.white,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Animated background
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            color: _tutorialPages[_currentPage].backgroundColor,
          ),
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _tutorialPages.length,
            itemBuilder: (context, index) {
              return _buildPage(
                  _tutorialPages[index], screenHeight, screenWidth);
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
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
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

  Widget _buildPage(
      TutorialPage page, double screenHeight, double screenWidth) {
    // Calculate image height based on screen size
    // Using 40% of screen height for the image
    final imageHeight = screenHeight * 0.4;
    // Calculate maximum width to maintain aspect ratio
    final maxWidth = screenWidth * 0.8;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: imageHeight,
            width: maxWidth,
            child: Image.asset(
              page.imagePath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                Text(
                  page.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  page.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
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

  Future<void> _completeTutorial() async {
    await PrefsBox.setTutorialCompleted();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }
}

class TutorialPage {
  final String title;
  final String description;
  final String imagePath;
  final Color backgroundColor;

  TutorialPage({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.backgroundColor,
  });
}
