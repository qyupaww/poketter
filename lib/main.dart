import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poketter/core/global_variable.dart';
import 'package:poketter/locator.dart';
import 'package:poketter/core/themes/morpheme_themes/morpheme_themes.dart';

import 'package:morpheme_cached_network_image/morpheme_cached_network_image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MorphemeCachedNetworkImageManager.instance.init();

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
