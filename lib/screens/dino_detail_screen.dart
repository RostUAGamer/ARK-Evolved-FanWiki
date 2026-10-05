import 'package:flutter/material.dart';
import '../models/dinosaur.dart';
import '../data/dino_database.dart';
import '../widgets/ark_hud_components.dart';
import '../widgets/cryopod_avatar.dart';

class DinoDetailScreen extends StatefulWidget {
  final Dinosaur dino;
  final ScrollController? scrollController;

  const DinoDetailScreen({
    super.key,
    required this.dino,
    this.scrollController,
  });

  @override
  State<DinoDetailScreen> createState() => _DinoDetailScreenState();
}

class _DinoDetailScreenState extends State<DinoDetailScreen> {
  int _selectedLevel = 150;
  bool _applyHeadshot = false;

  final List<int> _milestoneLevels = [1, 30, 60, 90, 120, 150];

  String _formatTime(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    if (hours > 0) {
      return '$hours год $minutes хв';
    } else if (minutes > 0) {
      return '$minutes хв $seconds с';
    } else {
      return '$seconds с';
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTorpor = widget.dino.getTorpor(_selectedLevel);
    final maxTorpor150 = widget.dino.getTorpor(150);
    final effectiveMultiplier = (_applyHeadshot && widget.dino.headshotMultiplier > 1.0)
        ? widget.dino.headshotMultiplier
        : (widget.dino.headshotMultiplier < 1.0 ? widget.dino.headshotMultiplier : 1.0);

    return Scaffold(
      body: ArkScaffoldBackground(
        child: CustomScrollView(
          controller: widget.scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Sci-Fi ARK AppBar
            SliverAppBar(
              backgroundColor: const Color(0xFF041320).withOpacity(0.9),
              elevation: 4,
              pinned: true,
              leading: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF002238),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF00E5FF).withOpacity(0.7),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xFF00E5FF),
                    size: 16,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                widget.dino.nameUa.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFFE0F7FA),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF003859),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: const Color(0xFF00E5FF), width: 1),
                      ),
                      child: Text(
                        'LVL $_selectedLevel',
                        style: const TextStyle(
                          color: Color(0xFF00E5FF),
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content List
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. Creature Hero Card (Cryopod Viewport & Basic Info)
                    _buildHeroHeader(),

                    // 2. Interactive Level & Torpor Calculator
                    _buildTorporCalculator(currentTorpor, maxTorpor150),

                    // 3. Torpor Milestones Quick Table (1, 30, 60, 90, 120, 150)
                    _buildMilestonesTable(),

                    // 4. Knockout Weapons Calculator
                    _buildKnockoutCalculator(currentTorpor, effectiveMultiplier),

                    // 5. Taming Food & Time Calculator
                    _buildTamingCalculator(),

                    // 6. Movement Speed Stats (Walk, Run, Swim, Fly)
                    _buildSpeedStats(),

                    // 7. Wiki Dossier & Lore
                    _buildWikiDossier(),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroHeader() {
    return ArkCyberContainer(
      title: 'ДОСЬЄ КРІОПОДА',
      icon: Icons.biotech_rounded,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CryopodAvatar(
            dino: widget.dino,
            size: 96,
            showBadge: true,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.dino.nameUa,
                  style: const TextStyle(
                    color: Color(0xFFE0F7FA),
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  widget.dino.nameEn,
                  style: const TextStyle(
                    color: Color(0xFF80D8FF),
                    fontSize: 14.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.dino.species,
                  style: TextStyle(
                    color: const Color(0xFFB0BEC5).withOpacity(0.8),
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    _buildHeaderBadge(
                      label: widget.dino.dietStringUa,
                      color: widget.dino.diet == DietType.carnivore
                          ? const Color(0xFFFF5252)
                          : (widget.dino.diet == DietType.herbivore
                              ? const Color(0xFF69F0AE)
                              : const Color(0xFF40C4FF)),
                    ),
                    _buildHeaderBadge(
                      label: widget.dino.temperamentStringUa,
                      color: widget.dino.temperament == TemperamentType.aggressive
                          ? const Color(0xFFFF3D00)
                          : (widget.dino.temperament == TemperamentType.neutral
                              ? const Color(0xFFFFD600)
                              : const Color(0xFF00E676)),
                    ),
                    _buildHeaderBadge(
                      label: widget.dino.habitatStringUa,
                      color: const Color(0xFF00E5FF),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBadge({required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.7), width: 0.8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildTorporCalculator(double currentTorpor, double maxTorpor150) {
    return ArkCyberContainer(
      title: 'КАЛЬКУЛЯТОР ТОРПОРУ ЗА РІВНЕМ',
      icon: Icons.electric_bolt_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Selected Level and exact Torpor readout
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ОБРАНИЙ РІВЕНЬ:',
                      style: TextStyle(
                        color: Color(0xFF80D8FF),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            'LVL $_selectedLevel',
                            style: const TextStyle(
                              color: Color(0xFF00E5FF),
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7B1FA2).withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: const Color(0xFFCE93D8).withOpacity(0.6),
                                width: 0.8,
                              ),
                            ),
                            child: Text(
                              '▼ ${widget.dino.torporDrainRate}/с',
                              style: const TextStyle(
                                color: Color(0xFFE1BEE7),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'ТОРПОР (ОГЛУШЕННЯ):',
                      style: TextStyle(
                        color: Color(0xFFCE93D8),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        currentTorpor.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Color(0xFFE040FB),
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'monospace',
                          shadows: [
                            Shadow(color: Color(0xFFE040FB), blurRadius: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Cyber Torpor Progress Bar (Purple ARK Torpor theme)
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: const Color(0xFF1A0A2A),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color(0xFFAB47BC).withOpacity(0.5),
                width: 0.8,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: (currentTorpor / maxTorpor150).clamp(0.05, 1.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF7B1FA2), Color(0xFFE040FB)],
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Quick Preset Buttons: 1, 30, 60, 90, 120, 150
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _milestoneLevels.map((lvl) {
              final isSelected = _selectedLevel == lvl;
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.5),
                  child: InkWell(
                    onTap: () => setState(() => _selectedLevel = lvl),
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF00E5FF).withOpacity(0.25)
                            : const Color(0xFF002238),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF00E5FF)
                              : const Color(0xFF00557A).withOpacity(0.5),
                          width: isSelected ? 1.4 : 0.8,
                        ),
                      ),
                      child: Text(
                        '$lvl',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF00E5FF) : Colors.white70,
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 14),

          // Continuous Level Slider (1 to 150, discrete steps)
          Row(
            children: [
              const Text(
                '1',
                style: TextStyle(color: Color(0xFF80D8FF), fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: const Color(0xFF00E5FF),
                    inactiveTrackColor: const Color(0xFF003859),
                    thumbColor: const Color(0xFF00E5FF),
                    overlayColor: const Color(0xFF00E5FF).withOpacity(0.2),
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9),
                    trackHeight: 4,
                  ),
                  child: Slider(
                    value: _selectedLevel.toDouble(),
                    min: 1.0,
                    max: 150.0,
                    divisions: 149,
                    onChanged: (val) {
                      setState(() {
                        _selectedLevel = val.round();
                      });
                    },
                  ),
                ),
              ),
              const Text(
                '150',
                style: TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Center(
            child: Text(
              'Перетягуйте повзунок для вибору будь-якого рівня (напр. 52 чи 67)',
              style: TextStyle(
                color: const Color(0xFF80D8FF).withOpacity(0.7),
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestonesTable() {
    return ArkCyberContainer(
      title: 'ТАБЛИЦЯ ТОРПОРУ ЗА ЕТАЛОННИМИ РІВНЯМИ',
      icon: Icons.table_chart_rounded,
      child: Table(
        border: TableBorder.all(
          color: const Color(0xFF00E5FF).withOpacity(0.25),
          width: 0.8,
        ),
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: const Color(0xFF002238).withOpacity(0.6),
            ),
            children: const [
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  'Рівень',
                  style: TextStyle(
                    color: Color(0xFF80D8FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  'Торпор',
                  style: TextStyle(
                    color: Color(0xFFE040FB),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  'Дротики (Longneck)',
                  style: TextStyle(
                    color: Color(0xFF00E5FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          ..._milestoneLevels.map((lvl) {
            final torpor = widget.dino.getTorpor(lvl);
            final darts = (torpor / 221.0).ceil();
            final isCurrent = lvl == _selectedLevel;

            return TableRow(
              decoration: BoxDecoration(
                color: isCurrent
                    ? const Color(0xFF00E5FF).withOpacity(0.12)
                    : Colors.transparent,
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    'Рівень $lvl',
                    style: TextStyle(
                      color: isCurrent ? const Color(0xFF00E5FF) : Colors.white70,
                      fontWeight: isCurrent ? FontWeight.w900 : FontWeight.normal,
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    torpor.toStringAsFixed(1),
                    style: TextStyle(
                      color: isCurrent ? const Color(0xFFE040FB) : const Color(0xFFCE93D8),
                      fontWeight: isCurrent ? FontWeight.w900 : FontWeight.w600,
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Text(
                    '$darts шт',
                    style: TextStyle(
                      color: isCurrent ? const Color(0xFF00E5FF) : const Color(0xFF80D8FF),
                      fontWeight: isCurrent ? FontWeight.w900 : FontWeight.normal,
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildKnockoutCalculator(double currentTorpor, double effectiveMultiplier) {
    return ArkCyberContainer(
      title: 'КАЛЬКУЛЯТОР ЗБРОЇ ДЛЯ ОГЛУШЕННЯ (LVL $_selectedLevel)',
      icon: Icons.track_changes_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Headshot multiplier toggle or note if applicable
          if (widget.dino.headshotMultiplier != 1.0) ...[
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: widget.dino.headshotMultiplier > 1.0
                    ? const Color(0xFF003859).withOpacity(0.5)
                    : const Color(0xFF5D1010).withOpacity(0.5),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: widget.dino.headshotMultiplier > 1.0
                      ? const Color(0xFF00E5FF).withOpacity(0.6)
                      : const Color(0xFFFF5252).withOpacity(0.6),
                  width: 0.8,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.dino.headshotMultiplier > 1.0 ? Icons.gps_fixed : Icons.shield,
                    color: widget.dino.headshotMultiplier > 1.0
                        ? const Color(0xFF00E5FF)
                        : const Color(0xFFFF5252),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.dino.headshotMultiplier > 1.0
                          ? 'Ця істота отримує х${widget.dino.headshotMultiplier} торпору при пострілі в голову!'
                          : 'Лобовий щит знижує торпор на 85% (х0.15) при попаданні в голову!',
                      style: const TextStyle(color: Colors.white, fontSize: 11.5),
                    ),
                  ),
                  if (widget.dino.headshotMultiplier > 1.0)
                    Switch(
                      value: _applyHeadshot,
                      activeColor: const Color(0xFF00E5FF),
                      onChanged: (val) => setState(() => _applyHeadshot = val),
                    ),
                ],
              ),
            ),
          ],

          // List of Knockout weapons
          ...DinoDatabase.knockoutWeapons.map((weapon) {
            final shots = weapon.shotsNeeded(currentTorpor, multiplier: effectiveMultiplier);
            final weaponTorpor = weapon.baseTorporPerHit * effectiveMultiplier;

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF001B2E).withOpacity(0.65),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0xFF0091EA).withOpacity(0.3),
                  width: 0.8,
                ),
              ),
              child: Row(
                children: [
                  Text(
                    weapon.icon,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weapon.nameUa,
                          style: const TextStyle(
                            color: Color(0xFFE0F7FA),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${weaponTorpor.toStringAsFixed(1)} торпору/удар • ${weapon.nameEn}',
                          style: TextStyle(
                            color: const Color(0xFF80D8FF).withOpacity(0.7),
                            fontSize: 10.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF003859),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: const Color(0xFF00E5FF).withOpacity(0.6),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$shots',
                          style: const TextStyle(
                            color: Color(0xFF00E5FF),
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const Text(
                          'пострілів',
                          style: TextStyle(
                            color: Color(0xFF80D8FF),
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTamingCalculator() {
    return ArkCyberContainer(
      title: 'КАЛЬКУЛЯТОР ПРИРУЧЕННЯ (LVL $_selectedLevel)',
      icon: Icons.restaurant_menu_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFFFD600), size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Улюблений корм: ${widget.dino.preferredKibble}',
                  style: const TextStyle(
                    color: Color(0xFFFFD600),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          ...widget.dino.tamingFoods.map((food) {
            final quantity = food.getQuantity(_selectedLevel);
            final timeSeconds = food.getTimeSeconds(_selectedLevel);
            final effectiveness = (food.getEffectiveness(_selectedLevel) * 100).toStringAsFixed(1);
            final bonusLevels = food.getBonusLevels(_selectedLevel);
            final finalLevel = _selectedLevel + bonusLevels;
            final narcotics = food.getNarcotics(_selectedLevel);

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF001F33).withOpacity(0.8),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0xFF00B0FF).withOpacity(0.4),
                  width: 0.8,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(food.icon, style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text(
                            food.nameUa,
                            style: const TextStyle(
                              color: Color(0xFFE0F7FA),
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E5FF).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color(0xFF00E5FF).withOpacity(0.6),
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          '$quantity шт',
                          style: const TextStyle(
                            color: Color(0xFF00E5FF),
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Divider(color: Color(0xFF003859), height: 8),
                  const SizedBox(height: 4),

                  // Stats row: Time, Effectiveness, Bonus levels, Narcotics
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Time
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ЧАС (1х):',
                            style: TextStyle(color: Color(0xFF80D8FF), fontSize: 9.5),
                          ),
                          Text(
                            _formatTime(timeSeconds),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      // Bonus Levels
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'БОНУС РІВНІВ:',
                            style: TextStyle(color: Color(0xFF69F0AE), fontSize: 9.5),
                          ),
                          Text(
                            '+$bonusLevels (LVL $finalLevel)',
                            style: const TextStyle(
                              color: Color(0xFF69F0AE),
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),

                      // Effectiveness
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'ЕФЕКТИВНІСТЬ:',
                            style: TextStyle(color: Color(0xFFFFD600), fontSize: 9.5),
                          ),
                          Text(
                            '$effectiveness%',
                            style: const TextStyle(
                              color: Color(0xFFFFD600),
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      // Narcotics
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'НАРКОТИКИ:',
                            style: TextStyle(color: Color(0xFFCE93D8), fontSize: 9.5),
                          ),
                          Text(
                            '~${narcotics > 0 ? narcotics : 0} шт',
                            style: const TextStyle(
                              color: Color(0xFFE040FB),
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSpeedStats() {
    final speed = widget.dino.speed;

    return ArkCyberContainer(
      title: 'ШВИДКІСТЬ ПЕРЕСУВАННЯ (БАЗОВА)',
      icon: Icons.speed_rounded,
      child: Column(
        children: [
          Row(
            children: [
              // Walk
              Expanded(
                child: _buildSpecCard(
                  icon: Icons.directions_walk,
                  title: 'Ходьба',
                  value: '${speed.walking}',
                  color: const Color(0xFF80D8FF),
                ),
              ),
              const SizedBox(width: 8),

              // Run / Sprint
              Expanded(
                child: _buildSpecCard(
                  icon: Icons.directions_run,
                  title: 'Біг (Спринт)',
                  value: '${speed.running}',
                  color: const Color(0xFF00E5FF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              // Swimming
              Expanded(
                child: _buildSpecCard(
                  icon: Icons.pool,
                  title: 'Плавання',
                  value: '${speed.swimming}',
                  color: const Color(0xFF40C4FF),
                ),
              ),
              const SizedBox(width: 8),

              // Flying (if capable)
              if (speed.flying != null)
                Expanded(
                  child: _buildSpecCard(
                    icon: Icons.flight,
                    title: 'Політ / Спринт',
                    value: '${speed.flying} / ${speed.sprintFlying}',
                    color: const Color(0xFF69F0AE),
                  ),
                )
              else
                Expanded(
                  child: _buildSpecCard(
                    icon: Icons.flight_takeoff,
                    title: 'Політ',
                    value: 'Не вміє',
                    color: Colors.white38,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSpecCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF001E33),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withOpacity(0.4), width: 0.8),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWikiDossier() {
    return ArkCyberContainer(
      title: "ДОСЬЄ ГЕЛЕНИ ТА ОПИС З ВІКІПЕДІЇ",
      icon: Icons.auto_stories_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.dino.description,
            style: const TextStyle(
              color: Color(0xFFCFD8DC),
              fontSize: 13.5,
              height: 1.45,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF002238),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFF00E5FF).withOpacity(0.4),
                width: 0.8,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.link, color: Color(0xFF00E5FF), size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.dino.wikiUrl,
                    style: const TextStyle(
                      color: Color(0xFF80D8FF),
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
