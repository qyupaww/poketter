import 'package:flutter/material.dart';
import 'package:poketter/core/locator.dart';
import 'package:poketter/features/pokemon/locator.dart';
import 'package:poketter/features/pokemon/pokemon_list/presentation/pages/pokemon_list_page.dart';
import 'package:poketter/core/themes/morpheme_themes/morpheme_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize locators
  setupLocatorCore();
  setupLocatorFeaturePokemon();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: MorphemeThemeLight().themeData,
      home: const PokemonListPage(),
    );
  }
}
