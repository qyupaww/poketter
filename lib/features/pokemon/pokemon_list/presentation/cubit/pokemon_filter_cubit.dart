import 'package:equatable/equatable.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:poketter/core/endpoints/morpheme_endpoints.dart';
import 'package:poketter/features/pokemon/pokemon_list/domain/entities/pokemon_list_entity.dart';

import '../../domain/usecases/pokemon_filter_use_case.dart';

part 'pokemon_filter_state.dart';

class PokemonFilterCubit extends MorphemeCubit<PokemonFilterState> {
  PokemonFilterCubit({required this.useCase}) : super(PokemonFilterState());

  final PokemonFilterUseCase useCase;

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  Future<void> loadFilters() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final genRes = await useCase.generationList();
    final typeRes = await useCase.typeList();

    List<dynamic>? gens;
    List<dynamic>? types;

    String? error;

    genRes.fold(
      (f) => error = f.toString(),
      (r) => gens = r['results'] as List<dynamic>?,
    );
    typeRes.fold(
      (f) => error = (error == null ? f.toString() : '$error; ${f.toString()}'),
      (r) => types = r['results'] as List<dynamic>?,
    );

    emit(
      state.copyWith(
        isLoading: false,
        generations: gens,
        types: types,
        errorMessage: error,
      ),
    );
  }

  Future<List<ResultsPokemonList>> filterByGeneration(
    String generationUrlOrId,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final generationId = _lastPathSegment(generationUrlOrId);
    if (generationId == null) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Invalid generation filter.',
        ),
      );
      return [];
    }

    final res = await useCase.generation(generationId);
    return res.fold(
      (failure) {
        emit(
          state.copyWith(isLoading: false, errorMessage: failure.toString()),
        );
        return [];
      },
      (data) {
        final species = data['pokemon_species'] as List<dynamic>?;
        final results =
            species
                ?.map(_pokemonFromSpeciesReference)
                .whereType<ResultsPokemonList>()
                .toList() ??
            <ResultsPokemonList>[];
        emit(state.copyWith(isLoading: false));
        return results;
      },
    );
  }

  Future<List<ResultsPokemonList>> filterByType(String typeUrlOrName) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final typeIdOrName = _lastPathSegment(typeUrlOrName);
    if (typeIdOrName == null) {
      emit(
        state.copyWith(isLoading: false, errorMessage: 'Invalid type filter.'),
      );
      return [];
    }

    final res = await useCase.type(typeIdOrName);
    return res.fold(
      (failure) {
        emit(
          state.copyWith(isLoading: false, errorMessage: failure.toString()),
        );
        return [];
      },
      (data) {
        final pokemons = data['pokemon'] as List<dynamic>?;
        final results =
            pokemons
                ?.map(_pokemonFromTypeReference)
                .whereType<ResultsPokemonList>()
                .toList() ??
            <ResultsPokemonList>[];
        emit(state.copyWith(isLoading: false));
        return results;
      },
    );
  }

  /// Return intersection of generation species and type pokemons as ResultsPokemonList.
  Future<List<ResultsPokemonList>> filterByGenerationAndType(
    String generationUrlOrId,
    String typeUrlOrName,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final generationId = _lastPathSegment(generationUrlOrId);
    final typeIdOrName = _lastPathSegment(typeUrlOrName);
    if (generationId == null || typeIdOrName == null) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Invalid generation or type filter.',
        ),
      );
      return [];
    }

    final genRes = await useCase.generation(generationId);
    final typeRes = await useCase.type(typeIdOrName);

    List<dynamic>? genSpecies;
    List<dynamic>? typePokemons;
    String? error;
    genRes.fold(
      (f) => error = f.toString(),
      (r) => genSpecies = r['pokemon_species'] as List<dynamic>?,
    );
    typeRes.fold(
      (f) => error = (error == null ? f.toString() : '$error; ${f.toString()}'),
      (r) => typePokemons = r['pokemon'] as List<dynamic>?,
    );

    if (error != null) {
      emit(state.copyWith(isLoading: false, errorMessage: error));
      return [];
    }

    if (genSpecies == null || typePokemons == null) {
      emit(state.copyWith(isLoading: false));
      return [];
    }

    final genSpeciesList = genSpecies!;
    final typePokemonsList = typePokemons!;

    final typeNameToPokemonId = <String, String>{};
    for (final p in typePokemonsList) {
      final poke = p['pokemon'] as Map<String, dynamic>?;
      final name = (poke?['name'] as String?)?.toLowerCase();
      final id = _lastPathSegment(poke?['url'] as String?);
      if (name != null && id != null) {
        typeNameToPokemonId[name] = id;
      }
    }

    final results = <ResultsPokemonList>[];
    for (final species in genSpeciesList) {
      final name = (species['name'] as String?)?.toLowerCase();
      if (name == null || !typeNameToPokemonId.containsKey(name)) continue;
      final displayName = species['name'] as String? ?? name;
      final id =
          typeNameToPokemonId[name] ??
          _lastPathSegment(species['url'] as String?);
      if (id == null) continue;
      results.add(_pokemonFromId(name: displayName, id: id));
    }

    emit(state.copyWith(isLoading: false));
    return results;
  }

  static ResultsPokemonList? _pokemonFromSpeciesReference(dynamic species) {
    if (species is! Map<String, dynamic>) return null;

    final name = species['name'] as String?;
    final id = _lastPathSegment(species['url'] as String?);
    if (name == null || id == null) return null;

    return _pokemonFromId(name: name, id: id);
  }

  static ResultsPokemonList? _pokemonFromTypeReference(dynamic item) {
    if (item is! Map<String, dynamic>) return null;

    final pokemon = item['pokemon'] as Map<String, dynamic>?;
    final name = pokemon?['name'] as String?;
    final id = _lastPathSegment(pokemon?['url'] as String?);
    if (name == null || id == null) return null;

    return _pokemonFromId(name: name, id: id);
  }

  static ResultsPokemonList _pokemonFromId({
    required String name,
    required String id,
  }) {
    return ResultsPokemonList(
      name: name,
      url: MorphemeEndpoints.pokemonDetail(id).toString(),
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
    );
  }

  static String? _lastPathSegment(String? value) {
    if (value == null || value.isEmpty) return null;

    final uri = Uri.tryParse(value);
    final uriSegments = uri?.pathSegments.where((e) => e.isNotEmpty).toList();
    if (uriSegments != null && uriSegments.isNotEmpty) {
      return uriSegments.last;
    }

    final segments = value.split('/').where((e) => e.isNotEmpty).toList();
    return segments.isNotEmpty ? segments.last : value;
  }
}
