import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:poketter/core/assets/assets.dart';
import 'package:poketter/core/components/components.dart';
import 'package:poketter/core/constants/constant_radius.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/extensions/pokemon_color_extension.dart';
import 'package:poketter/core/extensions/string_extensions.dart';
import 'package:poketter/core/global_variable.dart';
import 'package:poketter/core/themes/morpheme_colors/morpheme_colors.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_detail_body.dart';
import 'package:poketter/features/pokemon/pokemon_detail/presentation/bloc/pokemon_detail/pokemon_detail_bloc.dart';
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
  late final PokemonDetailBloc _detailBloc;

  @override
  void initState() {
    super.initState();
    _detailBloc = locator<PokemonDetailBloc>();
    final paths = widget.pokemon.url
        ?.split('/')
        .where((e) => e.isNotEmpty)
        .toList();
    final id = paths?.isNotEmpty == true ? paths!.last : null;
    if (id != null) {
      _detailBloc.add(FetchPokemonDetail(PokemonDetailBody(id: id)));
    }
  }

  @override
  void dispose() {
    _detailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _detailBloc,
      child: BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
        builder: (context, state) {
          final types =
              widget.pokemon.types ??
              (state is PokemonDetailSuccess
                  ? state.data.types
                        ?.map((e) => e.type?.name ?? 'normal')
                        .toList()
                  : null);

          final primaryType = (types?.isNotEmpty ?? false)
              ? types!.first
              : 'normal';
          final cardColor = context.getPokemonColor(primaryType);

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
                            (widget.pokemon.name ?? '').toCapitalized(),
                            color: context.color.pureWhite,
                          ),
                          const AtomSpacing.vertical8(),
                          if (types == null && state is PokemonDetailLoading)
                            const Skeletonizer(
                              child: AtomTypeBadge(type: 'loading'),
                            )
                          else if (types != null)
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
                    // Pokemon Image
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
      ),
    );
  }
}
