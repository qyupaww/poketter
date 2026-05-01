import 'package:poketter/features/pokemon/pokemon_detail/presentation/bloc/pokemon_detail/pokemon_detail_bloc.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_detail_body.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../pages/pokemon_detail_page.dart';

part 'pokemon_detail_state.dart';

class PokemonDetailCubit extends MorphemeCubit<PokemonDetailStateCubit> {
  PokemonDetailCubit({required this.pokemonDetailBloc})
    : super(PokemonDetailStateCubit());

  final PokemonDetailBloc pokemonDetailBloc;
  late String pokemonId;


  @override
  void initArgument<T>(BuildContext context, T widget) {
    super.initArgument(context, widget);
    if (widget is! PokemonDetailPage) return;
    pokemonId = widget.id;
    // Fetch after pokemonId is set
    pokemonDetailBloc.add(FetchPokemonDetail(PokemonDetailBody(id: pokemonId)));
  }

  @override
  List<BlocProvider> blocProviders(BuildContext context) => [
    BlocProvider<PokemonDetailBloc>.value(value: pokemonDetailBloc),
  ];

  @override
  List<BlocListener> blocListeners(BuildContext context) => [
    BlocListener<PokemonDetailBloc, PokemonDetailState>(
      listener: listenerPokemonDetailBloc,
    ),
  ];

  @override
  void dispose() {
    pokemonDetailBloc.close();
    super.dispose();
  }

  void listenerPokemonDetailBloc(
    BuildContext context,
    PokemonDetailState state,
  ) {
    // Error/Success states are handled by UI via BlocBuilder
  }
}
