import 'package:flutter/material.dart';
import '../models/dinosaur.dart';

/// Фонові голографічні лінії та сітка в стилі меню енграм ARK
class ArkScaffoldBackground extends StatelessWidget {
  final Widget child;

  const ArkScaffoldBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF030C16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF061829),
            Color(0xFF030D18),
            Color(0xFF01060B),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background ambient cyber glows
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00E5FF).withOpacity(0.07),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00558F).withOpacity(0.12),
              ),
            ),
          ),

          // Cyber Engram grid overlay
          Positioned.fill(
            child: CustomPaint(
              painter: _ArkGridPainter(),
            ),
          ),

          // Main child content
          SafeArea(child: child),
        ],
      ),
    );
  }
}

class _ArkGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = const Color(0xFF00E5FF).withOpacity(0.025)
      ..strokeWidth = 0.8;

    // Horizontal lines
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Vertical lines
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Cyber Container з неоновою рамкою у стилі ARK HUD
class ArkCyberContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final String? title;
  final IconData? icon;

  const ArkCyberContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.margin = const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
    this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: const Color(0xFF061826).withOpacity(0.92),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF00E5FF).withOpacity(0.55),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00E5FF).withOpacity(0.08),
            blurRadius: 10,
            spreadRadius: 1,
          ),
          const BoxShadow(
            color: Color(0xFF000B14),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF002942).withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  topRight: Radius.circular(7),
                ),
                border: Border(
                  bottom: BorderSide(
                    color: const Color(0xFF00E5FF).withOpacity(0.35),
                    width: 0.8,
                  ),
                ),
              ),
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 16, color: const Color(0xFF00E5FF)),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    title!.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF80D8FF),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: padding,
            child: child,
          ),
        ],
      ),
    );
  }
}

/// Діалог/шторка фільтрації
class ArkFilterState {
  DietType? diet;
  TemperamentType? temperament;
  HabitatType? habitat;

  ArkFilterState({this.diet, this.temperament, this.habitat});

  bool get isActive => diet != null || temperament != null || habitat != null;

  void reset() {
    diet = null;
    temperament = null;
    habitat = null;
  }
}

class ArkFilterBottomSheet extends StatefulWidget {
  final ArkFilterState initialState;
  final Function(ArkFilterState) onApply;

  const ArkFilterBottomSheet({
    super.key,
    required this.initialState,
    required this.onApply,
  });

  @override
  State<ArkFilterBottomSheet> createState() => _ArkFilterBottomSheetState();
}

class _ArkFilterBottomSheetState extends State<ArkFilterBottomSheet> {
  late DietType? _selectedDiet;
  late TemperamentType? _selectedTemperament;
  late HabitatType? _selectedHabitat;

  @override
  void initState() {
    super.initState();
    _selectedDiet = widget.initialState.diet;
    _selectedTemperament = widget.initialState.temperament;
    _selectedHabitat = widget.initialState.habitat;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF04121F),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        border: Border.all(
          color: const Color(0xFF00E5FF).withOpacity(0.6),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00E5FF).withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.filter_alt_rounded, color: Color(0xFF00E5FF), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'ФІЛЬТРИ ДИНОЗАВРІВ',
                    style: TextStyle(
                      color: Color(0xFFE0F7FA),
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedDiet = null;
                    _selectedTemperament = null;
                    _selectedHabitat = null;
                  });
                },
                child: const Text(
                  'Скинути',
                  style: TextStyle(color: Color(0xFFFF5252), fontSize: 13),
                ),
              ),
            ],
          ),

          const Divider(color: Color(0xFF00E5FF), thickness: 0.5),
          const SizedBox(height: 8),

          // 1. Diet Filter (Раціон)
          const Text(
            'РАЦІОН ХАРЧУВАННЯ:',
            style: TextStyle(
              color: Color(0xFF80D8FF),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            children: [
              _buildChoiceChip(
                label: 'Всі',
                isSelected: _selectedDiet == null,
                onSelected: () => setState(() => _selectedDiet = null),
              ),
              _buildChoiceChip(
                label: 'Травоїдний',
                isSelected: _selectedDiet == DietType.herbivore,
                color: const Color(0xFF69F0AE),
                onSelected: () => setState(() => _selectedDiet = DietType.herbivore),
              ),
              _buildChoiceChip(
                label: "М'ясоїдний",
                isSelected: _selectedDiet == DietType.carnivore,
                color: const Color(0xFFFF5252),
                onSelected: () => setState(() => _selectedDiet = DietType.carnivore),
              ),
              _buildChoiceChip(
                label: 'Рибоїдний',
                isSelected: _selectedDiet == DietType.piscivore,
                color: const Color(0xFF40C4FF),
                onSelected: () => setState(() => _selectedDiet = DietType.piscivore),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // 2. Temperament Filter (Поведінка)
          const Text(
            'ПОВЕДІНКА В ПРИРОДІ:',
            style: TextStyle(
              color: Color(0xFF80D8FF),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            children: [
              _buildChoiceChip(
                label: 'Всі',
                isSelected: _selectedTemperament == null,
                onSelected: () => setState(() => _selectedTemperament = null),
              ),
              _buildChoiceChip(
                label: 'Пасивний',
                isSelected: _selectedTemperament == TemperamentType.passive,
                color: const Color(0xFF00E676),
                onSelected: () => setState(() => _selectedTemperament = TemperamentType.passive),
              ),
              _buildChoiceChip(
                label: 'Нейтральний',
                isSelected: _selectedTemperament == TemperamentType.neutral,
                color: const Color(0xFFFFD600),
                onSelected: () => setState(() => _selectedTemperament = TemperamentType.neutral),
              ),
              _buildChoiceChip(
                label: 'Агресивний',
                isSelected: _selectedTemperament == TemperamentType.aggressive,
                color: const Color(0xFFFF3D00),
                onSelected: () => setState(() => _selectedTemperament = TemperamentType.aggressive),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // 3. Habitat Filter (Середовище існування)
          const Text(
            'СЕРЕДОВИЩЕ І ТИП:',
            style: TextStyle(
              color: Color(0xFF80D8FF),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            children: [
              _buildChoiceChip(
                label: 'Всі',
                isSelected: _selectedHabitat == null,
                onSelected: () => setState(() => _selectedHabitat = null),
              ),
              _buildChoiceChip(
                label: 'Наземний',
                isSelected: _selectedHabitat == HabitatType.terrestrial,
                onSelected: () => setState(() => _selectedHabitat = HabitatType.terrestrial),
              ),
              _buildChoiceChip(
                label: 'Літун',
                isSelected: _selectedHabitat == HabitatType.flying,
                onSelected: () => setState(() => _selectedHabitat = HabitatType.flying),
              ),
              _buildChoiceChip(
                label: 'Морський',
                isSelected: _selectedHabitat == HabitatType.marine,
                onSelected: () => setState(() => _selectedHabitat = HabitatType.marine),
              ),
              _buildChoiceChip(
                label: 'Напівводний',
                isSelected: _selectedHabitat == HabitatType.semiAquatic,
                onSelected: () => setState(() => _selectedHabitat = HabitatType.semiAquatic),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Apply button
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0091EA),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Color(0xFF00E5FF), width: 1.2),
                ),
                elevation: 6,
                shadowColor: const Color(0xFF00E5FF).withOpacity(0.5),
              ),
              onPressed: () {
                widget.onApply(
                  ArkFilterState(
                    diet: _selectedDiet,
                    temperament: _selectedTemperament,
                    habitat: _selectedHabitat,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: const Text(
                'ЗАСТОСУВАТИ ФІЛЬТР',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildChoiceChip({
    required String label,
    required bool isSelected,
    required VoidCallback onSelected,
    Color? color,
  }) {
    final activeColor = color ?? const Color(0xFF00E5FF);

    return InkWell(
      onTap: onSelected,
      borderRadius: BorderRadius.circular(6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        margin: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: isSelected ? activeColor.withOpacity(0.24) : const Color(0xFF001B2E),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? activeColor : const Color(0xFF006B9E).withOpacity(0.4),
            width: isSelected ? 1.4 : 0.8,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: activeColor.withOpacity(0.3),
                    blurRadius: 8,
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? activeColor : const Color(0xFFB0BEC5),
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
