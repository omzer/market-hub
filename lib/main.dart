import 'package:flutter/material.dart';
import 'dart:ui' show PointerDeviceKind;
import 'package:e_commerce_flutter/core/app_theme.dart';
import 'package:e_commerce_flutter/src/view/screen/home_screen.dart';
import 'package:e_commerce_flutter/src/view/screen/tutorial_screen.dart';
import 'package:get/get.dart';
import 'package:e_commerce_flutter/src/bindings/app_bindings.dart';
import 'package:e_commerce_flutter/services/prefs_box.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsBox.initStorage();
  final bool tutorialCompleted = PrefsBox.isTutorialCompleted();
  runApp(MyApp(tutorialCompleted: tutorialCompleted));
}

class MyApp extends StatelessWidget {
  final bool tutorialCompleted;

  const MyApp({super.key, required this.tutorialCompleted});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      initialBinding: AppBindings(),
      debugShowCheckedModeBanner: false,
      home: tutorialCompleted ? HomeScreen() : const TutorialScreen(),
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
