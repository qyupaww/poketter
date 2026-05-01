import 'package:equatable/equatable.dart';

class PokemonSpeciesBody extends Equatable {
  const PokemonSpeciesBody({this.rawBody, required this.id});

  final Map<String, dynamic>? rawBody;
  final String id;

  Map<String, dynamic> toMap() {
    return {if (rawBody?.isNotEmpty ?? false) ...rawBody ?? {}};
  }

  @override
  List<Object?> get props => [rawBody, id];
}
