import 'package:morpheme_http/morpheme_http.dart';

abstract class PokemonFilterRepository {
  Future<Either<MorphemeFailure, Map<String, dynamic>>> generationList();
  Future<Either<MorphemeFailure, Map<String, dynamic>>> generation(String id);

  Future<Either<MorphemeFailure, Map<String, dynamic>>> typeList();
  Future<Either<MorphemeFailure, Map<String, dynamic>>> type(String id);

  Future<Either<MorphemeFailure, Map<String, dynamic>>> pokemonAll({
    int limit,
    int offset,
  });
}
