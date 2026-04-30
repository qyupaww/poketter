import 'package:poketter/core/global_variable.dart';

import 'data/datasources/pokemon_detail_remote_data_source.dart';
import 'data/repositories/pokemon_detail_repository_impl.dart';

import 'domain/repositories/pokemon_detail_repository.dart';
import 'domain/usecases/pokemon_detail_use_case.dart';
import 'presentation/bloc/pokemon_detail/pokemon_detail_bloc.dart';
import 'presentation/cubit/pokemon_detail_cubit.dart';

void setupLocatorPokemonDetail() {
  // *Cubit
  locator
    ..registerFactory(() => PokemonDetailCubit(pokemonDetailBloc: locator()))
    // *Bloc
    ..registerFactory(() => PokemonDetailBloc(useCase: locator()))
    // *Usecase
    ..registerLazySingleton(() => PokemonDetailUseCase(repository: locator()))
    // *Repository
    ..registerLazySingleton<PokemonDetailRepository>(
      () => PokemonDetailRepositoryImpl(remoteDataSource: locator()),
    )
    // ..registerLazySingleton<PokemonDetailRepository>(
    //   () => PokemonDetailMockRepositoryImpl(),
    // )
    // *Datasource
    ..registerLazySingleton<PokemonDetailRemoteDataSource>(
      () => PokemonDetailRemoteDataSourceImpl(http: locator()),
    );
}
