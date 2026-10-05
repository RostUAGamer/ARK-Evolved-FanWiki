import 'package:flutter/material.dart';
import '../data/dino_database.dart';
import '../models/dinosaur.dart';
import '../widgets/ark_engram_card.dart';
import '../widgets/ark_hud_components.dart';
import 'dino_detail_screen.dart';

class DinoListScreen extends StatefulWidget {
  const DinoListScreen({super.key});

  @override
  State<DinoListScreen> createState() => _DinoListScreenState();
}

class _DinoListScreenState extends State<DinoListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ArkFilterState _filterState = ArkFilterState();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return ArkFilterBottomSheet(
          initialState: _filterState,
          onApply: (newState) {
            setState(() {
              _filterState.diet = newState.diet;
              _filterState.temperament = newState.temperament;
              _filterState.habitat = newState.habitat;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. Filter by search & attributes
    final filteredDinos = DinoDatabase.dinosaurs.where((dino) {
      // Search query (UA and EN)
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchesUa = dino.nameUa.toLowerCase().contains(q);
        final matchesEn = dino.nameEn.toLowerCase().contains(q);
        final matchesSpecies = dino.species.toLowerCase().contains(q);
        if (!matchesUa && !matchesEn && !matchesSpecies) return false;
      }

      // Diet filter
      if (_filterState.diet != null && dino.diet != _filterState.diet) {
        return false;
      }

      // Temperament filter
      if (_filterState.temperament != null && dino.temperament != _filterState.temperament) {
        return false;
      }

      // Habitat filter
      if (_filterState.habitat != null && dino.habitat != _filterState.habitat) {
        return false;
      }

      return true;
    }).toList();

    // 2. Alphabetical Sort (А-Я за українською назвою за замовчуванням)
    filteredDinos.sort((a, b) => a.nameUa.compareTo(b.nameUa));

    return Scaffold(
      body: ArkScaffoldBackground(
        child: Column(
          children: [
            // Top Sci-Fi Engram HUD Header
            _buildArkTopHeader(),

            // Search Bar & Filter Button Row
            _buildSearchAndFilterRow(),

            // Active filter chips (if any)
            if (_filterState.isActive) _buildActiveFilterBadges(),

            // Dino Count & Engram Header Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF00E5FF),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'ЕНГРАМИ ІСТОТ [ А - Я ]',
                        style: TextStyle(
                          color: const Color(0xFF80D8FF).withOpacity(0.9),
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.0,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${filteredDinos.length} / ${DinoDatabase.dinosaurs.length}',
                    style: const TextStyle(
                      color: Color(0xFF00E5FF),
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Dinosaur Engram Cards List
            Expanded(
              child: filteredDinos.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 24, top: 4),
                      itemCount: filteredDinos.length,
                      itemBuilder: (context, index) {
                        final dino = filteredDinos[index];
                        return ArkEngramCard(
                          dino: dino,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DinoDetailScreen(dino: dino),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArkTopHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      decoration: BoxDecoration(
        color: const Color(0xFF041424).withOpacity(0.85),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF00E5FF).withOpacity(0.35),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: const Color(0xFF002238),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFF00E5FF).withOpacity(0.8),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00E5FF).withOpacity(0.3),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.electric_bolt_rounded,
                  color: Color(0xFF00E5FF),
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'ARK: SURVIVAL EVOLVED',
                    style: TextStyle(
                      color: Color(0xFF80D8FF),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    'ЕНЦИКЛОПЕДІЯ ДИНОЗАВРІВ',
                    style: TextStyle(
                      color: Color(0xFFE0F7FA),
                      fontSize: 16.5,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Engram Hexagon badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF002E4C).withOpacity(0.7),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.5)),
            ),
            child: Row(
              children: const [
                Icon(Icons.hexagon_outlined, size: 14, color: Color(0xFF00E5FF)),
                SizedBox(width: 4),
                Text(
                  'ENGRAM',
                  style: TextStyle(
                    color: Color(0xFF00E5FF),
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilterRow() {
    final hasActiveFilter = _filterState.isActive;

    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
      child: Row(
        children: [
          // Search Input Field in Sci-Fi style
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF061A2B),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF00E5FF).withOpacity(0.4),
                  width: 1.0,
                ),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white, fontSize: 13.5),
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val.trim();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Пошук за назвою (укр / англ)...',
                  hintStyle: TextStyle(
                    color: const Color(0xFF80D8FF).withOpacity(0.5),
                    fontSize: 12.5,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF00E5FF),
                    size: 20,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close, color: Colors.white70, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Filter Button
          InkWell(
            onTap: _openFilterDialog,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: hasActiveFilter
                    ? const Color(0xFF0091EA).withOpacity(0.4)
                    : const Color(0xFF061A2B),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: hasActiveFilter
                      ? const Color(0xFF00E5FF)
                      : const Color(0xFF00E5FF).withOpacity(0.5),
                  width: hasActiveFilter ? 1.5 : 1.0,
                ),
                boxShadow: hasActiveFilter
                    ? [
                        BoxShadow(
                          color: const Color(0xFF00E5FF).withOpacity(0.3),
                          blurRadius: 8,
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.filter_list_rounded,
                    color: hasActiveFilter ? const Color(0xFF00E5FF) : const Color(0xFF80D8FF),
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'ФІЛЬТР',
                    style: TextStyle(
                      color: hasActiveFilter ? const Color(0xFF00E5FF) : Colors.white70,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      letterSpacing: 0.8,
                    ),
                  ),
                  if (hasActiveFilter) ...[
                    const SizedBox(width: 5),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00E5FF),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveFilterBadges() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  if (_filterState.diet != null)
                    _buildActiveBadge(
                      label: 'Раціон: ${_getDietLabel(_filterState.diet!)}',
                      onClear: () => setState(() => _filterState.diet = null),
                    ),
                  if (_filterState.temperament != null)
                    _buildActiveBadge(
                      label: 'Поведінка: ${_getTemperamentLabel(_filterState.temperament!)}',
                      onClear: () => setState(() => _filterState.temperament = null),
                    ),
                  if (_filterState.habitat != null)
                    _buildActiveBadge(
                      label: 'Середовище: ${_getHabitatLabel(_filterState.habitat!)}',
                      onClear: () => setState(() => _filterState.habitat = null),
                    ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => setState(() => _filterState.reset()),
            child: const Padding(
              padding: EdgeInsets.only(left: 6),
              child: Text(
                'Скинути всі',
                style: TextStyle(
                  color: Color(0xFFFF5252),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveBadge({required String label, required VoidCallback onClear}) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFF003859),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0xFF00E5FF), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFE0F7FA),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: onClear,
            child: const Icon(Icons.close, size: 14, color: Color(0xFF00E5FF)),
          ),
        ],
      ),
    );
  }

  String _getDietLabel(DietType diet) {
    switch (diet) {
      case DietType.carnivore:
        return "М'ясоїдний";
      case DietType.herbivore:
        return "Травоїдний";
      case DietType.piscivore:
        return "Рибоїдний";
    }
  }

  String _getTemperamentLabel(TemperamentType t) {
    switch (t) {
      case TemperamentType.passive:
        return "Пасивний";
      case TemperamentType.neutral:
        return "Нейтральний";
      case TemperamentType.aggressive:
        return "Агресивний";
    }
  }

  String _getHabitatLabel(HabitatType h) {
    switch (h) {
      case HabitatType.terrestrial:
        return "Наземний";
      case HabitatType.flying:
        return "Літун";
      case HabitatType.marine:
        return "Морський";
      case HabitatType.semiAquatic:
        return "Напівводний";
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 56,
            color: const Color(0xFF00E5FF).withOpacity(0.5),
          ),
          const SizedBox(height: 12),
          const Text(
            'ІСТОТ ЗА ФІЛЬТРОМ НЕ ЗНАЙДЕНО',
            style: TextStyle(
              color: Color(0xFF80D8FF),
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Спробуйте змінити критерії пошуку або скинути фільтри',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF003859),
              foregroundColor: const Color(0xFF00E5FF),
              side: const BorderSide(color: Color(0xFF00E5FF)),
            ),
            onPressed: () {
              setState(() {
                _searchController.clear();
                _searchQuery = '';
                _filterState.reset();
              });
            },
            child: const Text('Скинути всі параметри'),
          ),
        ],
      ),
    );
  }
}
