import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poketter/core/assets/assets.dart';
import 'package:poketter/core/components/components.dart';
import 'package:poketter/core/constants/constant_radius.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/global_variable.dart';
import 'package:poketter/core/extensions/pokemon_color_extension.dart';
import 'package:poketter/core/extensions/string_extensions.dart';
import 'package:poketter/core/themes/morpheme_colors/morpheme_colors.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_detail_body.dart';
import 'package:poketter/features/pokemon/pokemon_detail/domain/usecases/pokemon_detail_use_case.dart';
import 'package:poketter/features/pokemon/pokemon_list/domain/entities/pokemon_list_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'atom_type_badge.dart';

class AtomPokemonCard extends StatefulWidget {
  const AtomPokemonCard({
    super.key,
    required this.pokemon,
    required this.onTap,
  });

  final ResultsPokemonList pokemon;
  final VoidCallback onTap;

  @override
  State<AtomPokemonCard> createState() => _AtomPokemonCardState();
}

class _AtomPokemonCardState extends State<AtomPokemonCard> {
  static final Map<String, List<String>> _typeCache = {};
  late Future<List<String>?> _typesFuture;

  @override
  void initState() {
    super.initState();
    _typesFuture = _resolveTypes();
  }

  @override
  void didUpdateWidget(covariant AtomPokemonCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pokemon.id != widget.pokemon.id ||
        oldWidget.pokemon.types != widget.pokemon.types) {
      _typesFuture = _resolveTypes();
    }
  }

  Future<List<String>?> _resolveTypes() async {
    final existingTypes = widget.pokemon.types;
    if (existingTypes != null && existingTypes.isNotEmpty) {
      return existingTypes;
    }

    final id = widget.pokemon.id;
    if (id == '0') return null;

    final cached = _typeCache[id];
    if (cached != null && cached.isNotEmpty) {
      return cached;
    }

    final result = await locator<PokemonDetailUseCase>()(
      PokemonDetailBody(id: id),
    );

    return result.fold((_) => null, (detail) {
      final types =
          detail.types?.map((e) => e.type?.name).whereType<String>().toList() ??
          <String>[];
      if (types.isNotEmpty) {
        _typeCache[id] = types;
      }
      return types;
    });
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.pokemon.name ?? '';
    return FutureBuilder<List<String>?>(
      future: _typesFuture,
      builder: (context, snapshot) {
        final types = widget.pokemon.types ?? snapshot.data;
        final primaryType = (types?.isNotEmpty ?? false) ? types!.first : null;
        final cardColor = primaryType != null
            ? context.getPokemonColor(primaryType)
            : context.color.grey;

        return InkWell(
          onTap: widget.onTap,
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
                  Padding(
                    padding: const EdgeInsets.all(ConstantSizes.s12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AtomText.bodyLargeSemiBold(
                          name.toCapitalized(),
                          color: context.color.pureWhite,
                        ),
                        const AtomSpacing.vertical8(),
                        if (types == null &&
                            snapshot.connectionState == ConnectionState.waiting)
                          const Skeletonizer(
                            child: AtomTypeBadge(type: 'loading'),
                          )
                        else if (types != null && types.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: types
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
                  Positioned(
                    right: ConstantSizes.s8,
                    bottom: ConstantSizes.s8,
                    child: Hero(
                      tag: 'pokemon_image_${widget.pokemon.name}',
                      child: Skeleton.replace(
                        width: ConstantSizes.s72,
                        height: ConstantSizes.s72,
                        child: AtomCachedNetworkImage(
                          imageUrl: widget.pokemon.imageUrl ?? '',
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
      },
    );
  }
}
