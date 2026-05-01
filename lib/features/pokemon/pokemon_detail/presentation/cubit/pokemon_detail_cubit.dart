import 'package:poketter/features/pokemon/pokemon_detail/presentation/bloc/evolution_chain/evolution_chain_bloc.dart';
import 'package:poketter/features/pokemon/pokemon_detail/presentation/bloc/pokemon_species/pokemon_species_bloc.dart';
import 'package:poketter/features/pokemon/pokemon_detail/presentation/bloc/pokemon_detail/pokemon_detail_bloc.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_detail_body.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/evolution_chain_body.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_species_body.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../pages/pokemon_detail_page.dart';

part 'pokemon_detail_state.dart';

class PokemonDetailCubit extends MorphemeCubit<PokemonDetailStateCubit> {
  PokemonDetailCubit({
    required this.pokemonDetailBloc,
    required this.pokemonSpeciesBloc,
    required this.evolutionChainBloc,
  }) : super(PokemonDetailStateCubit());

  final PokemonSpeciesBloc pokemonSpeciesBloc;
  final EvolutionChainBloc evolutionChainBloc;

  final PokemonDetailBloc pokemonDetailBloc;
  late String pokemonId;

  @override
  void initArgument<T>(BuildContext context, T widget) {
    super.initArgument(context, widget);
    if (widget is! PokemonDetailPage) return;
    pokemonId = widget.id;
    // Fetch detail and species immediately
    pokemonDetailBloc.add(FetchPokemonDetail(PokemonDetailBody(id: pokemonId)));
    pokemonSpeciesBloc.add(
      FetchPokemonSpecies(PokemonSpeciesBody(id: pokemonId)),
    );
  }

  void fetchEvolution() {
    // Only fetch if not already fetched
    if (evolutionChainBloc.state is! EvolutionChainSuccess) {
      String idToFetch = pokemonId;
      final speciesState = pokemonSpeciesBloc.state;
      if (speciesState is PokemonSpeciesSuccess) {
        final url = speciesState.data.evolutionChain?.url;
        final paths = url?.split('/').where((e) => e.isNotEmpty).toList();
        if (paths != null && paths.isNotEmpty) {
          idToFetch = paths.last;
        }
      }
      evolutionChainBloc.add(
        FetchEvolutionChain(EvolutionChainBody(id: idToFetch)),
      );
    }
  }

  @override
  List<BlocProvider> blocProviders(BuildContext context) => [
    BlocProvider<PokemonDetailBloc>.value(value: pokemonDetailBloc),
    BlocProvider<EvolutionChainBloc>.value(value: evolutionChainBloc),
    BlocProvider<PokemonSpeciesBloc>.value(value: pokemonSpeciesBloc),
  ];
  @override
  List<BlocListener> blocListeners(BuildContext context) => [
    BlocListener<PokemonDetailBloc, PokemonDetailState>(
      listener: listenerPokemonDetailBloc,
    ),
    BlocListener<EvolutionChainBloc, EvolutionChainState>(
      listener: listenerEvolutionChainBloc,
    ),
    BlocListener<PokemonSpeciesBloc, PokemonSpeciesState>(
      listener: listenerPokemonSpeciesBloc,
    ),
  ];
  @override
  void dispose() {
    pokemonSpeciesBloc.close();
    evolutionChainBloc.close();
    pokemonDetailBloc.close();
    super.dispose();
  }

  void listenerPokemonDetailBloc(
    BuildContext context,
    PokemonDetailState state,
  ) {
    // Error/Success states are handled by UI via BlocBuilder
  }
  void listenerEvolutionChainBloc(
    BuildContext context,
    EvolutionChainState state,
  ) {
    state.when(
      onFailed: (state) {
        // handle failed state
      },
      onSuccess: (state) {
        // handle success state
      },
    );
  }

  void listenerPokemonSpeciesBloc(
    BuildContext context,
    PokemonSpeciesState state,
  ) {
    state.when(
      onFailed: (state) {
        // handle failed state
      },
      onSuccess: (state) {
        // handle success state
      },
    );
  }
}
