part of 'evolution_chain_bloc.dart';

@immutable
abstract class EvolutionChainState extends Equatable {
  bool get isInitial => this is EvolutionChainInitial;
  bool get isLoading => this is EvolutionChainLoading;
  bool get isFailed => this is EvolutionChainFailed;
  bool get isSuccess => this is EvolutionChainSuccess;
  bool get isCanceled => this is EvolutionChainCanceled;

  bool get isNotInitial => this is! EvolutionChainInitial;
  bool get isNotLoading => this is! EvolutionChainLoading;
  bool get isNotFailed => this is! EvolutionChainFailed;
  bool get isNotSuccess => this is! EvolutionChainSuccess;
  bool get isNotCanceled => this is! EvolutionChainCanceled;

  void when({
    void Function(EvolutionChainInitial state)? onInitial,
    void Function(EvolutionChainLoading state)? onLoading,
    void Function(EvolutionChainFailed state)? onFailed,
    void Function(EvolutionChainSuccess state)? onSuccess,
    void Function(EvolutionChainCanceled state)? onCanceled,
  }) {
    final state = this;
    if (state is EvolutionChainInitial) {
      onInitial?.call(state);
    } else if (state is EvolutionChainLoading) {
      onLoading?.call(state);
    } else if (state is EvolutionChainFailed) {
      onFailed?.call(state);
    } else if (state is EvolutionChainSuccess) {
      onSuccess?.call(state);
    } else if (state is EvolutionChainCanceled) {
      onCanceled?.call(state);
    }
  }

  Widget builder({
    Widget Function(EvolutionChainInitial state)? onInitial,
    Widget Function(EvolutionChainLoading state)? onLoading,
    Widget Function(EvolutionChainFailed state)? onFailed,
    Widget Function(EvolutionChainSuccess state)? onSuccess,
    Widget Function(EvolutionChainCanceled state)? onCanceled,

    Widget Function(EvolutionChainState state)? onStateBuilder,
  }) {
    final state = this;
    final defaultWidget = onStateBuilder?.call(this) ?? const SizedBox.shrink();

    if (state is EvolutionChainInitial) {
      return onInitial?.call(state) ?? defaultWidget;
    } else if (state is EvolutionChainLoading) {
      return onLoading?.call(state) ?? defaultWidget;
    } else if (state is EvolutionChainFailed) {
      return onFailed?.call(state) ?? defaultWidget;
    } else if (state is EvolutionChainSuccess) {
      return onSuccess?.call(state) ?? defaultWidget;
    } else if (state is EvolutionChainCanceled) {
      return onCanceled?.call(state) ?? defaultWidget;
    } else {
      return defaultWidget;
    }
  }
}

class EvolutionChainInitial extends EvolutionChainState {
  @override
  List<Object?> get props => [];
}

class EvolutionChainLoading extends EvolutionChainState {
  EvolutionChainLoading(this.body, this.headers, this.extra);

  final EvolutionChainBody body;
  final Map<String, String>? headers;
  final dynamic extra;

  @override
  List<Object?> get props => [body, headers, extra];
}

class EvolutionChainFailed extends EvolutionChainState {
  EvolutionChainFailed(this.body, this.headers, this.failure, this.extra);

  final EvolutionChainBody body;
  final Map<String, String>? headers;
  final MorphemeFailure failure;
  final dynamic extra;

  @override
  List<Object?> get props => [body, headers, failure, extra];
}

class EvolutionChainCanceled extends EvolutionChainState {
  EvolutionChainCanceled(this.extra);

  final dynamic extra;

  @override
  List<Object?> get props => [extra];
}

class EvolutionChainSuccess extends EvolutionChainState {
  EvolutionChainSuccess(this.body, this.headers, this.data, this.extra);

  final EvolutionChainBody body;
  final Map<String, String>? headers;
  final EvolutionChainEntity data;
  final dynamic extra;

  @override
  List<Object?> get props => [body, headers, data, extra];
}
