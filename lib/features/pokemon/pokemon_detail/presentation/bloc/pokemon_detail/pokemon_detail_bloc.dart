import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:morpheme_http/morpheme_http.dart';
import 'package:flutter/material.dart';

import '../../../data/models/body/pokemon_detail_body.dart';
import '../../../domain/entities/pokemon_detail_entity.dart';
import '../../../domain/usecases/pokemon_detail_use_case.dart';

part 'pokemon_detail_event.dart';
part 'pokemon_detail_state.dart';

class PokemonDetailBloc
    extends MorphemeBloc<PokemonDetailEvent, PokemonDetailState> {
  PokemonDetailBloc({required this.useCase}) : super(PokemonDetailInitial()) {
    on<FetchPokemonDetail>((event, emit) async {
      emit(PokemonDetailLoading(event.body, event.headers, event.extra));
      _cancelableOperation = CancelableOperation.fromFuture(
        useCase(
          event.body,
          headers: event.headers,
          cacheStrategy: event.cacheStrategy,
        ),
      );
      final result = await _cancelableOperation?.valueOrCancellation();

      if (result == null) {
        emit(PokemonDetailCanceled(event.extra));
        return;
      }
      emit(
        result.fold(
          (failure) => PokemonDetailFailed(
            event.body,
            event.headers,
            failure,
            event.extra,
          ),
          (success) => PokemonDetailSuccess(
            event.body,
            event.headers,
            success,
            event.extra,
          ),
        ),
      );
    });
    on<CancelPokemonDetail>((event, emit) async {
      _cancelableOperation?.cancel();
      _cancelableOperation = null;
      emit(PokemonDetailCanceled(event.extra));
    });
  }

  final PokemonDetailUseCase useCase;

  CancelableOperation<Either<MorphemeFailure, PokemonDetailEntity>>?
  _cancelableOperation;

  @override
  Future<void> close() {
    _cancelableOperation?.cancel();
    _cancelableOperation = null;
    return super.close();
  }
}
