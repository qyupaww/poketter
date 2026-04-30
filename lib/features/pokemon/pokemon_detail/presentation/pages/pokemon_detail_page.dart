import 'package:morpheme_base/morpheme_base.dart';
import 'package:poketter/core/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:poketter/core/components/components.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:poketter/features/pokemon/pokemon_detail/presentation/bloc/pokemon_detail/pokemon_detail_bloc.dart';
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_detail_entity.dart';
import 'package:poketter/core/themes/morpheme_colors/morpheme_colors.dart';
import 'package:poketter/core/extensions/pokemon_color_extension.dart';
import 'package:poketter/core/extensions/string_extensions.dart';

import '../cubit/pokemon_detail_cubit.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({super.key, required this.id});
  
  final String id;

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage>
    with MorphemeStatePage<PokemonDetailPage, PokemonDetailCubit>, SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  PokemonDetailCubit setCubit() => locator<PokemonDetailCubit>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return BlocBuilder<PokemonDetailBloc, PokemonDetailState>(
      builder: (context, state) {
        final isLoading = state is PokemonDetailLoading || state is PokemonDetailInitial;
        final isFailed = state is PokemonDetailFailed;
        PokemonDetailEntity? data;
        
        if (state is PokemonDetailSuccess) {
          data = state.data;
        }

        final mainType = data?.types?.firstOrNull?.type?.name ?? 'normal';
        final mainColor = context.getPokemonColor(mainType);

        return Scaffold(
          backgroundColor: mainColor,
          appBar: AppBar(
            backgroundColor: context.color.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: context.color.pureWhite),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.favorite_border, color: context.color.pureWhite),
                onPressed: () {},
              ),
            ],
            title: isLoading 
                ? Skeletonizer(child: Text('Loading...', style: TextStyle(color: context.color.pureWhite)))
                : Text(
                    data?.name?.toCapitalized() ?? '',
                    style: TextStyle(color: context.color.pureWhite, fontWeight: FontWeight.bold),
                  ),
          ),
          body: isFailed
              ? Center(child: AtomText.bodyMedium('Failed to load data', color: context.color.pureWhite))
              : Stack(
                  children: [
                    // Background & Bottom Sheet
                    Column(
                      children: [
                        const Expanded(flex: 3, child: SizedBox()),
                        Expanded(
                          flex: 7,
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.color.background,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child: _buildDetails(data, isLoading, mainColor),
                          ),
                        ),
                      ],
                    ),
                    // Pokemon Image
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Skeletonizer(
                        enabled: isLoading,
                        child: Align(
                          alignment: Alignment.center,
                          child: data?.sprites?.other?.officialArtwork?.frontDefault != null
                              ? AtomCachedNetworkImage(
                                  imageUrl: data!.sprites!.other!.officialArtwork!.frontDefault!,
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.contain,
                                )
                              : Container(
                                  height: 250,
                                  width: 250,
                                  color: context.color.transparent,
                                ),
                        ),
                      ),
                    ),
                    // Pokemon ID Number
                    Positioned(
                      top: 150,
                      right: 30,
                      child: Skeletonizer(
                        enabled: isLoading,
                        child: AtomText.heading2(
                          '#${data?.id?.toString().padLeft(3, '0') ?? '000'}',
                          color: context.color.pureWhite,
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildDetails(PokemonDetailEntity? data, bool isLoading, Color mainColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
      child: Column(
        children: [
          // Types Badges
          Skeletonizer(
            enabled: isLoading,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: data?.types?.map((t) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: AtomBadge.primary(
                        text: (t.type?.name ?? '').toUpperCase(),
                      ),
                    );
                  }).toList() ??
                  [const AtomBadge.primary(text: 'LOADING')],
            ),
          ),
          const SizedBox(height: 20),
          // TabBar
          TabBar(
            controller: _tabController,
            labelColor: context.color.black,
            unselectedLabelColor: context.color.grey,
            indicatorColor: mainColor,
            indicatorWeight: 3,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'About'),
              Tab(text: 'Base Stats'),
              Tab(text: 'Evolution'),
            ],
          ),
          const SizedBox(height: 20),
          // TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAboutTab(data, isLoading),
                _buildStatsTab(data, isLoading),
                Center(child: AtomText.bodyMedium('Evolution Graph Here', color: context.color.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab(PokemonDetailEntity? data, bool isLoading) {
    return Skeletonizer(
      enabled: isLoading,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAboutItem(Icons.fitness_center, '${(data?.weight ?? 0) / 10} KG', 'Weight'),
                _buildAboutItem(Icons.height, '${(data?.height ?? 0) / 10} M', 'Height'),
              ],
            ),
            const SizedBox(height: 30),
            AtomText.bodyMedium(
              "Placeholder description text because the current API endpoint doesn't return flavor text entries. This text shows how a long paragraph would look in the About section of the Pokedex.",
              color: context.color.black,
              style: const TextStyle(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: context.color.grey),
            const SizedBox(width: 8),
            AtomText.bodyMediumBold(value, color: context.color.black),
          ],
        ),
        const SizedBox(height: 4),
        AtomText.bodySmall(label, color: context.color.grey),
      ],
    );
  }

  Widget _buildStatsTab(PokemonDetailEntity? data, bool isLoading) {
    if (data?.stats == null && !isLoading) return const SizedBox();
    final stats = data?.stats ?? List.generate(6, (index) => const StatsPokemonDetail(baseStat: 50));

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        itemCount: stats.length,
        itemBuilder: (context, index) {
          final stat = stats[index];
          final statName = stat.stat?.name?.toUpperCase() ?? 'STAT';
          final minStat = (stat.baseStat ?? 0) * 2 - 10;
          final maxStat = (stat.baseStat ?? 0) * 2 + 50;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 70,
                  child: AtomText.bodySmallBold(
                    statName,
                    color: context.color.grey,
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: AtomText.bodySmallBold(
                    '${stat.baseStat}',
                    color: context.color.black,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (stat.baseStat ?? 0) / 150.0,
                        backgroundColor: context.color.bgGrey,
                        color: (stat.baseStat ?? 0) > 60 ? context.color.success : context.color.error,
                        minHeight: 4,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: AtomText.bodySmall(
                    '${minStat > 0 ? minStat : 0}',
                    color: context.color.grey,
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: AtomText.bodySmall(
                    '$maxStat',
                    color: context.color.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
