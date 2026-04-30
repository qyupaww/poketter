import 'package:poketter/core/global_variable.dart';

import 'data/datasources/pokemon_list_remote_data_source.dart';
import 'data/repositories/pokemon_list_repository_impl.dart';

import 'domain/repositories/pokemon_list_repository.dart';
import 'domain/usecases/pokemon_list_use_case.dart';
import 'presentation/bloc/pokemon_list/pokemon_list_bloc.dart';
import 'presentation/cubit/pokemon_list_cubit.dart';

void setupLocatorPokemonList() {
  // *Cubit
  locator
    ..registerFactory(() => PokemonListCubit(pokemonListBloc: locator()))
    // *Bloc
    ..registerFactory(() => PokemonListBloc(useCase: locator()))
    // *Usecase
    ..registerLazySingleton(() => PokemonListUseCase(repository: locator()))
    // *Repository
    ..registerLazySingleton<PokemonListRepository>(
      () => PokemonListRepositoryImpl(
        remoteDataSource: locator(),
        detailRemoteDataSource: locator(),
      ),
    )
    // ..registerLazySingleton<PokemonListRepository>(
    //   () => PokemonListMockRepositoryImpl(),
    // )
    // *Datasource
    ..registerLazySingleton<PokemonListRemoteDataSource>(
      () => PokemonListRemoteDataSourceImpl(http: locator()),
    );
}
