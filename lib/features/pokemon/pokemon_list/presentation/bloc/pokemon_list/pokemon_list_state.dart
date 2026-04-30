part of 'pokemon_list_bloc.dart';

@immutable
abstract class PokemonListState extends Equatable {
  bool get isInitial => this is PokemonListInitial;
  bool get isLoading => this is PokemonListLoading;
  bool get isFailed => this is PokemonListFailed;
  bool get isSuccess => this is PokemonListSuccess;
  bool get isCanceled => this is PokemonListCanceled;

  bool get isNotInitial => this is! PokemonListInitial;
  bool get isNotLoading => this is! PokemonListLoading;
  bool get isNotFailed => this is! PokemonListFailed;
  bool get isNotSuccess => this is! PokemonListSuccess;
  bool get isNotCanceled => this is! PokemonListCanceled;

  void when({
    void Function(PokemonListInitial state)? onInitial,
    void Function(PokemonListLoading state)? onLoading,
    void Function(PokemonListFailed state)? onFailed,
    void Function(PokemonListSuccess state)? onSuccess,
    void Function(PokemonListCanceled state)? onCanceled,
  }) {
    final state = this;
    if (state is PokemonListInitial) {
      onInitial?.call(state);
    } else if (state is PokemonListLoading) {
      onLoading?.call(state);
    } else if (state is PokemonListFailed) {
      onFailed?.call(state);
    } else if (state is PokemonListSuccess) {
      onSuccess?.call(state);
    } else if (state is PokemonListCanceled) {
      onCanceled?.call(state);
    }
  }

  Widget builder({
    Widget Function(PokemonListInitial state)? onInitial,
    Widget Function(PokemonListLoading state)? onLoading,
    Widget Function(PokemonListFailed state)? onFailed,
    Widget Function(PokemonListSuccess state)? onSuccess,
    Widget Function(PokemonListCanceled state)? onCanceled,

    Widget Function(PokemonListState state)? onStateBuilder,
  }) {
    final state = this;
    final defaultWidget = onStateBuilder?.call(this) ?? const SizedBox.shrink();

    if (state is PokemonListInitial) {
      return onInitial?.call(state) ?? defaultWidget;
    } else if (state is PokemonListLoading) {
      return onLoading?.call(state) ?? defaultWidget;
    } else if (state is PokemonListFailed) {
      return onFailed?.call(state) ?? defaultWidget;
    } else if (state is PokemonListSuccess) {
      return onSuccess?.call(state) ?? defaultWidget;
    } else if (state is PokemonListCanceled) {
      return onCanceled?.call(state) ?? defaultWidget;
    } else {
      return defaultWidget;
    }
  }
}

class PokemonListInitial extends PokemonListState {
  @override
  List<Object?> get props => [];
}

class PokemonListLoading extends PokemonListState {
  PokemonListLoading(this.body, this.headers, this.extra);

  final PokemonListBody body;
  final Map<String, String>? headers;
  final dynamic extra;

  @override
  List<Object?> get props => [body, headers, extra];
}

class PokemonListFailed extends PokemonListState {
  PokemonListFailed(this.body, this.headers, this.failure, this.extra);

  final PokemonListBody body;
  final Map<String, String>? headers;
  final MorphemeFailure failure;
  final dynamic extra;

  @override
  List<Object?> get props => [body, headers, failure, extra];
}

class PokemonListCanceled extends PokemonListState {
  PokemonListCanceled(this.extra);

  final dynamic extra;

  @override
  List<Object?> get props => [extra];
}

class PokemonListSuccess extends PokemonListState {
  PokemonListSuccess(this.body, this.headers, this.data, this.extra);

  final PokemonListBody body;
  final Map<String, String>? headers;
  final PokemonListEntity data;
  final dynamic extra;

  @override
  List<Object?> get props => [body, headers, data, extra];
}
