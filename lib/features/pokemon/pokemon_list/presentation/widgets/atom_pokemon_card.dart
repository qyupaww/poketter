import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poketter/core/assets/assets.dart';
import 'package:poketter/core/components/components.dart';
import 'package:poketter/core/constants/constant_radius.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/extensions/pokemon_color_extension.dart';
import 'package:poketter/core/extensions/string_extensions.dart';
import 'package:poketter/core/themes/morpheme_colors/morpheme_colors.dart';
import 'package:poketter/features/pokemon/pokemon_list/domain/entities/pokemon_list_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'atom_type_badge.dart';

class AtomPokemonCard extends StatelessWidget {
  const AtomPokemonCard({
    super.key,
    required this.pokemon,
    required this.onTap,
  });

  final ResultsPokemonList pokemon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final primaryType = (pokemon.types?.isNotEmpty ?? false)
        ? pokemon.types!.first
        : 'normal';
    final cardColor = context.getPokemonColor(primaryType);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ConstantRadius.r16),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(ConstantRadius.r16),
          boxShadow: [
            BoxShadow(
              color: cardColor.withValues(alpha: 0.4),
              blurRadius: ConstantSizes.s12,
              offset: const Offset(0, ConstantSizes.s4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ConstantRadius.r16),
          child: Stack(
            children: [
              // Pokeball Watermark
              Positioned(
                right: -ConstantSizes.s16,
                bottom: -ConstantSizes.s16,
                child: Skeleton.ignore(
                  child: SvgPicture.asset(
                    MorphemeImages.pokeball,
                    width: ConstantSizes.s80 + ConstantSizes.s20,
                    height: ConstantSizes.s80 + ConstantSizes.s20,
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(ConstantSizes.s12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AtomText.bodyLargeSemiBold(
                      (pokemon.name ?? '').toCapitalized(),
                      color: context.color.pureWhite,
                    ),
                    const AtomSpacing.vertical8(),
                    if (pokemon.types != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: pokemon.types!
                            .map(
                              (type) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: ConstantSizes.s4,
                                ),
                                child: AtomTypeBadge(type: type),
                              ),
                            )
                            .toList(),
                      ),
                  ],
                ),
              ),
              // Pokemon Image
              Positioned(
                right: ConstantSizes.s8,
                bottom: ConstantSizes.s8,
                child: Hero(
                  tag: 'pokemon_image_${pokemon.name}',
                  child: Skeleton.replace(
                    width: ConstantSizes.s72,
                    height: ConstantSizes.s72,
                    child: AtomCachedNetworkImage(
                      imageUrl: pokemon.imageUrl ?? '',
                      width: ConstantSizes.s72,
                      height: ConstantSizes.s72,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
