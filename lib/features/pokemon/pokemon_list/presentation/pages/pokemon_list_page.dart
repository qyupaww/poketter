import 'dart:async';

import 'package:flutter/material.dart';
import 'package:morpheme_base/morpheme_base.dart';
import 'package:poketter/core/assets/src/morpheme_images.dart';
import 'package:poketter/core/components/components.dart';
import 'package:poketter/core/constants/constant_sizes.dart';
import 'package:poketter/core/global_variable.dart';
import 'package:poketter/core/themes/morpheme_colors/morpheme_colors.dart';
import 'package:poketter/features/pokemon/pokemon_list/domain/entities/pokemon_list_entity.dart';
import 'package:poketter/features/pokemon/pokemon_list/presentation/bloc/pokemon_list/pokemon_list_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../cubit/pokemon_filter_cubit.dart';
import '../cubit/pokemon_list_cubit.dart';
import '../widgets/pokemon_list_grid.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage>
    with MorphemeStatePage<PokemonListPage, PokemonListCubit> {
  @override
  PokemonListCubit setCubit() => locator<PokemonListCubit>();

  late final PokemonFilterCubit _filterCubit;
  StreamSubscription<PokemonFilterState>? _filterSub;
  final TextEditingController _searchController = TextEditingController();
  String? _selectedGenerationUrl;
  String? _selectedTypeUrl;
  int _filterRequestId = 0;

  List<ResultsPokemonList> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filterCubit = locator<PokemonFilterCubit>();
    _filterCubit.loadFilters();
    _searchController.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _filterSub = _filterCubit.stream.listen((s) {
        if (s.errorMessage != null && mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(s.errorMessage!)));
          _filterCubit.clearError();
        }
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _filterSub?.cancel();
    _filterCubit.close();
    super.dispose();
  }

  Future<void> _applyGenerationFilter(String? genUrl) async {
    setState(() {
      _selectedGenerationUrl = genUrl;
    });
    await _refreshFilteredItems();
  }

  Future<void> _applyTypeFilter(String? typeUrlOrName) async {
    setState(() {
      _selectedTypeUrl = typeUrlOrName;
    });
    await _refreshFilteredItems();
  }

  Future<void> _refreshFilteredItems() async {
    final requestId = ++_filterRequestId;
    final generation = _selectedGenerationUrl;
    final type = _selectedTypeUrl;

    if (generation == null && type == null) {
      if (!mounted || requestId != _filterRequestId) return;
      setState(() {
        _filteredItems = [];
      });
      return;
    }

    late final List<ResultsPokemonList> results;
    if (generation != null && type != null) {
      results = await _filterCubit.filterByGenerationAndType(generation, type);
    } else if (generation != null) {
      results = await _filterCubit.filterByGeneration(generation);
    } else {
      results = await _filterCubit.filterByType(type!);
    }

    if (!mounted || requestId != _filterRequestId) return;
    setState(() {
      _filteredItems = results;
    });
  }

  bool get _hasActiveFilters =>
      _selectedGenerationUrl != null || _selectedTypeUrl != null;

  List<ResultsPokemonList> _visibleItems(List<ResultsPokemonList> items) {
    final source = _hasActiveFilters ? _filteredItems : items;
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return source;

    return source
        .where((e) => (e.name ?? '').toLowerCase().contains(query))
        .toList();
  }

  String? _selectedFilterName(List<dynamic> options, String? selectedValue) {
    if (selectedValue == null) return null;

    final selectedSegment = _lastPathSegment(selectedValue);
    for (final option in options) {
      if (option is! Map<String, dynamic>) continue;

      final name = option['name'] as String?;
      final url = option['url'] as String?;
      final urlSegment = _lastPathSegment(url);
      if (selectedValue == name ||
          selectedValue == url ||
          selectedSegment == name ||
          selectedSegment == urlSegment) {
        return name;
      }
    }

    return selectedSegment ?? selectedValue;
  }

  String? _lastPathSegment(String? value) {
    if (value == null || value.isEmpty) return null;

    final uri = Uri.tryParse(value);
    final uriSegments = uri?.pathSegments.where((e) => e.isNotEmpty).toList();
    if (uriSegments != null && uriSegments.isNotEmpty) {
      return uriSegments.last;
    }

    final segments = value.split('/').where((e) => e.isNotEmpty).toList();
    return segments.isNotEmpty ? segments.last : value;
  }

  Widget _filterDropdown({
    required Key key,
    required String? value,
    required String hint,
    required List<dynamic> options,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      key: key,
      initialValue: value,
      isExpanded: true,
      hint: Text(hint, maxLines: 1, overflow: TextOverflow.ellipsis),
      items: options.map<DropdownMenuItem<String>>((item) {
        final option = item as Map<String, dynamic>;
        final name = option['name'] as String? ?? '';
        final url = option['url'] as String? ?? name;
        return DropdownMenuItem(
          value: url,
          child: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return BlocBuilder<PokemonListBloc, PokemonListState>(
      builder: (context, state) {
        final isLoading =
            state is PokemonListLoading || state is PokemonListInitial;
        final isFailed = state is PokemonListFailed;
        PokemonListEntity? data;

        if (state is PokemonListSuccess) {
          data = state.data;
        }

        // Mock data for skeleton loading
        final items = isLoading
            ? List.generate(8, (index) => ResultsPokemonList.dummy())
            : data?.results ?? [];

        return Scaffold(
          backgroundColor: context.color.background,
          appBar: AppBar(
            title: Image.asset(MorphemeImages.pokemon, height: 32),
            elevation: 0,
            backgroundColor: context.color.background,
            foregroundColor: context.color.black,
            centerTitle: false,
          ),
          body: isFailed
              ? Center(
                  child: AtomText.bodyMedium(
                    'Failed to load Pokemon list.',
                    color: context.color.black,
                  ),
                )
              : SafeArea(
                  top: false,
                  child: Skeletonizer(
                    enabled: isLoading,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(ConstantSizes.defaultPadding),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search Pokémon by name',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              isDense: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ConstantSizes.defaultPadding,
                          ),
                          child: BlocBuilder<PokemonFilterCubit, PokemonFilterState>(
                            bloc: _filterCubit,
                            builder: (context, filterState) {
                              final gens = filterState.generations ?? [];
                              final types = filterState.types ?? [];
                              final isFilterLoading = filterState.isLoading;
                              final selectedGenName = _selectedFilterName(
                                gens,
                                _selectedGenerationUrl,
                              );
                              final selectedTypeName = _selectedFilterName(
                                types,
                                _selectedTypeUrl,
                              );
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  LayoutBuilder(
                                    builder: (context, constraints) {
                                      final generationDropdown = _filterDropdown(
                                        key: ValueKey(
                                          'generation_${_selectedGenerationUrl ?? 'none'}',
                                        ),
                                        value: _selectedGenerationUrl,
                                        hint: 'Filter by generation',
                                        options: gens,
                                        onChanged: _applyGenerationFilter,
                                      );
                                      final typeDropdown = _filterDropdown(
                                        key: ValueKey(
                                          'type_${_selectedTypeUrl ?? 'none'}',
                                        ),
                                        value: _selectedTypeUrl,
                                        hint: 'Filter by type',
                                        options: types,
                                        onChanged: _applyTypeFilter,
                                      );

                                      if (constraints.maxWidth < 360) {
                                        return Column(
                                          children: [
                                            generationDropdown,
                                            SizedBox(height: ConstantSizes.s8),
                                            typeDropdown,
                                          ],
                                        );
                                      }

                                      return Row(
                                        children: [
                                          Expanded(child: generationDropdown),
                                          SizedBox(width: ConstantSizes.s12),
                                          Expanded(child: typeDropdown),
                                        ],
                                      );
                                    },
                                  ),
                                  if (isFilterLoading)
                                    SizedBox(height: ConstantSizes.s8),
                                  if (isFilterLoading)
                                    LinearProgressIndicator(minHeight: 3),
                                  SizedBox(height: ConstantSizes.s8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Wrap(
                                          spacing: 8,
                                          runSpacing: 4,
                                          children: [
                                            if (selectedGenName != null)
                                              InputChip(
                                                label: Text(selectedGenName),
                                                onDeleted: () {
                                                  _applyGenerationFilter(null);
                                                },
                                              ),
                                            if (selectedTypeName != null)
                                              InputChip(
                                                label: Text(selectedTypeName),
                                                onDeleted: () {
                                                  _applyTypeFilter(null);
                                                },
                                              ),
                                          ],
                                        ),
                                      ),
                                      if (_selectedGenerationUrl != null ||
                                          _selectedTypeUrl != null)
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _selectedGenerationUrl = null;
                                              _selectedTypeUrl = null;
                                            });
                                            _refreshFilteredItems();
                                          },
                                          child: const Text('Clear filters'),
                                        ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: ConstantSizes.s8),
                        Expanded(
                          child: PokemonListGrid(
                            items: _visibleItems(items),
                            isLoading: isLoading,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
