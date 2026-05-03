abstract class MorphemeEndpoints {
  static Uri _createUriBaseUrl(String path) =>
      Uri.parse('${const String.fromEnvironment('BASE_URL')}$path');

  static Uri pokemonList = _createUriBaseUrl('/pokemon');
  static Uri pokemonDetail(String id) =>
      _createUriBaseUrl('/pokemon/:id'.replaceAll(':id', id));
  static Uri pokemonSpecies(String id) =>
      _createUriBaseUrl('/pokemon-species/:id'.replaceAll(':id', id));

  // Evolution chain endpoint
  static Uri evolutionChain(String id) =>
      _createUriBaseUrl('/evolution-chain/:id'.replaceAll(':id', id));

  // Generation endpoints
  static Uri generationList = _createUriBaseUrl('/generation');
  static Uri generation(String id) =>
      _createUriBaseUrl('/generation/:id'.replaceAll(':id', id));

  // Type endpoints
  static Uri typeList = _createUriBaseUrl('/type');
  static Uri type(String id) =>
      _createUriBaseUrl('/type/:id'.replaceAll(':id', id));

  // Helper to fetch all pokemon with pagination parameters
  // Use a high `limit` when you need the whole list (e.g. 2000)
  static Uri pokemonAll({int limit = 2000, int offset = 0}) =>
      _createUriBaseUrl('/pokemon?limit=$limit&offset=$offset');
}
