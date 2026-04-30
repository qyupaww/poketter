import 'package:poketter/core/global_variable.dart';
import 'package:poketter/core/locator.dart';
import 'package:poketter/routes/routes.dart';
import 'package:poketter/features/pokemon/locator.dart';

void setupLocator() {
  locator.registerLazySingleton(() => Routes.router);
  setupLocatorCore();
  setupLocatorFeaturePokemon();
}
