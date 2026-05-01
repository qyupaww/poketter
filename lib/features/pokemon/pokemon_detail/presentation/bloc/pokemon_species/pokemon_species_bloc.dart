import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:morpheme_http/morpheme_http.dart';
import 'package:flutter/material.dart';

import '../../../data/models/body/pokemon_species_body.dart';
import '../../../domain/entities/pokemon_species_entity.dart';
import '../../../domain/usecases/pokemon_species_use_case.dart';

part 'pokemon_species_event.dart';
part 'pokemon_species_state.dart';

class PokemonSpeciesBloc
    extends MorphemeBloc<PokemonSpeciesEvent, PokemonSpeciesState> {
  PokemonSpeciesBloc({required this.useCase}) : super(PokemonSpeciesInitial()) {
    on<FetchPokemonSpecies>((event, emit) async {
      emit(PokemonSpeciesLoading(event.body, event.headers, event.extra));
      _cancelableOperation = CancelableOperation.fromFuture(
        useCase(
          event.body,
          headers: event.headers,
          cacheStrategy: event.cacheStrategy,
        ),
      );
      final result = await _cancelableOperation?.valueOrCancellation();

      if (result == null) {
        emit(PokemonSpeciesCanceled(event.extra));
        return;
      }
      emit(
        result.fold(
          (failure) => PokemonSpeciesFailed(
            event.body,
            event.headers,
            failure,
            event.extra,
          ),
          (success) => PokemonSpeciesSuccess(
            event.body,
            event.headers,
            success,
            event.extra,
          ),
        ),
      );
    });
    on<CancelPokemonSpecies>((event, emit) async {
      _cancelableOperation?.cancel();
      _cancelableOperation = null;
      emit(PokemonSpeciesCanceled(event.extra));
    });
  }

  final PokemonSpeciesUseCase useCase;

  CancelableOperation<Either<MorphemeFailure, PokemonSpeciesEntity>>?
  _cancelableOperation;

  @override
  Future<void> close() {
    _cancelableOperation?.cancel();
    _cancelableOperation = null;
    return super.close();
  }
}
