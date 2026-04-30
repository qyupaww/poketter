import 'package:equatable/equatable.dart';

class PokemonListBody extends Equatable {
  const PokemonListBody({this.rawBody});

  final Map<String, dynamic>? rawBody;

  Map<String, dynamic> toMap() {
    return {if (rawBody?.isNotEmpty ?? false) ...rawBody ?? {}};
  }

  @override
  List<Object?> get props => [rawBody];
}
