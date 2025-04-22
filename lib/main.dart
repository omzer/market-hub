import 'package:flutter/material.dart';
import 'dart:ui' show PointerDeviceKind;
import 'package:e_commerce_flutter/core/app_theme.dart';
import 'package:e_commerce_flutter/src/view/screen/home_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/tutorial_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  // final bool tutorialCompleted = prefs.getBool('tutorial_completed') ?? false;
  final bool tutorialCompleted = false;

  runApp(MyApp(tutorialCompleted: tutorialCompleted));
}

class MyApp extends StatelessWidget {
  final bool tutorialCompleted;

  const MyApp({super.key, required this.tutorialCompleted});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      debugShowCheckedModeBanner: false,
      home: tutorialCompleted ? const HomeScreen() : const TutorialScreen(),
      theme: AppTheme.lightAppTheme,
      locale: const Locale('ar'),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}
