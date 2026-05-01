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
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_detail_entity.dart';
import 'package:poketter/features/pokemon/pokemon_detail/presentation/bloc/pokemon_detail/pokemon_detail_bloc.dart';
import 'package:poketter/features/pokemon/pokemon_list/presentation/widgets/atom_type_badge.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../cubit/pokemon_detail_cubit.dart';
import '../widgets/pokemon_detail_about_tab.dart';
import '../widgets/pokemon_detail_stats_tab.dart';
import '../widgets/pokemon_detail_evolution_tab.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({super.key, required this.id});

  final String id;

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage>
    with
        SingleTickerProviderStateMixin,
        MorphemeStatePage<PokemonDetailPage, PokemonDetailCubit> {
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
        final isLoading =
            state is PokemonDetailLoading || state is PokemonDetailInitial;
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
                icon: Icon(
                  Icons.favorite_border,
                  color: context.color.pureWhite,
                ),
                onPressed: () {},
              ),
            ],
            title: isLoading
                ? Skeletonizer(
                    child: AtomText.heading2(
                      'Loading...',
                      color: context.color.pureWhite,
                    ),
                  )
                : AtomText.heading2(
                    data?.name?.toCapitalized() ?? '',
                    color: context.color.pureWhite,
                  ),
          ),
          body: isFailed
              ? Center(
                  child: AtomText.bodyMedium(
                    'Failed to load data',
                    color: context.color.pureWhite,
                  ),
                )
              : Stack(
                  children: [
                    // Pokeball Watermark
                    Positioned(
                      top: ConstantSizes.s40,
                      right: -ConstantSizes.s48,
                      child: Skeleton.ignore(
                        child: SvgPicture.asset(
                          MorphemeImages.pokeball,
                          width: ConstantSizes.s80 * 3,
                          height: ConstantSizes.s80 * 3,
                        ),
                      ),
                    ),
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
                                topLeft: Radius.circular(ConstantRadius.r32),
                                topRight: Radius.circular(ConstantRadius.r32),
                              ),
                            ),
                            child: _buildDetails(data, isLoading, mainColor),
                          ),
                        ),
                      ],
                    ),
                    // Pokemon Image
                    Positioned(
                      top: ConstantSizes.s20,
                      left: 0,
                      right: 0,
                      child: Skeletonizer(
                        enabled: isLoading,
                        child: Align(
                          alignment: Alignment.center,
                          child:
                              data
                                      ?.sprites
                                      ?.other
                                      ?.officialArtwork
                                      ?.frontDefault !=
                                  null
                              ? Hero(
                                  tag: 'pokemon_image_${data!.name}',
                                  child: AtomCachedNetworkImage(
                                    imageUrl: data
                                        .sprites!
                                        .other!
                                        .officialArtwork!
                                        .frontDefault!,
                                    height: ConstantSizes.s80 * 3,
                                    width: ConstantSizes.s80 * 3,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : SizedBox(
                                  height: ConstantSizes.s80 * 3,
                                  width: ConstantSizes.s80 * 3,
                                ),
                        ),
                      ),
                    ),
                    // Pokemon ID Number
                    Positioned(
                      top: ConstantSizes.s80 * 2 - ConstantSizes.s8,
                      right: ConstantSizes.s32,
                      child: Skeletonizer(
                        enabled: isLoading,
                        child: AtomText.heading2(
                          '#${data?.id?.toString().padLeft(3, '0') ?? '000'}',
                          color: context.color.pureWhite.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildDetails(
    PokemonDetailEntity? data,
    bool isLoading,
    Color mainColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: ConstantSizes.s2),
      child: Column(
        children: [
          // Types Badges
          Skeletonizer(
            enabled: isLoading,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  data?.types?.map((t) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: ConstantSizes.s4,
                      ),
                      child: AtomTypeBadge(type: t.type?.name ?? ''),
                    );
                  }).toList() ??
                  [const AtomTypeBadge(type: 'loading')],
            ),
          ),
          const AtomSpacing.vertical12(),
          // TabBar
          TabBar(
            controller: _tabController,
            labelColor: context.color.black,
            unselectedLabelColor: context.color.grey,
            indicatorColor: mainColor,
            indicatorWeight: 3,
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.transparent,
            labelStyle: Theme.of(
              context,
            ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
            unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
            tabs: const [
              Tab(text: 'About'),
              Tab(text: 'Base Stats'),
              Tab(text: 'Evolution'),
            ],
          ),
          const AtomSpacing.vertical20(),
          // TabBarView
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: ConstantSizes.s24,
              ),
              child: TabBarView(
                controller: _tabController,
                children: [
                  PokemonDetailAboutTab(data: data, isLoading: isLoading),
                  PokemonDetailStatsTab(
                    data: data,
                    isLoading: isLoading,
                    mainColor: mainColor,
                  ),
                  PokemonDetailEvolutionTab(data: data, isLoading: isLoading),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
