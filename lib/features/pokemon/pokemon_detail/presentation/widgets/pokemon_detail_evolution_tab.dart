import 'package:flutter/material.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:poketter/core/components/components.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/themes/morpheme_colors/morpheme_colors.dart';
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_detail_entity.dart';
import 'package:poketter/features/pokemon/pokemon_detail/presentation/bloc/evolution_chain/evolution_chain_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonDetailEvolutionTab extends StatelessWidget {
  const PokemonDetailEvolutionTab({
    super.key,
    required this.data,
    required this.isLoading,
  });

  final PokemonDetailEntity? data;
  final bool isLoading;

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvolutionChainBloc, EvolutionChainState>(
      builder: (context, state) {
        final isEvolutionLoading =
            state is EvolutionChainLoading || state is EvolutionChainInitial;

        List<String> evolutionNames = [];

        if (state is EvolutionChainSuccess) {
          final chain = state.data.chain;
          if (chain != null) {
            // Base
            if (chain.species?.name != null) {
              evolutionNames.add(_capitalize(chain.species!.name!));
            }
            // Stage 1
            if (chain.evolvesTo != null && chain.evolvesTo!.isNotEmpty) {
              final stage1 = chain.evolvesTo!.first;
              if (stage1.species?.name != null) {
                evolutionNames.add(_capitalize(stage1.species!.name!));
              }
              // Stage 2
              if (stage1.evolvesTo != null && stage1.evolvesTo!.isNotEmpty) {
                final stage2 = stage1.evolvesTo!.first;
                if (stage2.species?.name != null) {
                  evolutionNames.add(_capitalize(stage2.species!.name!));
                }
              }
            }
          }
        }

        return Skeletonizer(
          enabled: isLoading || isEvolutionLoading,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: ConstantSizes.s24),
            itemCount: evolutionNames.isNotEmpty ? evolutionNames.length : 3,
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: ConstantSizes.s16),
              child: Icon(Icons.arrow_downward, color: context.color.grey),
            ),
            itemBuilder: (context, index) {
              final name = evolutionNames.isNotEmpty
                  ? evolutionNames[index]
                  : 'Evolution Name';
              return Container(
                padding: const EdgeInsets.all(ConstantSizes.s16),
                decoration: BoxDecoration(
                  color: context.color.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(ConstantSizes.s12),
                ),
                child: Center(child: AtomText.bodyLargeSemiBold(name)),
              );
            },
          ),
        );
      },
    );
  }
}
