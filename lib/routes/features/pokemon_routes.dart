import 'package:go_router/go_router.dart';
import 'package:poketter/core/constants/constant_routes.dart';
import 'package:poketter/features/pokemon/pokemon_list/presentation/pages/pokemon_list_page.dart';
import 'package:poketter/features/pokemon/pokemon_detail/presentation/pages/pokemon_detail_page.dart';

final pokemonRoutes = [
  GoRoute(
    name: ConstantRoutes.pokemonList,
    path: ConstantRoutes.pokemonList,
    builder: (context, state) => const PokemonListPage(),
    routes: [
      GoRoute(
        name: ConstantRoutes.pokemonDetail,
        path: ConstantRoutes.pokemonDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '1';
          return PokemonDetailPage(id: id);
        },
      ),
    ],
  ),
];
