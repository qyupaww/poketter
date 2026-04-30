import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:morpheme_http/morpheme_http.dart';
import 'package:flutter/material.dart';

import '../../../data/models/body/pokemon_list_body.dart';
import '../../../domain/entities/pokemon_list_entity.dart';
import '../../../domain/usecases/pokemon_list_use_case.dart';

part 'pokemon_list_event.dart';
part 'pokemon_list_state.dart';

class PokemonListBloc extends MorphemeBloc<PokemonListEvent, PokemonListState> {
  PokemonListBloc({required this.useCase}) : super(PokemonListInitial()) {
    on<FetchPokemonList>((event, emit) async {
      emit(PokemonListLoading(event.body, event.headers, event.extra));
      _cancelableOperation = CancelableOperation.fromFuture(
        useCase(
          event.body,
          headers: event.headers,
          cacheStrategy: event.cacheStrategy,
        ),
      );
      final result = await _cancelableOperation?.valueOrCancellation();

      if (result == null) {
        emit(PokemonListCanceled(event.extra));
        return;
      }
      emit(
        result.fold(
          (failure) => PokemonListFailed(
            event.body,
            event.headers,
            failure,
            event.extra,
          ),
          (success) => PokemonListSuccess(
            event.body,
            event.headers,
            success,
            event.extra,
          ),
        ),
      );
    });
    on<CancelPokemonList>((event, emit) async {
      _cancelableOperation?.cancel();
      _cancelableOperation = null;
      emit(PokemonListCanceled(event.extra));
    });
  }

  final PokemonListUseCase useCase;

  CancelableOperation<Either<MorphemeFailure, PokemonListEntity>>?
  _cancelableOperation;

  @override
  Future<void> close() {
    _cancelableOperation?.cancel();
    _cancelableOperation = null;
    return super.close();
  }
}
