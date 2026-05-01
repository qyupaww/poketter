import 'package:morpheme_base/morpheme_base.dart';
import 'package:poketter/core/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:poketter/core/components/components.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:poketter/features/pokemon/pokemon_list/presentation/bloc/pokemon_list/pokemon_list_bloc.dart';
import 'package:poketter/features/pokemon/pokemon_list/domain/entities/pokemon_list_entity.dart';
import 'package:poketter/core/themes/morpheme_colors/morpheme_colors.dart';

import '../cubit/pokemon_list_cubit.dart';
import '../widgets/pokemon_list_grid.dart';

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
            ? List.generate(8, (index) => ResultsPokemonList.dummy())
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
                  child: PokemonListGrid(items: items, isLoading: isLoading),
                ),
        );
      },
    );
  }
}
