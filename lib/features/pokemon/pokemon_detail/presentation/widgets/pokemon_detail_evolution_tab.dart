import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:poketter/core/assets/assets.dart';
import 'package:poketter/core/components/components.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/themes/morpheme_colors/morpheme_colors.dart';
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_detail_entity.dart';
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/evolution_chain_entity.dart';
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

  String? _getId(String? url) {
    if (url == null) return null;
    final paths = url.split('/').where((e) => e.isNotEmpty).toList();
    if (paths.isNotEmpty) return paths.last;
    return null;
  }

  String _getImageUrl(String? id) {
    if (id == null) return '';
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }

  List<Map<String, dynamic>> _getEvolutionPairs(ChainEvolutionChain? chain) {
    final List<Map<String, dynamic>> pairs = [];

    if (chain != null && chain.evolvesTo != null) {
      for (final stage1 in chain.evolvesTo!) {
        pairs.add({
          'fromName': chain.species?.name,
          'fromId': _getId(chain.species?.url),
          'toName': stage1.species?.name,
          'toId': _getId(stage1.species?.url),
          'minLevel': stage1.evolutionDetails?.firstOrNull?.minLevel,
        });

        if (stage1.evolvesTo != null) {
          for (final stage2 in stage1.evolvesTo!) {
            pairs.add({
              'fromName': stage1.species?.name,
              'fromId': _getId(stage1.species?.url),
              'toName': stage2.species?.name,
              'toId': _getId(stage2.species?.url),
              'minLevel': stage2.evolutionDetails?.firstOrNull?.minLevel,
            });
          }
        }
      }
    }
    return pairs;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvolutionChainBloc, EvolutionChainState>(
      builder: (context, state) {
        final isEvolutionLoading =
            state is EvolutionChainLoading || state is EvolutionChainInitial;

        List<Map<String, dynamic>> evolutionPairs = [];

        if (state is EvolutionChainSuccess) {
          evolutionPairs = _getEvolutionPairs(state.data.chain);
        } else if (isLoading || isEvolutionLoading) {
          // Dummy data for skeleton loading
          evolutionPairs = [
            {
              'fromName': 'loading',
              'fromId': '1',
              'toName': 'loading',
              'toId': '2',
              'minLevel': 16,
            },
            {
              'fromName': 'loading',
              'fromId': '2',
              'toName': 'loading',
              'toId': '3',
              'minLevel': 32,
            },
          ];
        }

        return Skeletonizer(
          enabled: isLoading || isEvolutionLoading,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: ConstantSizes.s2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AtomText.bodyLargeSemiBold(
                  'Evolution Chain',
                  color: context.color.black,
                ),
                const AtomSpacing.vertical24(),
                if (evolutionPairs.isEmpty)
                  Center(
                    child: AtomText.bodyMedium(
                      'No Evolutions',
                      color: context.color.grey,
                    ),
                  ),
                ...evolutionPairs.map((pair) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: ConstantSizes.s32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildPokemonItem(
                          context,
                          _capitalize(pair['fromName'] ?? ''),
                          _getImageUrl(pair['fromId']),
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.arrow_forward,
                              color: context.color.grey,
                              size: ConstantSizes.s24,
                            ),
                            if (pair['minLevel'] != null) ...[
                              const AtomSpacing.vertical4(),
                              AtomText.bodySmall(
                                'Lvl ${pair['minLevel']}',
                                color: context.color.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ],
                        ),
                        _buildPokemonItem(
                          context,
                          _capitalize(pair['toName'] ?? ''),
                          _getImageUrl(pair['toId']),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPokemonItem(BuildContext context, String name, String imageUrl) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: ConstantSizes.s80 + ConstantSizes.s20,
              height: ConstantSizes.s80 + ConstantSizes.s20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.color.grey.withValues(alpha: 0.1),
              ),
              child: Opacity(
                opacity: 0.15,
                child: Center(
                  child: SvgPicture.asset(
                    MorphemeImages.pokeball,
                    width: ConstantSizes.s64,
                    height: ConstantSizes.s64,
                    colorFilter: ColorFilter.mode(
                      context.color.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            AtomCachedNetworkImage(
              imageUrl: imageUrl,
              width: ConstantSizes.s80,
              height: ConstantSizes.s80,
              fit: BoxFit.contain,
            ),
          ],
        ),
        const AtomSpacing.vertical8(),
        AtomText.bodyLargeSemiBold(name, color: context.color.black),
      ],
    );
  }
}
