abstract class MorphemeEndpoints {
  static Uri _createUriBaseUrl(String path) =>
      Uri.parse('${const String.fromEnvironment('BASE_URL')}$path');

  static Uri pokemonList = _createUriBaseUrl('/pokemon');
  static Uri pokemonDetail(String id) =>
      _createUriBaseUrl('/pokemon/:id'.replaceAll(':id', id));
  static Uri pokemonSpecies(String id) =>
      _createUriBaseUrl('/pokemon-species/:id'.replaceAll(':id', id));
  static Uri evolutionChain(String id) =>
      _createUriBaseUrl('/evolution-chain/:id'.replaceAll(':id', id));
}
