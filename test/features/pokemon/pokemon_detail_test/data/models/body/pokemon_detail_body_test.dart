// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/pokemon_detail_body.dart'
    as body_pokemon_detail;

Future<void> main() async {
  initializeDateFormatting();

  test('Test body convert to map', () {
    const bodyPokemonDetail = body_pokemon_detail.PokemonDetailBody(id: 'id');

    final map = bodyPokemonDetail.toMap();

    expect(map, {});
  });
}
