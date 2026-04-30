import 'package:flutter/material.dart';
import 'package:poketter/core/themes/morpheme_colors/src/morpheme_color.dart';

extension PokemonColorExtension on BuildContext {
  Color getPokemonColor(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return color.typeNormal;
      case 'fire':
        return color.typeFire;
      case 'water':
        return color.typeWater;
      case 'electric':
        return color.typeElectric;
      case 'grass':
        return color.typeGrass;
      case 'ice':
        return color.typeIce;
      case 'fighting':
        return color.typeFighting;
      case 'poison':
        return color.typePoison;
      case 'ground':
        return color.typeGround;
      case 'flying':
        return color.typeFlying;
      case 'psychic':
        return color.typePsychic;
      case 'bug':
        return color.typeBug;
      case 'rock':
        return color.typeRock;
      case 'ghost':
        return color.typeGhost;
      case 'dragon':
        return color.typeDragon;
      case 'dark':
        return color.typeDark;
      case 'steel':
        return color.typeSteel;
      case 'fairy':
        return color.typeFairy;
      default:
        return color.grey;
    }
  }
}
