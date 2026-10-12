import 'package:flutter/material.dart';
import '../data/ark_map_database.dart';
import '../models/ark_map_data.dart';
import '../widgets/ark_hud_components.dart';

class ArkMapsScreen extends StatefulWidget {
  final String? initialFilterSubType;

  const ArkMapsScreen({super.key, this.initialFilterSubType});

  @override
  State<ArkMapsScreen> createState() => _ArkMapsScreenState();
}

class _ArkMapsScreenState extends State<ArkMapsScreen> {
  int _selectedMapIndex = 0;
  MapMarkerCategory? _selectedCategory;
  MapMarker? _activeMarker;
  Offset? _tappedGpsOffset;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialFilterSubType != null) {
      _searchQuery = widget.initialFilterSubType!;
      _searchController.text = widget.initialFilterSubType!;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  ArkMapInfo get _currentMap => ArkMapDatabase.maps[_selectedMapIndex];

  List<MapMarker> get _filteredMarkers {
    return _currentMap.markers.where((m) {
      if (_selectedCategory != null && m.category != _selectedCategory) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchesTitle = m.titleUa.toLowerCase().contains(q) || m.titleEn.toLowerCase().contains(q);
        final matchesDesc = m.descriptionUa.toLowerCase().contains(q);
        final matchesSub = m.subType.toLowerCase().contains(q);
        if (!matchesTitle && !matchesDesc && !matchesSub) return false;
      }
      return true;
    }).toList();
  }

  void _onMarkerTap(MapMarker marker) {
    setState(() {
      _activeMarker = marker;
      _tappedGpsOffset = null;
    });
    _showMarkerDetailsModal(marker);
  }

  void _showMarkerDetailsModal(MapMarker marker) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF041525).withOpacity(0.96),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border(
              top: BorderSide(color: marker.color, width: 2.0),
            ),
            boxShadow: [
              BoxShadow(
                color: marker.color.withOpacity(0.2),
                blurRadius: 16,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: marker.color.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: marker.color, width: 1.5),
                    ),
                    child: Center(
                      child: Text(marker.iconEmoji, style: const TextStyle(fontSize: 26)),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          marker.titleUa,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.5,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${marker.categoryNameUa} • ${marker.titleEn}',
                          style: TextStyle(
                            color: const Color(0xFF80D8FF).withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // GPS Coordinates & Danger Level Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF002A44),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFF00E5FF)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.gps_fixed_rounded, color: Color(0xFF00E5FF), size: 14),
                        const SizedBox(width: 6),
                        Text(
                          marker.gpsText,
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
                  Row(
                    children: [
                      const Text(
                        'Небезпека: ',
                        style: TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                      ...List.generate(5, (index) {
                        return Icon(
                          index < marker.dangerLevel ? Icons.local_fire_department_rounded : Icons.fiber_manual_record_outlined,
                          size: 16,
                          color: index < marker.dangerLevel ? const Color(0xFFFF5252) : Colors.white24,
                        );
                      }),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Description
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF010E18),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white12),
                ),
                child: Text(
                  marker.descriptionUa,
                  style: const TextStyle(color: Color(0xFFE0F7FA), fontSize: 13, height: 1.4),
                ),
              ),
              if (marker.requiredItemsUa != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF261D00),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFFD600).withOpacity(0.5)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Color(0xFFFFD600), size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Рекомендовано: ${marker.requiredItemsUa!}',
                          style: const TextStyle(color: Color(0xFFFFF9C4), fontSize: 11.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pop(ctx),
                  icon: const Icon(Icons.check_rounded, color: Color(0xFF020B13)),
                  label: const Text(
                    'ЗРОЗУМІЛО',
                    style: TextStyle(
                      color: Color(0xFF020B13),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.8,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00E5FF),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final markers = _filteredMarkers;

    return Scaffold(
      body: ArkScaffoldBackground(
        child: Column(
          children: [
            // Top HUD Bar
            _buildTopBar(),

            // Map Selector Tabs
            _buildMapTabs(),

            // Search & Category Filters
            _buildFiltersBar(),

            // Interactive Map Canvas Area
            Expanded(
              child: Stack(
                children: [
                  // Interactive Map View with Zoom & Pan
                  InteractiveViewer(
                    minScale: 0.8,
                    maxScale: 4.0,
                    boundaryMargin: const EdgeInsets.all(80),
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final mapSize = constraints.biggest;
                            return GestureDetector(
                              onTapUp: (details) {
                                final lat = (details.localPosition.dy / mapSize.height) * 100.0;
                                final lon = (details.localPosition.dx / mapSize.width) * 100.0;
                                setState(() {
                                  _tappedGpsOffset = Offset(lat, lon);
                                  _activeMarker = null;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF020F1C),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _currentMap.themeColor.withOpacity(0.6),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _currentMap.themeColor.withOpacity(0.12),
                                      blurRadius: 18,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Stack(
                                    children: [
                                      // Topographical Tactical Canvas
                                      Positioned.fill(
                                        child: CustomPaint(
                                          painter: _ArkTacticalMapPainter(
                                            themeColor: _currentMap.themeColor,
                                            mapId: _currentMap.id,
                                          ),
                                        ),
                                      ),

                                      // Map Markers
                                      ...markers.map((marker) {
                                        final x = (marker.lon / 100.0) * (mapSize.width - 24);
                                        final y = (marker.lat / 100.0) * (mapSize.height - 24);
                                        final isSelected = _activeMarker?.id == marker.id;

                                        return Positioned(
                                          left: x - 14,
                                          top: y - 14,
                                          child: GestureDetector(
                                            onTap: () => _onMarkerTap(marker),
                                            child: AnimatedContainer(
                                              duration: const Duration(milliseconds: 200),
                                              width: isSelected ? 34 : 28,
                                              height: isSelected ? 34 : 28,
                                              decoration: BoxDecoration(
                                                color: marker.color.withOpacity(0.9),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: isSelected ? 2.2 : 1.2,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: marker.color.withOpacity(0.6),
                                                    blurRadius: isSelected ? 12 : 6,
                                                    spreadRadius: isSelected ? 2 : 1,
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  marker.iconEmoji,
                                                  style: TextStyle(fontSize: isSelected ? 16 : 13),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),

                                      // Tapped GPS Pin marker if active
                                      if (_tappedGpsOffset != null) ...[
                                        Positioned(
                                          left: (_tappedGpsOffset!.dx / 100.0 * (mapSize.width - 24)) - 12,
                                          top: (_tappedGpsOffset!.dy / 100.0 * (mapSize.height - 24)) - 12,
                                          child: const Icon(
                                            Icons.location_pin,
                                            color: Color(0xFF00E5FF),
                                            size: 26,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // Floating HUD GPS coordinate viewer
                  Positioned(
                    bottom: 12,
                    left: 16,
                    right: 16,
                    child: _buildGpsHudBanner(markers.length),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      decoration: BoxDecoration(
        color: const Color(0xFF041424).withOpacity(0.9),
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
                ),
                child: const Icon(
                  Icons.map_rounded,
                  color: Color(0xFF00E5FF),
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'ARK SATELLITE RADAR',
                    style: TextStyle(
                      color: Color(0xFF80D8FF),
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    'ІНТЕРАКТИВНІ КАРТИ',
                    style: TextStyle(
                      color: Color(0xFFE0F7FA),
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF002E4C),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.5)),
            ),
            child: Row(
              children: const [
                Icon(Icons.zoom_in, color: Color(0xFF00E5FF), size: 14),
                SizedBox(width: 4),
                Text(
                  'ПІНЧ ДЛЯ ЗУМУ',
                  style: TextStyle(
                    color: Color(0xFF00E5FF),
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
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

  Widget _buildMapTabs() {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        itemCount: ArkMapDatabase.maps.length,
        itemBuilder: (context, index) {
          final map = ArkMapDatabase.maps[index];
          final isSelected = index == _selectedMapIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(map.nameUa),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedMapIndex = index;
                    _activeMarker = null;
                    _tappedGpsOffset = null;
                  });
                }
              },
              selectedColor: map.themeColor.withOpacity(0.25),
              backgroundColor: const Color(0xFF001B2E),
              labelStyle: TextStyle(
                color: isSelected ? map.themeColor : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
              side: BorderSide(
                color: isSelected ? map.themeColor : const Color(0xFF003D66),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFiltersBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Column(
        children: [
          // Search Field
          Container(
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFF031627),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.35)),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => setState(() => _searchQuery = val),
              style: const TextStyle(color: Colors.white, fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Пошук точок (Рекс, Метал, Печера, Обеліск)...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF00E5FF), size: 18),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.white60, size: 16),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Category Filters Chips Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryChip(null, 'Усі точки', '📍'),
                _buildCategoryChip(MapMarkerCategory.spawn, 'Спавни', '🦖'),
                _buildCategoryChip(MapMarkerCategory.resource, 'Ресурси', '⛏️'),
                _buildCategoryChip(MapMarkerCategory.cave, 'Печери', '🏺'),
                _buildCategoryChip(MapMarkerCategory.obelisk, 'Обеліски', '🗼'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(MapMarkerCategory? category, String label, String icon) {
    final isSelected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: InkWell(
        onTap: () => setState(() => _selectedCategory = category),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF00E5FF).withOpacity(0.2) : const Color(0xFF001726),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isSelected ? const Color(0xFF00E5FF) : const Color(0xFF003859),
            ),
          ),
          child: Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 12)),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF00E5FF) : Colors.white70,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGpsHudBanner(int visibleCount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF031422).withOpacity(0.92),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.radar_rounded, color: Color(0xFF00E5FF), size: 18),
              const SizedBox(width: 8),
              if (_tappedGpsOffset != null)
                Text(
                  'GPS: LAT ${_tappedGpsOffset!.dx.toStringAsFixed(1)} | LON ${_tappedGpsOffset!.dy.toStringAsFixed(1)}',
                  style: const TextStyle(
                    color: Color(0xFF00E5FF),
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                )
              else
                Text(
                  'Клікніть на точку для інформації',
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11.5),
                ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF002E4C),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$visibleCount точок',
              style: const TextStyle(
                color: Color(0xFF80D8FF),
                fontSize: 10.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Високотехнологічний кастомний малювальник тактичної карти ARK
class _ArkTacticalMapPainter extends CustomPainter {
  final Color themeColor;
  final String mapId;

  _ArkTacticalMapPainter({required this.themeColor, required this.mapId});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Deep ocean base
    final oceanPaint = Paint()..color = const Color(0xFF020C17);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), oceanPaint);

    // 2. Coastal shallow water glow
    final shallowWaterPaint = Paint()
      ..color = const Color(0xFF00273F).withOpacity(0.5)
      ..style = PaintingStyle.fill;

    // 3. Main landmass path (tactical contour of ARK The Island)
    final landPath = Path();
    final w = size.width;
    final h = size.height;

    // Central island contour
    landPath.moveTo(w * 0.15, h * 0.25);
    landPath.quadraticBezierTo(w * 0.35, h * 0.12, w * 0.65, h * 0.15); // North coast
    landPath.quadraticBezierTo(w * 0.88, h * 0.20, w * 0.85, h * 0.45); // East coast
    landPath.quadraticBezierTo(w * 0.92, h * 0.70, w * 0.75, h * 0.82); // South-east
    landPath.quadraticBezierTo(w * 0.45, h * 0.88, w * 0.25, h * 0.82); // South coast
    landPath.quadraticBezierTo(w * 0.08, h * 0.65, w * 0.12, h * 0.45); // West coast
    landPath.close();

    // Secondary islands (Dead Island & Herbivore Island)
    final deadIsland = Path()
      ..addOval(Rect.fromCenter(center: Offset(w * 0.85, h * 0.16), width: w * 0.10, height: h * 0.08));
    final herbivoreIsland = Path()
      ..addOval(Rect.fromCenter(center: Offset(w * 0.85, h * 0.85), width: w * 0.11, height: h * 0.09));

    // Draw Landmass
    final landPaint = Paint()
      ..color = const Color(0xFF0A2538)
      ..style = PaintingStyle.fill;
    canvas.drawPath(landPath, shallowWaterPaint);
    canvas.drawPath(landPath, landPaint);
    canvas.drawPath(deadIsland, landPaint);
    canvas.drawPath(herbivoreIsland, landPaint);

    // 4. Biome textures:
    // Snow biome (North-West)
    final snowPaint = Paint()
      ..color = const Color(0xFFE0F7FA).withOpacity(0.18)
      ..style = PaintingStyle.fill;
    final snowPath = Path();
    snowPath.moveTo(w * 0.15, h * 0.25);
    snowPath.quadraticBezierTo(w * 0.35, h * 0.15, w * 0.42, h * 0.28);
    snowPath.quadraticBezierTo(w * 0.30, h * 0.40, w * 0.14, h * 0.38);
    snowPath.close();
    canvas.drawPath(snowPath, snowPaint);

    // Redwoods (Center south)
    final redwoodPaint = Paint()
      ..color = const Color(0xFF5D4037).withOpacity(0.35)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: Offset(w * 0.50, h * 0.56), width: w * 0.25, height: h * 0.18),
      redwoodPaint,
    );

    // Volcano caldera (Center)
    final volcanoPaint = Paint()
      ..color = const Color(0xFFFF5722).withOpacity(0.25)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w * 0.42, h * 0.38), w * 0.06, volcanoPaint);

    // Rivers (meandering waterways)
    final riverPaint = Paint()
      ..color = const Color(0xFF00E5FF).withOpacity(0.35)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    final riverPath = Path();
    riverPath.moveTo(w * 0.42, h * 0.38);
    riverPath.quadraticBezierTo(w * 0.55, h * 0.48, w * 0.65, h * 0.68);
    riverPath.quadraticBezierTo(w * 0.70, h * 0.80, w * 0.72, h * 0.84);
    canvas.drawPath(riverPath, riverPaint);

    // 5. GPS Grid lines & Coordinates (every 10%)
    final gridPaint = Paint()
      ..color = themeColor.withOpacity(0.12)
      ..strokeWidth = 0.8;

    for (int i = 1; i < 10; i++) {
      final pos = i * 0.1;
      // Verticals (Longitude)
      canvas.drawLine(Offset(w * pos, 0), Offset(w * pos, h), gridPaint);
      // Horizontals (Latitude)
      canvas.drawLine(Offset(0, h * pos), Offset(w, h * pos), gridPaint);
    }

    // Border glowing frame
    final borderPaint = Paint()
      ..color = themeColor.withOpacity(0.5)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), borderPaint);
  }

  @override
  bool shouldRepaint(covariant _ArkTacticalMapPainter oldDelegate) =>
      oldDelegate.themeColor != themeColor || oldDelegate.mapId != mapId;
}
