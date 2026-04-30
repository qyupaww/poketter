import 'package:poketter/features/pokemon/pokemon_list/presentation/bloc/pokemon_list/pokemon_list_bloc.dart';
import 'package:poketter/features/pokemon/pokemon_list/data/models/body/pokemon_list_body.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poketter/core/constants/constant_routes.dart';

import '../pages/pokemon_list_page.dart';

part 'pokemon_list_state.dart';

class PokemonListCubit extends MorphemeCubit<PokemonListStateCubit> {
  PokemonListCubit({required this.pokemonListBloc})
      : super(PokemonListStateCubit());

  final PokemonListBloc pokemonListBloc;

  @override
  void initAfterFirstLayout(BuildContext context) {
    super.initAfterFirstLayout(context);
    pokemonListBloc.add(FetchPokemonList(const PokemonListBody()));
  }

  @override
  void initArgument<T>(BuildContext context, T widget) {
    super.initArgument(context, widget);
    if (widget is! PokemonListPage) return;
  }

  @override
  List<BlocProvider> blocProviders(BuildContext context) => [
        BlocProvider<PokemonListBloc>.value(value: pokemonListBloc),
      ];

  @override
  List<BlocListener> blocListeners(BuildContext context) => [
        BlocListener<PokemonListBloc, PokemonListState>(
          listener: listenerPokemonListBloc,
        ),
      ];

  @override
  void dispose() {
    pokemonListBloc.close();
    super.dispose();
  }

  void listenerPokemonListBloc(BuildContext context, PokemonListState state) {
    state.when(
      onFailed: (state) {
        // handle failed state
      },
      onSuccess: (state) {
        // handle success state
      },
    );
  }

  void goToDetail(BuildContext context, String id) {
    context.pushNamed(
      ConstantRoutes.pokemonDetail,
      pathParameters: {'id': id},
    );
  }
}
