import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fweather/src/screens/MainScreen.dart';
import 'package:fweather/src/screens/smooth_page_indicator_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isFirstTime = await _checkFirstTime();

  runApp(
    ProviderScope(
      child: MyApp(isFirstTime: isFirstTime),
    ),
  );
}

// SharedPreferences kullanarak uygulamanın ilk defa açılıp açılmadığını kontrol edin.
Future<bool> _checkFirstTime() async {
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;

  // İlk kez açılıyorsa durumu güncelle.
  if (isFirstTime) {
    await prefs.setBool('isFirstTime', false);
  }

  return isFirstTime;
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isFirstTime ? OnboardingScreen() : const MainScreen(),
    );
  }
}
