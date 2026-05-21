import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poketter/core/constants/constant_routes.dart';
import 'package:poketter/routes/features/pokemon_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

class Routes {
  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: ConstantRoutes.pokemonList,
    debugLogDiagnostics: kDebugMode,
    routes: [...pokemonRoutes],
  );
}
