import 'package:morpheme_http/morpheme_http.dart';

import '../../data/models/body/pokemon_species_body.dart';
import '../entities/pokemon_species_entity.dart';
import '../repositories/pokemon_detail_repository.dart';

class PokemonSpeciesUseCase
    implements UseCase<PokemonSpeciesEntity, PokemonSpeciesBody> {
  PokemonSpeciesUseCase({required this.repository});

  final PokemonDetailRepository repository;

  @override
  Future<Either<MorphemeFailure, PokemonSpeciesEntity>> call(
    PokemonSpeciesBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) {
    return repository.pokemonSpecies(
      body,
      headers: headers,
      cacheStrategy: cacheStrategy,
    );
  }
}
