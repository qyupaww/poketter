part of 'evolution_chain_bloc.dart';

@immutable
abstract class EvolutionChainEvent extends Equatable {}

class FetchEvolutionChain extends EvolutionChainEvent {
  FetchEvolutionChain(
    this.body, {
    this.headers,
    this.extra,
    this.cacheStrategy,
  });

  final EvolutionChainBody body;
  final Map<String, String>? headers;
  final dynamic extra;
  final CacheStrategy? cacheStrategy;

  @override
  List<Object?> get props => [body, headers, extra, cacheStrategy];
}

class CancelEvolutionChain extends EvolutionChainEvent {
  CancelEvolutionChain({this.extra});

  final dynamic extra;

  @override
  List<Object?> get props => [extra];
}
