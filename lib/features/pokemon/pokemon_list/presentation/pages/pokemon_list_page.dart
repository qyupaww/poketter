import 'package:morpheme_base/morpheme_base.dart';
import 'package:poketter/core/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:poketter/core/components/components.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:poketter/features/pokemon/pokemon_list/presentation/bloc/pokemon_list/pokemon_list_bloc.dart';
import 'package:poketter/features/pokemon/pokemon_list/domain/entities/pokemon_list_entity.dart';
import 'package:poketter/core/themes/morpheme_colors/morpheme_colors.dart';
import 'package:poketter/core/extensions/string_extensions.dart';

import '../cubit/pokemon_list_cubit.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage>
    with MorphemeStatePage<PokemonListPage, PokemonListCubit> {
  @override
  PokemonListCubit setCubit() => locator<PokemonListCubit>();

  @override
  Widget buildWidget(BuildContext context) {
    return BlocBuilder<PokemonListBloc, PokemonListState>(
      builder: (context, state) {
        final isLoading = state is PokemonListLoading || state is PokemonListInitial;
        final isFailed = state is PokemonListFailed;
        PokemonListEntity? data;
        
        if (state is PokemonListSuccess) {
          data = state.data;
        }

        // Mock data for skeleton loading
        final items = isLoading 
            ? List.generate(8, (index) => const ResultsPokemonList(name: 'Loading...', url: 'https://pokeapi.co/api/v2/pokemon/1/'))
            : data?.results ?? [];

        return Scaffold(
          backgroundColor: context.color.background,
          appBar: AppBar(
            title: AtomText.heading2('Pokedex', color: context.color.black),
            elevation: 0,
            backgroundColor: context.color.background,
            foregroundColor: context.color.black,
            centerTitle: false,
          ),
          body: isFailed
              ? Center(child: AtomText.bodyMedium('Failed to load Pokemon list.', color: context.color.black))
              : Skeletonizer(
                  enabled: isLoading,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      // Extract ID from URL
                      final id = item.url?.split('/').reversed.elementAt(1) ?? '1';
                      final imageUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';

                      return InkWell(
                        onTap: () {
                          if (!isLoading) {
                            context.read<PokemonListCubit>().goToDetail(context, id);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.color.pureWhite,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: context.color.black.withValues(alpha: .05),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // ID Text
                              Positioned(
                                top: 12,
                                right: 12,
                                child: AtomText.bodySmallBold(
                                  '#${id.padLeft(3, '0')}',
                                  color: context.color.grey,
                                ),
                              ),
                              // Image and Name
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: AtomCachedNetworkImage(
                                        imageUrl: imageUrl,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    AtomText.bodyLargeSemiBold(
                                      item.name?.toCapitalized() ?? '',
                                      color: context.color.black,
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
