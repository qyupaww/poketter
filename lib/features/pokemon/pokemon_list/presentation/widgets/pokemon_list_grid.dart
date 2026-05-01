import 'package:flutter/material.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/features/pokemon/pokemon_list/domain/entities/pokemon_list_entity.dart';
import 'package:poketter/features/pokemon/pokemon_list/presentation/cubit/pokemon_list_cubit.dart';

import 'atom_pokemon_card.dart';

class PokemonListGrid extends StatelessWidget {
  const PokemonListGrid({
    super.key,
    required this.items,
    required this.isLoading,
  });

  final List<ResultsPokemonList> items;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(ConstantSizes.defaultPadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: ConstantSizes.s16,
        mainAxisSpacing: ConstantSizes.s16,
        childAspectRatio: 1.25,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        // Extract ID from URL
        final id = item.url?.split('/').reversed.elementAt(1) ?? '1';

        return AtomPokemonCard(
          pokemon: item,
          onTap: () {
            if (!isLoading) {
              context.read<PokemonListCubit>().goToDetail(context, id);
            }
          },
        );
      },
    );
  }
}
