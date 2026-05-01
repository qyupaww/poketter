import 'package:async/async.dart';
import 'package:equatable/equatable.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:morpheme_http/morpheme_http.dart';
import 'package:flutter/material.dart';

import '../../../data/models/body/evolution_chain_body.dart';
import '../../../domain/entities/evolution_chain_entity.dart';
import '../../../domain/usecases/evolution_chain_use_case.dart';

part 'evolution_chain_event.dart';
part 'evolution_chain_state.dart';

class EvolutionChainBloc
    extends MorphemeBloc<EvolutionChainEvent, EvolutionChainState> {
  EvolutionChainBloc({required this.useCase}) : super(EvolutionChainInitial()) {
    on<FetchEvolutionChain>((event, emit) async {
      emit(EvolutionChainLoading(event.body, event.headers, event.extra));
      _cancelableOperation = CancelableOperation.fromFuture(
        useCase(
          event.body,
          headers: event.headers,
          cacheStrategy: event.cacheStrategy,
        ),
      );
      final result = await _cancelableOperation?.valueOrCancellation();

      if (result == null) {
        emit(EvolutionChainCanceled(event.extra));
        return;
      }
      emit(
        result.fold(
          (failure) => EvolutionChainFailed(
            event.body,
            event.headers,
            failure,
            event.extra,
          ),
          (success) => EvolutionChainSuccess(
            event.body,
            event.headers,
            success,
            event.extra,
          ),
        ),
      );
    });
    on<CancelEvolutionChain>((event, emit) async {
      _cancelableOperation?.cancel();
      _cancelableOperation = null;
      emit(EvolutionChainCanceled(event.extra));
    });
  }

  final EvolutionChainUseCase useCase;

  CancelableOperation<Either<MorphemeFailure, EvolutionChainEntity>>?
  _cancelableOperation;

  @override
  Future<void> close() {
    _cancelableOperation?.cancel();
    _cancelableOperation = null;
    return super.close();
  }
}
