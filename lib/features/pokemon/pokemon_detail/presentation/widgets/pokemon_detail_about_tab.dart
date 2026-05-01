import 'package:flutter/material.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:poketter/core/components/components.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/themes/morpheme_colors/morpheme_colors.dart';
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_detail_entity.dart';
import 'package:poketter/features/pokemon/pokemon_detail/presentation/bloc/pokemon_species/pokemon_species_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonDetailAboutTab extends StatelessWidget {
  const PokemonDetailAboutTab({
    super.key,
    required this.data,
    required this.isLoading,
  });

  final PokemonDetailEntity? data;
  final bool isLoading;

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final weightKg = (data?.weight ?? 0) / 10;
    final weightLbs = (weightKg * 2.20462).toStringAsFixed(1);
    final heightM = (data?.height ?? 0) / 10;
    final heightFeet = (heightM * 3.28084);
    final feet = heightFeet.floor();
    final inches = ((heightFeet - feet) * 12).round();

    final types =
        data?.types
            ?.map((t) => _capitalizeFirst(t.type?.name ?? ''))
            .join(', ') ??
        '-';

    return Skeletonizer(
      enabled: isLoading,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // About Info Table
            _buildInfoRow(
              context,
              label: 'Species',
              value: _capitalizeFirst(data?.name ?? 'Unknown'),
            ),
            _buildDivider(context),
            _buildInfoRow(
              context,
              label: 'Height',
              value: "$feet'$inches\" (${heightM.toStringAsFixed(2)} m)",
            ),
            _buildDivider(context),
            _buildInfoRow(
              context,
              label: 'Weight',
              value: '$weightLbs lbs (${weightKg.toStringAsFixed(1)} kg)',
            ),
            _buildDivider(context),
            _buildInfoRow(context, label: 'Type', value: types),
            const AtomSpacing.vertical24(),
            // Breeding Section
            AtomText.bodyMediumBold('Breeding', color: context.color.black),
            const AtomSpacing.vertical12(),
            BlocBuilder<PokemonSpeciesBloc, PokemonSpeciesState>(
              builder: (context, state) {
                final isSpeciesLoading = state is PokemonSpeciesLoading || state is PokemonSpeciesInitial;
                String eggGroups = '-';
                String eggCycle = '-';
                
                if (state is PokemonSpeciesSuccess) {
                  final species = state.data;
                  if (species.eggGroups != null && species.eggGroups!.isNotEmpty) {
                    eggGroups = species.eggGroups!.map((e) => _capitalizeFirst(e.name ?? '')).join(', ');
                  }
                  if (species.hatchCounter != null) {
                    final steps = species.hatchCounter! * 255;
                    eggCycle = '${species.hatchCounter} ($steps steps)';
                  }
                }

                return Skeletonizer(
                  enabled: isSpeciesLoading || isLoading,
                  child: Column(
                    children: [
                      _buildInfoRow(context, label: 'Egg Groups', value: eggGroups),
                      _buildDivider(context),
                      _buildInfoRow(context, label: 'Egg Cycle', value: eggCycle),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: ConstantSizes.s12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: ConstantSizes.s80,
            child: AtomText.bodySmall(label, color: context.color.grey),
          ),
          const SizedBox(width: ConstantSizes.s16),
          Expanded(
            child: AtomText.bodySmallBold(value, color: context.color.black),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: context.color.grey.withValues(alpha: 0.1),
    );
  }
}
