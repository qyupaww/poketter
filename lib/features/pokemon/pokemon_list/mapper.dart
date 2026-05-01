import 'data/models/response/pokemon_list_response.dart'
    as pokemon_list_response;
import 'domain/entities/pokemon_list_entity.dart' as pokemon_list_entity;

extension PokemonListResponseMapper
    on pokemon_list_response.PokemonListResponse {
  pokemon_list_entity.PokemonListEntity toEntity() =>
      pokemon_list_entity.PokemonListEntity(
        count: count,
        next: next,
        previous: previous,
        results: results?.map((e) => e.toEntity()).toList(),
      );
}

extension PokemonListEntityMapper on pokemon_list_entity.PokemonListEntity {
  pokemon_list_response.PokemonListResponse toResponse() =>
      pokemon_list_response.PokemonListResponse(
        count: count,
        next: next,
        previous: previous,
        results: results?.map((e) => e.toResponse()).toList(),
      );
}

extension ResultsPokemonListResponseMapper
    on pokemon_list_response.ResultsPokemonList {
  pokemon_list_entity.ResultsPokemonList toEntity() {
    final paths = url?.split('/').where((e) => e.isNotEmpty).toList();
    final id = paths?.isNotEmpty == true ? paths!.last : null;
    final imageUrl = id != null
        ? 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png'
        : null;

    return pokemon_list_entity.ResultsPokemonList(
      name: name,
      url: url,
      imageUrl: imageUrl,
    );
  }
}

extension ResultsPokemonListEntityMapper
    on pokemon_list_entity.ResultsPokemonList {
  pokemon_list_response.ResultsPokemonList toResponse() =>
      pokemon_list_response.ResultsPokemonList(name: name, url: url);
}
