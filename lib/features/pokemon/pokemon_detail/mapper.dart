import 'data/models/response/pokemon_detail_response.dart'
    as pokemon_detail_response;
import 'domain/entities/pokemon_detail_entity.dart' as pokemon_detail_entity;
import 'data/models/response/pokemon_species_response.dart'
    as pokemon_species_response;
import 'domain/entities/pokemon_species_entity.dart' as pokemon_species_entity;
import 'data/models/response/evolution_chain_response.dart'
    as evolution_chain_response;
import 'domain/entities/evolution_chain_entity.dart' as evolution_chain_entity;

extension PokemonDetailResponseMapper
    on pokemon_detail_response.PokemonDetailResponse {
  pokemon_detail_entity.PokemonDetailEntity toEntity() =>
      pokemon_detail_entity.PokemonDetailEntity(
        id: id,
        name: name,
        height: height,
        weight: weight,
        sprites: sprites?.toEntity(),
        stats: stats?.map((e) => e.toEntity()).toList(),
        types: types?.map((e) => e.toEntity()).toList(),
      );
}

extension PokemonDetailEntityMapper
    on pokemon_detail_entity.PokemonDetailEntity {
  pokemon_detail_response.PokemonDetailResponse toResponse() =>
      pokemon_detail_response.PokemonDetailResponse(
        id: id,
        name: name,
        height: height,
        weight: weight,
        sprites: sprites?.toResponse(),
        stats: stats?.map((e) => e.toResponse()).toList(),
        types: types?.map((e) => e.toResponse()).toList(),
      );
}

extension SpritesPokemonDetailResponseMapper
    on pokemon_detail_response.SpritesPokemonDetail {
  pokemon_detail_entity.SpritesPokemonDetail toEntity() =>
      pokemon_detail_entity.SpritesPokemonDetail(other: other?.toEntity());
}

extension SpritesPokemonDetailEntityMapper
    on pokemon_detail_entity.SpritesPokemonDetail {
  pokemon_detail_response.SpritesPokemonDetail toResponse() =>
      pokemon_detail_response.SpritesPokemonDetail(other: other?.toResponse());
}

extension OtherPokemonDetailResponseMapper
    on pokemon_detail_response.OtherPokemonDetail {
  pokemon_detail_entity.OtherPokemonDetail toEntity() =>
      pokemon_detail_entity.OtherPokemonDetail(
        officialArtwork: officialArtwork?.toEntity(),
      );
}

extension OtherPokemonDetailEntityMapper
    on pokemon_detail_entity.OtherPokemonDetail {
  pokemon_detail_response.OtherPokemonDetail toResponse() =>
      pokemon_detail_response.OtherPokemonDetail(
        officialArtwork: officialArtwork?.toResponse(),
      );
}

extension OfficialArtworkPokemonDetailResponseMapper
    on pokemon_detail_response.OfficialArtworkPokemonDetail {
  pokemon_detail_entity.OfficialArtworkPokemonDetail toEntity() =>
      pokemon_detail_entity.OfficialArtworkPokemonDetail(
        frontDefault: frontDefault,
      );
}

extension OfficialArtworkPokemonDetailEntityMapper
    on pokemon_detail_entity.OfficialArtworkPokemonDetail {
  pokemon_detail_response.OfficialArtworkPokemonDetail toResponse() =>
      pokemon_detail_response.OfficialArtworkPokemonDetail(
        frontDefault: frontDefault,
      );
}

extension StatsPokemonDetailResponseMapper
    on pokemon_detail_response.StatsPokemonDetail {
  pokemon_detail_entity.StatsPokemonDetail toEntity() =>
      pokemon_detail_entity.StatsPokemonDetail(
        baseStat: baseStat,
        stat: stat?.toEntity(),
      );
}

extension StatsPokemonDetailEntityMapper
    on pokemon_detail_entity.StatsPokemonDetail {
  pokemon_detail_response.StatsPokemonDetail toResponse() =>
      pokemon_detail_response.StatsPokemonDetail(
        baseStat: baseStat,
        stat: stat?.toResponse(),
      );
}

extension StatPokemonDetailResponseMapper
    on pokemon_detail_response.StatPokemonDetail {
  pokemon_detail_entity.StatPokemonDetail toEntity() =>
      pokemon_detail_entity.StatPokemonDetail(name: name);
}

extension StatPokemonDetailEntityMapper
    on pokemon_detail_entity.StatPokemonDetail {
  pokemon_detail_response.StatPokemonDetail toResponse() =>
      pokemon_detail_response.StatPokemonDetail(name: name);
}

extension TypesPokemonDetailResponseMapper
    on pokemon_detail_response.TypesPokemonDetail {
  pokemon_detail_entity.TypesPokemonDetail toEntity() =>
      pokemon_detail_entity.TypesPokemonDetail(
        slot: slot,
        type: type?.toEntity(),
      );
}

extension TypesPokemonDetailEntityMapper
    on pokemon_detail_entity.TypesPokemonDetail {
  pokemon_detail_response.TypesPokemonDetail toResponse() =>
      pokemon_detail_response.TypesPokemonDetail(
        slot: slot,
        type: type?.toResponse(),
      );
}

extension TypePokemonDetailResponseMapper
    on pokemon_detail_response.TypePokemonDetail {
  pokemon_detail_entity.TypePokemonDetail toEntity() =>
      pokemon_detail_entity.TypePokemonDetail(name: name);
}

extension TypePokemonDetailEntityMapper
    on pokemon_detail_entity.TypePokemonDetail {
  pokemon_detail_response.TypePokemonDetail toResponse() =>
      pokemon_detail_response.TypePokemonDetail(name: name);
}

extension PokemonSpeciesResponseMapper
    on pokemon_species_response.PokemonSpeciesResponse {
  pokemon_species_entity.PokemonSpeciesEntity toEntity() =>
      pokemon_species_entity.PokemonSpeciesEntity(
        eggGroups: eggGroups?.map((e) => e.toEntity()).toList(),
        hatchCounter: hatchCounter,
        evolutionChain: evolutionChain?.toEntity(),
      );
}

extension PokemonSpeciesEntityMapper
    on pokemon_species_entity.PokemonSpeciesEntity {
  pokemon_species_response.PokemonSpeciesResponse toResponse() =>
      pokemon_species_response.PokemonSpeciesResponse(
        eggGroups: eggGroups?.map((e) => e.toResponse()).toList(),
        hatchCounter: hatchCounter,
        evolutionChain: evolutionChain?.toResponse(),
      );
}

extension EggGroupsPokemonSpeciesResponseMapper
    on pokemon_species_response.EggGroupsPokemonSpecies {
  pokemon_species_entity.EggGroupsPokemonSpecies toEntity() =>
      pokemon_species_entity.EggGroupsPokemonSpecies(name: name, url: url);
}

extension EggGroupsPokemonSpeciesEntityMapper
    on pokemon_species_entity.EggGroupsPokemonSpecies {
  pokemon_species_response.EggGroupsPokemonSpecies toResponse() =>
      pokemon_species_response.EggGroupsPokemonSpecies(name: name, url: url);
}

extension EvolutionChainPokemonSpeciesResponseMapper
    on pokemon_species_response.EvolutionChainPokemonSpecies {
  pokemon_species_entity.EvolutionChainPokemonSpecies toEntity() =>
      pokemon_species_entity.EvolutionChainPokemonSpecies(url: url);
}

extension EvolutionChainPokemonSpeciesEntityMapper
    on pokemon_species_entity.EvolutionChainPokemonSpecies {
  pokemon_species_response.EvolutionChainPokemonSpecies toResponse() =>
      pokemon_species_response.EvolutionChainPokemonSpecies(url: url);
}

extension EvolutionChainResponseMapper
    on evolution_chain_response.EvolutionChainResponse {
  evolution_chain_entity.EvolutionChainEntity toEntity() =>
      evolution_chain_entity.EvolutionChainEntity(chain: chain?.toEntity());
}

extension EvolutionChainEntityMapper
    on evolution_chain_entity.EvolutionChainEntity {
  evolution_chain_response.EvolutionChainResponse toResponse() =>
      evolution_chain_response.EvolutionChainResponse(
        chain: chain?.toResponse(),
      );
}

extension ChainEvolutionChainResponseMapper
    on evolution_chain_response.ChainEvolutionChain {
  evolution_chain_entity.ChainEvolutionChain toEntity() =>
      evolution_chain_entity.ChainEvolutionChain(
        evolutionDetails: evolutionDetails,
        evolvesTo: evolvesTo?.map((e) => e.toEntity()).toList(),
        species: species?.toEntity(),
      );
}

extension ChainEvolutionChainEntityMapper
    on evolution_chain_entity.ChainEvolutionChain {
  evolution_chain_response.ChainEvolutionChain toResponse() =>
      evolution_chain_response.ChainEvolutionChain(
        evolutionDetails: evolutionDetails,
        evolvesTo: evolvesTo?.map((e) => e.toResponse()).toList(),
        species: species?.toResponse(),
      );
}

extension EvolvesToEvolutionChainResponseMapper
    on evolution_chain_response.EvolvesToEvolutionChain {
  evolution_chain_entity.EvolvesToEvolutionChain toEntity() =>
      evolution_chain_entity.EvolvesToEvolutionChain(
        evolutionDetails: evolutionDetails?.map((e) => e.toEntity()).toList(),
        evolvesTo: evolvesTo?.map((e) => e.toEntity()).toList(),
        species: species?.toEntity(),
      );
}

extension EvolvesToEvolutionChainEntityMapper
    on evolution_chain_entity.EvolvesToEvolutionChain {
  evolution_chain_response.EvolvesToEvolutionChain toResponse() =>
      evolution_chain_response.EvolvesToEvolutionChain(
        evolutionDetails: evolutionDetails?.map((e) => e.toResponse()).toList(),
        evolvesTo: evolvesTo?.map((e) => e.toResponse()).toList(),
        species: species?.toResponse(),
      );
}

extension EvolutionDetailsEvolutionChainResponseMapper
    on evolution_chain_response.EvolutionDetailsEvolutionChain {
  evolution_chain_entity.EvolutionDetailsEvolutionChain toEntity() =>
      evolution_chain_entity.EvolutionDetailsEvolutionChain(
        minLevel: minLevel,
        trigger: trigger?.toEntity(),
      );
}

extension EvolutionDetailsEvolutionChainEntityMapper
    on evolution_chain_entity.EvolutionDetailsEvolutionChain {
  evolution_chain_response.EvolutionDetailsEvolutionChain toResponse() =>
      evolution_chain_response.EvolutionDetailsEvolutionChain(
        minLevel: minLevel,
        trigger: trigger?.toResponse(),
      );
}

extension TriggerEvolutionChainResponseMapper
    on evolution_chain_response.TriggerEvolutionChain {
  evolution_chain_entity.TriggerEvolutionChain toEntity() =>
      evolution_chain_entity.TriggerEvolutionChain(name: name);
}

extension TriggerEvolutionChainEntityMapper
    on evolution_chain_entity.TriggerEvolutionChain {
  evolution_chain_response.TriggerEvolutionChain toResponse() =>
      evolution_chain_response.TriggerEvolutionChain(name: name);
}

extension AlphaEvolvesToEvolutionChainResponseMapper
    on evolution_chain_response.AlphaEvolvesToEvolutionChain {
  evolution_chain_entity.AlphaEvolvesToEvolutionChain toEntity() =>
      evolution_chain_entity.AlphaEvolvesToEvolutionChain(
        evolutionDetails: evolutionDetails?.map((e) => e.toEntity()).toList(),
        evolvesTo: evolvesTo,
        species: species?.toEntity(),
      );
}

extension AlphaEvolvesToEvolutionChainEntityMapper
    on evolution_chain_entity.AlphaEvolvesToEvolutionChain {
  evolution_chain_response.AlphaEvolvesToEvolutionChain toResponse() =>
      evolution_chain_response.AlphaEvolvesToEvolutionChain(
        evolutionDetails: evolutionDetails?.map((e) => e.toResponse()).toList(),
        evolvesTo: evolvesTo,
        species: species?.toResponse(),
      );
}

extension AlphaEvolutionDetailsEvolutionChainResponseMapper
    on evolution_chain_response.AlphaEvolutionDetailsEvolutionChain {
  evolution_chain_entity.AlphaEvolutionDetailsEvolutionChain toEntity() =>
      evolution_chain_entity.AlphaEvolutionDetailsEvolutionChain(
        minLevel: minLevel,
        trigger: trigger?.toEntity(),
      );
}

extension AlphaEvolutionDetailsEvolutionChainEntityMapper
    on evolution_chain_entity.AlphaEvolutionDetailsEvolutionChain {
  evolution_chain_response.AlphaEvolutionDetailsEvolutionChain toResponse() =>
      evolution_chain_response.AlphaEvolutionDetailsEvolutionChain(
        minLevel: minLevel,
        trigger: trigger?.toResponse(),
      );
}

extension AlphaTriggerEvolutionChainResponseMapper
    on evolution_chain_response.AlphaTriggerEvolutionChain {
  evolution_chain_entity.AlphaTriggerEvolutionChain toEntity() =>
      evolution_chain_entity.AlphaTriggerEvolutionChain(name: name);
}

extension AlphaTriggerEvolutionChainEntityMapper
    on evolution_chain_entity.AlphaTriggerEvolutionChain {
  evolution_chain_response.AlphaTriggerEvolutionChain toResponse() =>
      evolution_chain_response.AlphaTriggerEvolutionChain(name: name);
}

extension SpeciesEvolutionChainResponseMapper
    on evolution_chain_response.SpeciesEvolutionChain {
  evolution_chain_entity.SpeciesEvolutionChain toEntity() =>
      evolution_chain_entity.SpeciesEvolutionChain(name: name, url: url);
}

extension SpeciesEvolutionChainEntityMapper
    on evolution_chain_entity.SpeciesEvolutionChain {
  evolution_chain_response.SpeciesEvolutionChain toResponse() =>
      evolution_chain_response.SpeciesEvolutionChain(name: name, url: url);
}

extension AlphaSpeciesEvolutionChainResponseMapper
    on evolution_chain_response.AlphaSpeciesEvolutionChain {
  evolution_chain_entity.AlphaSpeciesEvolutionChain toEntity() =>
      evolution_chain_entity.AlphaSpeciesEvolutionChain(name: name, url: url);
}

extension AlphaSpeciesEvolutionChainEntityMapper
    on evolution_chain_entity.AlphaSpeciesEvolutionChain {
  evolution_chain_response.AlphaSpeciesEvolutionChain toResponse() =>
      evolution_chain_response.AlphaSpeciesEvolutionChain(name: name, url: url);
}

extension BetaSpeciesEvolutionChainResponseMapper
    on evolution_chain_response.BetaSpeciesEvolutionChain {
  evolution_chain_entity.BetaSpeciesEvolutionChain toEntity() =>
      evolution_chain_entity.BetaSpeciesEvolutionChain(name: name, url: url);
}

extension BetaSpeciesEvolutionChainEntityMapper
    on evolution_chain_entity.BetaSpeciesEvolutionChain {
  evolution_chain_response.BetaSpeciesEvolutionChain toResponse() =>
      evolution_chain_response.BetaSpeciesEvolutionChain(name: name, url: url);
}
