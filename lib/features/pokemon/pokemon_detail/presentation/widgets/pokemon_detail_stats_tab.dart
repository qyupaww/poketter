import 'package:flutter/material.dart';
import 'package:poketter/core/components/components.dart';
import 'package:poketter/core/constants/constant_radius.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/themes/morpheme_colors/morpheme_colors.dart';
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_detail_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonDetailStatsTab extends StatelessWidget {
  const PokemonDetailStatsTab({
    super.key,
    required this.data,
    required this.isLoading,
    required this.mainColor,
  });

  final PokemonDetailEntity? data;
  final bool isLoading;
  final Color mainColor;

  String _getShortStatName(String name) {
    switch (name.toLowerCase()) {
      case 'hp':
        return 'HP';
      case 'attack':
        return 'Attack';
      case 'defense':
        return 'Defense';
      case 'special-attack':
        return 'Sp. Atk';
      case 'special-defense':
        return 'Sp. Def';
      case 'speed':
        return 'Speed';
      default:
        return name;
    }
  }

  Color _getStatBarColor(int baseStat) {
    if (baseStat < 50) return const Color(0xFFFF3D00);
    if (baseStat < 80) return const Color(0xFFFFAB00);
    if (baseStat < 100) return const Color(0xFF64DD17);
    return const Color(0xFF00C853);
  }

  @override
  Widget build(BuildContext context) {
    if (data?.stats == null && !isLoading) return const SizedBox();
    final stats =
        data?.stats ??
        List.generate(6, (index) => const StatsPokemonDetail(baseStat: 50));

    int totalStats = 0;
    for (var stat in stats) {
      totalStats += stat.baseStat ?? 0;
    }

    return Skeletonizer(
      enabled: isLoading,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Stat Rows
            ...stats.map((stat) {
              final statName = _getShortStatName(stat.stat?.name ?? 'STAT');
              final baseStat = stat.baseStat ?? 0;
              final barColor = _getStatBarColor(baseStat);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: ConstantSizes.s8),
                child: Row(
                  children: [
                    SizedBox(
                      width: ConstantSizes.s72,
                      child: AtomText.bodySmall(
                        statName,
                        color: context.color.grey,
                      ),
                    ),
                    SizedBox(
                      width: ConstantSizes.s32,
                      child: AtomText.bodySmallBold(
                        '$baseStat',
                        color: context.color.black,
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(ConstantRadius.r8),
                        child: LinearProgressIndicator(
                          value: baseStat / 255.0,
                          backgroundColor: context.color.bgGrey,
                          color: barColor,
                          minHeight: ConstantSizes.s4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            // Divider
            Divider(
              height: ConstantSizes.s24,
              thickness: 1,
              color: context.color.grey.withValues(alpha: 0.1),
            ),
            // Total Row
            Row(
              children: [
                SizedBox(
                  width: ConstantSizes.s72,
                  child: AtomText.bodySmallBold(
                    'Total',
                    color: context.color.grey,
                  ),
                ),
                SizedBox(
                  width: ConstantSizes.s32,
                  child: AtomText.bodySmallBold(
                    '$totalStats',
                    color: context.color.black,
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
