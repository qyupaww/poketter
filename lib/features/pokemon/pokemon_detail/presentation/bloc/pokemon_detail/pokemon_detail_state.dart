part of 'pokemon_detail_bloc.dart';

@immutable
abstract class PokemonDetailState extends Equatable {
  bool get isInitial => this is PokemonDetailInitial;
  bool get isLoading => this is PokemonDetailLoading;
  bool get isFailed => this is PokemonDetailFailed;
  bool get isSuccess => this is PokemonDetailSuccess;
  bool get isCanceled => this is PokemonDetailCanceled;

  bool get isNotInitial => this is! PokemonDetailInitial;
  bool get isNotLoading => this is! PokemonDetailLoading;
  bool get isNotFailed => this is! PokemonDetailFailed;
  bool get isNotSuccess => this is! PokemonDetailSuccess;
  bool get isNotCanceled => this is! PokemonDetailCanceled;

  void when({
    void Function(PokemonDetailInitial state)? onInitial,
    void Function(PokemonDetailLoading state)? onLoading,
    void Function(PokemonDetailFailed state)? onFailed,
    void Function(PokemonDetailSuccess state)? onSuccess,
    void Function(PokemonDetailCanceled state)? onCanceled,
  }) {
    final state = this;
    if (state is PokemonDetailInitial) {
      onInitial?.call(state);
    } else if (state is PokemonDetailLoading) {
      onLoading?.call(state);
    } else if (state is PokemonDetailFailed) {
      onFailed?.call(state);
    } else if (state is PokemonDetailSuccess) {
      onSuccess?.call(state);
    } else if (state is PokemonDetailCanceled) {
      onCanceled?.call(state);
    }
  }

  Widget builder({
    Widget Function(PokemonDetailInitial state)? onInitial,
    Widget Function(PokemonDetailLoading state)? onLoading,
    Widget Function(PokemonDetailFailed state)? onFailed,
    Widget Function(PokemonDetailSuccess state)? onSuccess,
    Widget Function(PokemonDetailCanceled state)? onCanceled,

    Widget Function(PokemonDetailState state)? onStateBuilder,
  }) {
    final state = this;
    final defaultWidget = onStateBuilder?.call(this) ?? const SizedBox.shrink();

    if (state is PokemonDetailInitial) {
      return onInitial?.call(state) ?? defaultWidget;
    } else if (state is PokemonDetailLoading) {
      return onLoading?.call(state) ?? defaultWidget;
    } else if (state is PokemonDetailFailed) {
      return onFailed?.call(state) ?? defaultWidget;
    } else if (state is PokemonDetailSuccess) {
      return onSuccess?.call(state) ?? defaultWidget;
    } else if (state is PokemonDetailCanceled) {
      return onCanceled?.call(state) ?? defaultWidget;
    } else {
      return defaultWidget;
    }
  }
}

class PokemonDetailInitial extends PokemonDetailState {
  @override
  List<Object?> get props => [];
}

class PokemonDetailLoading extends PokemonDetailState {
  PokemonDetailLoading(this.body, this.headers, this.extra);

  final PokemonDetailBody body;
  final Map<String, String>? headers;
  final dynamic extra;

  @override
  List<Object?> get props => [body, headers, extra];
}

class PokemonDetailFailed extends PokemonDetailState {
  PokemonDetailFailed(this.body, this.headers, this.failure, this.extra);

  final PokemonDetailBody body;
  final Map<String, String>? headers;
  final MorphemeFailure failure;
  final dynamic extra;

  @override
  List<Object?> get props => [body, headers, failure, extra];
}

class PokemonDetailCanceled extends PokemonDetailState {
  PokemonDetailCanceled(this.extra);

  final dynamic extra;

  @override
  List<Object?> get props => [extra];
}

class PokemonDetailSuccess extends PokemonDetailState {
  PokemonDetailSuccess(this.body, this.headers, this.data, this.extra);

  final PokemonDetailBody body;
  final Map<String, String>? headers;
  final PokemonDetailEntity data;
  final dynamic extra;

  @override
  List<Object?> get props => [body, headers, data, extra];
}
