// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, require_trailing_commas, prefer_single_quotes, prefer_double_quotes, unused_import

import 'package:poketter/features/pokemon/pokemon_detail/mapper.dart';
import 'package:poketter/features/pokemon/pokemon_detail/data/models/response/pokemon_detail_response.dart'
    as response_pokemon_detail;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_detail_entity.dart'
    as entity_pokemon_detail;
import 'package:poketter/features/pokemon/pokemon_detail/data/models/response/pokemon_species_response.dart'
    as response_pokemon_species;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/pokemon_species_entity.dart'
    as entity_pokemon_species;
import 'package:poketter/features/pokemon/pokemon_detail/data/models/response/evolution_chain_response.dart'
    as response_evolution_chain;
import 'package:poketter/features/pokemon/pokemon_detail/domain/entities/evolution_chain_entity.dart'
    as entity_evolution_chain;
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  test('mapper response model to entity PokemonDetail', () {
    const responsePokemonDetail = response_pokemon_detail.PokemonDetailResponse(
      id: 1,
      name: 'bulbasaur',
      height: 7,
      weight: 69,
      sprites: response_pokemon_detail.SpritesPokemonDetail(
        other: response_pokemon_detail.OtherPokemonDetail(
          officialArtwork: response_pokemon_detail.OfficialArtworkPokemonDetail(
            frontDefault:
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
          ),
        ),
      ),
      stats: [
        response_pokemon_detail.StatsPokemonDetail(
          stat: response_pokemon_detail.StatPokemonDetail(name: 'hp'),
          baseStat: 45,
        ),
      ],
      types: [
        response_pokemon_detail.TypesPokemonDetail(
          type: response_pokemon_detail.TypePokemonDetail(name: 'grass'),
          slot: 1,
        ),
      ],
    );
    const entityPokemonDetail = entity_pokemon_detail.PokemonDetailEntity(
      id: 1,
      name: 'bulbasaur',
      height: 7,
      weight: 69,
      sprites: entity_pokemon_detail.SpritesPokemonDetail(
        other: entity_pokemon_detail.OtherPokemonDetail(
          officialArtwork: entity_pokemon_detail.OfficialArtworkPokemonDetail(
            frontDefault:
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
          ),
        ),
      ),
      stats: [
        entity_pokemon_detail.StatsPokemonDetail(
          stat: entity_pokemon_detail.StatPokemonDetail(name: 'hp'),
          baseStat: 45,
        ),
      ],
      types: [
        entity_pokemon_detail.TypesPokemonDetail(
          type: entity_pokemon_detail.TypePokemonDetail(name: 'grass'),
          slot: 1,
        ),
      ],
    );

    expect(responsePokemonDetail.toEntity(), entityPokemonDetail);
  });

  test('mapper entity to response model PokemonDetail', () {
    const responsePokemonDetail = response_pokemon_detail.PokemonDetailResponse(
      id: 1,
      name: 'bulbasaur',
      height: 7,
      weight: 69,
      sprites: response_pokemon_detail.SpritesPokemonDetail(
        other: response_pokemon_detail.OtherPokemonDetail(
          officialArtwork: response_pokemon_detail.OfficialArtworkPokemonDetail(
            frontDefault:
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
          ),
        ),
      ),
      stats: [
        response_pokemon_detail.StatsPokemonDetail(
          stat: response_pokemon_detail.StatPokemonDetail(name: 'hp'),
          baseStat: 45,
        ),
      ],
      types: [
        response_pokemon_detail.TypesPokemonDetail(
          type: response_pokemon_detail.TypePokemonDetail(name: 'grass'),
          slot: 1,
        ),
      ],
    );
    const entityPokemonDetail = entity_pokemon_detail.PokemonDetailEntity(
      id: 1,
      name: 'bulbasaur',
      height: 7,
      weight: 69,
      sprites: entity_pokemon_detail.SpritesPokemonDetail(
        other: entity_pokemon_detail.OtherPokemonDetail(
          officialArtwork: entity_pokemon_detail.OfficialArtworkPokemonDetail(
            frontDefault:
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png',
          ),
        ),
      ),
      stats: [
        entity_pokemon_detail.StatsPokemonDetail(
          stat: entity_pokemon_detail.StatPokemonDetail(name: 'hp'),
          baseStat: 45,
        ),
      ],
      types: [
        entity_pokemon_detail.TypesPokemonDetail(
          type: entity_pokemon_detail.TypePokemonDetail(name: 'grass'),
          slot: 1,
        ),
      ],
    );

    expect(entityPokemonDetail.toResponse(), responsePokemonDetail);
  });

  test('mapper response model to entity PokemonSpecies', () {
    const responsePokemonSpecies =
        response_pokemon_species.PokemonSpeciesResponse(
          eggGroups: [
            response_pokemon_species.EggGroupsPokemonSpecies(
              name: 'monster',
              url: 'https://pokeapi.co/api/v2/egg-group/1/',
            ),
            response_pokemon_species.EggGroupsPokemonSpecies(
              name: 'plant',
              url: 'https://pokeapi.co/api/v2/egg-group/7/',
            ),
          ],
          hatchCounter: 20,
          evolutionChain: response_pokemon_species.EvolutionChainPokemonSpecies(
            url: 'https://pokeapi.co/api/v2/evolution-chain/1/',
          ),
        );
    const entityPokemonSpecies = entity_pokemon_species.PokemonSpeciesEntity(
      eggGroups: [
        entity_pokemon_species.EggGroupsPokemonSpecies(
          name: 'monster',
          url: 'https://pokeapi.co/api/v2/egg-group/1/',
        ),
        entity_pokemon_species.EggGroupsPokemonSpecies(
          name: 'plant',
          url: 'https://pokeapi.co/api/v2/egg-group/7/',
        ),
      ],
      hatchCounter: 20,
      evolutionChain: entity_pokemon_species.EvolutionChainPokemonSpecies(
        url: 'https://pokeapi.co/api/v2/evolution-chain/1/',
      ),
    );

    expect(responsePokemonSpecies.toEntity(), entityPokemonSpecies);
  });

  test('mapper entity to response model PokemonSpecies', () {
    const responsePokemonSpecies =
        response_pokemon_species.PokemonSpeciesResponse(
          eggGroups: [
            response_pokemon_species.EggGroupsPokemonSpecies(
              name: 'monster',
              url: 'https://pokeapi.co/api/v2/egg-group/1/',
            ),
            response_pokemon_species.EggGroupsPokemonSpecies(
              name: 'plant',
              url: 'https://pokeapi.co/api/v2/egg-group/7/',
            ),
          ],
          hatchCounter: 20,
          evolutionChain: response_pokemon_species.EvolutionChainPokemonSpecies(
            url: 'https://pokeapi.co/api/v2/evolution-chain/1/',
          ),
        );
    const entityPokemonSpecies = entity_pokemon_species.PokemonSpeciesEntity(
      eggGroups: [
        entity_pokemon_species.EggGroupsPokemonSpecies(
          name: 'monster',
          url: 'https://pokeapi.co/api/v2/egg-group/1/',
        ),
        entity_pokemon_species.EggGroupsPokemonSpecies(
          name: 'plant',
          url: 'https://pokeapi.co/api/v2/egg-group/7/',
        ),
      ],
      hatchCounter: 20,
      evolutionChain: entity_pokemon_species.EvolutionChainPokemonSpecies(
        url: 'https://pokeapi.co/api/v2/evolution-chain/1/',
      ),
    );

    expect(entityPokemonSpecies.toResponse(), responsePokemonSpecies);
  });

  test('mapper response model to entity EvolutionChain', () {
    const responseEvolutionChain = response_evolution_chain.EvolutionChainResponse(
      chain: response_evolution_chain.ChainEvolutionChain(
        species: response_evolution_chain.SpeciesEvolutionChain(
          name: 'bulbasaur',
          url: 'https://pokeapi.co/api/v2/pokemon-species/1/',
        ),
        evolutionDetails: [],
        evolvesTo: [
          response_evolution_chain.EvolvesToEvolutionChain(
            species: response_evolution_chain.AlphaSpeciesEvolutionChain(
              name: 'ivysaur',
              url: 'https://pokeapi.co/api/v2/pokemon-species/2/',
            ),
            evolutionDetails: [
              response_evolution_chain.EvolutionDetailsEvolutionChain(
                trigger: response_evolution_chain.TriggerEvolutionChain(
                  name: 'level-up',
                ),
                minLevel: 16,
              ),
            ],
            evolvesTo: [
              response_evolution_chain.AlphaEvolvesToEvolutionChain(
                species: response_evolution_chain.BetaSpeciesEvolutionChain(
                  name: 'venusaur',
                  url: 'https://pokeapi.co/api/v2/pokemon-species/3/',
                ),
                evolutionDetails: [
                  response_evolution_chain.AlphaEvolutionDetailsEvolutionChain(
                    trigger:
                        response_evolution_chain.AlphaTriggerEvolutionChain(
                          name: 'level-up',
                        ),
                    minLevel: 32,
                  ),
                ],
                evolvesTo: [],
              ),
            ],
          ),
        ],
      ),
    );
    const entityEvolutionChain = entity_evolution_chain.EvolutionChainEntity(
      chain: entity_evolution_chain.ChainEvolutionChain(
        species: entity_evolution_chain.SpeciesEvolutionChain(
          name: 'bulbasaur',
          url: 'https://pokeapi.co/api/v2/pokemon-species/1/',
        ),
        evolutionDetails: [],
        evolvesTo: [
          entity_evolution_chain.EvolvesToEvolutionChain(
            species: entity_evolution_chain.AlphaSpeciesEvolutionChain(
              name: 'ivysaur',
              url: 'https://pokeapi.co/api/v2/pokemon-species/2/',
            ),
            evolutionDetails: [
              entity_evolution_chain.EvolutionDetailsEvolutionChain(
                trigger: entity_evolution_chain.TriggerEvolutionChain(
                  name: 'level-up',
                ),
                minLevel: 16,
              ),
            ],
            evolvesTo: [
              entity_evolution_chain.AlphaEvolvesToEvolutionChain(
                species: entity_evolution_chain.BetaSpeciesEvolutionChain(
                  name: 'venusaur',
                  url: 'https://pokeapi.co/api/v2/pokemon-species/3/',
                ),
                evolutionDetails: [
                  entity_evolution_chain.AlphaEvolutionDetailsEvolutionChain(
                    trigger: entity_evolution_chain.AlphaTriggerEvolutionChain(
                      name: 'level-up',
                    ),
                    minLevel: 32,
                  ),
                ],
                evolvesTo: [],
              ),
            ],
          ),
        ],
      ),
    );

    expect(responseEvolutionChain.toEntity(), entityEvolutionChain);
  });

  test('mapper entity to response model EvolutionChain', () {
    const responseEvolutionChain = response_evolution_chain.EvolutionChainResponse(
      chain: response_evolution_chain.ChainEvolutionChain(
        species: response_evolution_chain.SpeciesEvolutionChain(
          name: 'bulbasaur',
          url: 'https://pokeapi.co/api/v2/pokemon-species/1/',
        ),
        evolutionDetails: [],
        evolvesTo: [
          response_evolution_chain.EvolvesToEvolutionChain(
            species: response_evolution_chain.AlphaSpeciesEvolutionChain(
              name: 'ivysaur',
              url: 'https://pokeapi.co/api/v2/pokemon-species/2/',
            ),
            evolutionDetails: [
              response_evolution_chain.EvolutionDetailsEvolutionChain(
                trigger: response_evolution_chain.TriggerEvolutionChain(
                  name: 'level-up',
                ),
                minLevel: 16,
              ),
            ],
            evolvesTo: [
              response_evolution_chain.AlphaEvolvesToEvolutionChain(
                species: response_evolution_chain.BetaSpeciesEvolutionChain(
                  name: 'venusaur',
                  url: 'https://pokeapi.co/api/v2/pokemon-species/3/',
                ),
                evolutionDetails: [
                  response_evolution_chain.AlphaEvolutionDetailsEvolutionChain(
                    trigger:
                        response_evolution_chain.AlphaTriggerEvolutionChain(
                          name: 'level-up',
                        ),
                    minLevel: 32,
                  ),
                ],
                evolvesTo: [],
              ),
            ],
          ),
        ],
      ),
    );
    const entityEvolutionChain = entity_evolution_chain.EvolutionChainEntity(
      chain: entity_evolution_chain.ChainEvolutionChain(
        species: entity_evolution_chain.SpeciesEvolutionChain(
          name: 'bulbasaur',
          url: 'https://pokeapi.co/api/v2/pokemon-species/1/',
        ),
        evolutionDetails: [],
        evolvesTo: [
          entity_evolution_chain.EvolvesToEvolutionChain(
            species: entity_evolution_chain.AlphaSpeciesEvolutionChain(
              name: 'ivysaur',
              url: 'https://pokeapi.co/api/v2/pokemon-species/2/',
            ),
            evolutionDetails: [
              entity_evolution_chain.EvolutionDetailsEvolutionChain(
                trigger: entity_evolution_chain.TriggerEvolutionChain(
                  name: 'level-up',
                ),
                minLevel: 16,
              ),
            ],
            evolvesTo: [
              entity_evolution_chain.AlphaEvolvesToEvolutionChain(
                species: entity_evolution_chain.BetaSpeciesEvolutionChain(
                  name: 'venusaur',
                  url: 'https://pokeapi.co/api/v2/pokemon-species/3/',
                ),
                evolutionDetails: [
                  entity_evolution_chain.AlphaEvolutionDetailsEvolutionChain(
                    trigger: entity_evolution_chain.AlphaTriggerEvolutionChain(
                      name: 'level-up',
                    ),
                    minLevel: 32,
                  ),
                ],
                evolvesTo: [],
              ),
            ],
          ),
        ],
      ),
    );

    expect(entityEvolutionChain.toResponse(), responseEvolutionChain);
  });
}
