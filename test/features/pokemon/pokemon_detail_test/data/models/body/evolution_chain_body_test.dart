// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/body/evolution_chain_body.dart'
    as body_evolution_chain;

Future<void> main() async {
  initializeDateFormatting();

  test('Test body convert to map', () {
    const bodyEvolutionChain = body_evolution_chain.EvolutionChainBody(
      id: 'id',
    );

    final map = bodyEvolutionChain.toMap();

    expect(map, {});
  });
}
