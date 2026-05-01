part of 'pokemon_species_bloc.dart';

@immutable
abstract class PokemonSpeciesState extends Equatable {
  bool get isInitial => this is PokemonSpeciesInitial;
  bool get isLoading => this is PokemonSpeciesLoading;
  bool get isFailed => this is PokemonSpeciesFailed;
  bool get isSuccess => this is PokemonSpeciesSuccess;
  bool get isCanceled => this is PokemonSpeciesCanceled;

  bool get isNotInitial => this is! PokemonSpeciesInitial;
  bool get isNotLoading => this is! PokemonSpeciesLoading;
  bool get isNotFailed => this is! PokemonSpeciesFailed;
  bool get isNotSuccess => this is! PokemonSpeciesSuccess;
  bool get isNotCanceled => this is! PokemonSpeciesCanceled;

  void when({
    void Function(PokemonSpeciesInitial state)? onInitial,
    void Function(PokemonSpeciesLoading state)? onLoading,
    void Function(PokemonSpeciesFailed state)? onFailed,
    void Function(PokemonSpeciesSuccess state)? onSuccess,
    void Function(PokemonSpeciesCanceled state)? onCanceled,
  }) {
    final state = this;
    if (state is PokemonSpeciesInitial) {
      onInitial?.call(state);
    } else if (state is PokemonSpeciesLoading) {
      onLoading?.call(state);
    } else if (state is PokemonSpeciesFailed) {
      onFailed?.call(state);
    } else if (state is PokemonSpeciesSuccess) {
      onSuccess?.call(state);
    } else if (state is PokemonSpeciesCanceled) {
      onCanceled?.call(state);
    }
  }

  Widget builder({
    Widget Function(PokemonSpeciesInitial state)? onInitial,
    Widget Function(PokemonSpeciesLoading state)? onLoading,
    Widget Function(PokemonSpeciesFailed state)? onFailed,
    Widget Function(PokemonSpeciesSuccess state)? onSuccess,
    Widget Function(PokemonSpeciesCanceled state)? onCanceled,

    Widget Function(PokemonSpeciesState state)? onStateBuilder,
  }) {
    final state = this;
    final defaultWidget = onStateBuilder?.call(this) ?? const SizedBox.shrink();

    if (state is PokemonSpeciesInitial) {
      return onInitial?.call(state) ?? defaultWidget;
    } else if (state is PokemonSpeciesLoading) {
      return onLoading?.call(state) ?? defaultWidget;
    } else if (state is PokemonSpeciesFailed) {
      return onFailed?.call(state) ?? defaultWidget;
    } else if (state is PokemonSpeciesSuccess) {
      return onSuccess?.call(state) ?? defaultWidget;
    } else if (state is PokemonSpeciesCanceled) {
      return onCanceled?.call(state) ?? defaultWidget;
    } else {
      return defaultWidget;
    }
  }
}

class PokemonSpeciesInitial extends PokemonSpeciesState {
  @override
  List<Object?> get props => [];
}

class PokemonSpeciesLoading extends PokemonSpeciesState {
  PokemonSpeciesLoading(this.body, this.headers, this.extra);

  final PokemonSpeciesBody body;
  final Map<String, String>? headers;
  final dynamic extra;

  @override
  List<Object?> get props => [body, headers, extra];
}

class PokemonSpeciesFailed extends PokemonSpeciesState {
  PokemonSpeciesFailed(this.body, this.headers, this.failure, this.extra);

  final PokemonSpeciesBody body;
  final Map<String, String>? headers;
  final MorphemeFailure failure;
  final dynamic extra;

  @override
  List<Object?> get props => [body, headers, failure, extra];
}

class PokemonSpeciesCanceled extends PokemonSpeciesState {
  PokemonSpeciesCanceled(this.extra);

  final dynamic extra;

  @override
  List<Object?> get props => [extra];
}

class PokemonSpeciesSuccess extends PokemonSpeciesState {
  PokemonSpeciesSuccess(this.body, this.headers, this.data, this.extra);

  final PokemonSpeciesBody body;
  final Map<String, String>? headers;
  final PokemonSpeciesEntity data;
  final dynamic extra;

  @override
  List<Object?> get props => [body, headers, data, extra];
}
