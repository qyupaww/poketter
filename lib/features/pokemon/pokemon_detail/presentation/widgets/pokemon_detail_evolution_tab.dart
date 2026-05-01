import 'package:flutter/material.dart';
import 'package:poketter/core/components/components.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/themes/morpheme_colors/morpheme_colors.dart';
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_detail_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonDetailEvolutionTab extends StatelessWidget {
  const PokemonDetailEvolutionTab({
    super.key,
    required this.data,
    required this.isLoading,
  });

  final PokemonDetailEntity? data;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome,
              size: ConstantSizes.s64,
              color: context.color.grey,
            ),
            const AtomSpacing.vertical12(),
            AtomText.bodyMediumBold(
              'Evolution Chain',
              color: context.color.grey,
            ),
            const AtomSpacing.vertical4(),
            AtomText.bodySmall(
              'API data for evolutions is not yet mapped.',
              color: context.color.grey,
            ),
          ],
        ),
      ),
    );
  }
}
