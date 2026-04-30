import 'package:morpheme_http/morpheme_http.dart';

import '../../domain/entities/pokemon_list_entity.dart';
import '../../mapper.dart';
import '../../domain/repositories/pokemon_list_repository.dart';
import '../datasources/pokemon_list_remote_data_source.dart';
import '../models/body/pokemon_list_body.dart';

import 'package:poketter/features/pokemon/pokemon_detail/data/datasources/pokemon_detail_remote_data_source.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_detail_body.dart';

class PokemonListRepositoryImpl implements PokemonListRepository {
  PokemonListRepositoryImpl({
    required this.remoteDataSource,
    required this.detailRemoteDataSource,
  });

  final PokemonListRemoteDataSource remoteDataSource;
  final PokemonDetailRemoteDataSource detailRemoteDataSource;

  @override
  Future<Either<MorphemeFailure, PokemonListEntity>> pokemonList(
    PokemonListBody body, {
    Map<String, String>? headers,
    CacheStrategy? cacheStrategy,
  }) async {
    try {
      final data = await remoteDataSource.pokemonList(
        body,
        headers: headers,
        cacheStrategy: cacheStrategy,
      );
      final baseEntity = data.toEntity();

      // Enrich each item with types and imageUrl by fetching detail in parallel
      final enrichedResults = await Future.wait(
        (baseEntity.results ?? []).map((item) async {
          final id = item.url?.split('/').reversed.elementAt(1) ?? '1';
          try {
            final detail = await detailRemoteDataSource.pokemonDetail(
              PokemonDetailBody(id: id),
              headers: headers,
              cacheStrategy: cacheStrategy ?? AsyncOrCacheStrategy(),
            );
            final types = detail.types
                    ?.map((t) => t.type?.name ?? '')
                    .where((t) => t.isNotEmpty)
                    .toList() ??
                [];
            final imageUrl = detail.sprites?.other?.officialArtwork
                    ?.frontDefault ??
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
            return item.copyWith(types: types, imageUrl: imageUrl);
          } catch (_) {
            // Fallback: use constructed imageUrl, no types
            return item.copyWith(
              types: const [],
              imageUrl:
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
            );
          }
        }),
      );

      return Right(baseEntity.copyWith(results: enrichedResults));
    } on MorphemeException catch (e) {
      return Left(e.toMorphemeFailure());
    } catch (e) {
      return Left(InternalFailure(e.toString()));
    }
  }
}
