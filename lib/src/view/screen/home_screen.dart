import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:e_commerce_flutter/core/app_data.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:e_commerce_flutter/src/view/screen/profile_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/products_screen.dart';
import 'package:e_commerce_flutter/src/view/animation/page_transition_switcher_wrapper.dart';
import 'package:e_commerce_flutter/src/controller/categories_controller.dart';

class HomeScreen extends GetView<CategoriesController> {
  const HomeScreen({super.key});

  static const List<Widget> screens = [
    ProductsScreen(),
    Placeholder(),
    Placeholder(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final RxInt selectedIndex = 0.obs;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Obx(() {
          return Scaffold(
            bottomNavigationBar: StylishBottomBar(
              currentIndex: selectedIndex.value,
              onTap: (index) {
                selectedIndex.value = index;
              },
              items: AppData.bottomNavBarItems
                  .map(
                    (item) => BottomBarItem(
                      backgroundColor: item.activeColor,
                      icon: item.icon,
                      title: Text(
                        item.title,
                        style: TextStyle(
                          color: item.activeColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              option: BubbleBarOptions(
                opacity: 0.3,
                unselectedIconColor: Colors.grey,
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
            ),
            body: controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepOrange,
                    ),
                  )
                : Obx(() => PageTransitionSwitcherWrapper(
                      duration: const Duration(milliseconds: 300),
                      child: screens[selectedIndex.value],
                    )),
          );
        }),
      ),
    );
  }
}
