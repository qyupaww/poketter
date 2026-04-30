abstract class MorphemeEndpoints {
  static Uri _createUriBaseUrl(String path) =>
      Uri.parse('${const String.fromEnvironment('BASE_URL')}$path');

  static Uri pokemonList = _createUriBaseUrl('/api/v2/pokemon');
  static Uri pokemonDetail(String id) =>
      _createUriBaseUrl('/api/v2/pokemon/:id'.replaceAll(':id', id));
}
