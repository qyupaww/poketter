import 'package:morpheme_http/morpheme_http.dart';

import '../repositories/pokemon_filter_repository.dart';

class PokemonFilterUseCase {
  PokemonFilterUseCase({required this.repository});

  final PokemonFilterRepository repository;

  Future<Either<MorphemeFailure, Map<String, dynamic>>> generationList() {
    return repository.generationList();
  }

  Future<Either<MorphemeFailure, Map<String, dynamic>>> generation(String id) {
    return repository.generation(id);
  }

  Future<Either<MorphemeFailure, Map<String, dynamic>>> typeList() {
    return repository.typeList();
  }

  Future<Either<MorphemeFailure, Map<String, dynamic>>> type(String id) {
    return repository.type(id);
  }

  Future<Either<MorphemeFailure, Map<String, dynamic>>> pokemonAll({
    int limit = 2000,
    int offset = 0,
  }) {
    return repository.pokemonAll(limit: limit, offset: offset);
  }
}
