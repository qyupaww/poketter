import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poketter/core/global_variable.dart';
import 'package:poketter/locator.dart';
import 'package:poketter/core/themes/morpheme_themes/morpheme_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize all locators via centralized setupLocator
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: MorphemeThemeLight().themeData,
      routerConfig: locator<GoRouter>(),
    );
  }
}
