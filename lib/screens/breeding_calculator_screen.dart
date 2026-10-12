import 'package:flutter/material.dart';
import '../data/breeding_database.dart';
import '../models/breeding_data.dart';
import '../widgets/ark_hud_components.dart';

class BreedingCalculatorScreen extends StatefulWidget {
  final String? initialCreatureId;

  const BreedingCalculatorScreen({super.key, this.initialCreatureId});

  @override
  State<BreedingCalculatorScreen> createState() => _BreedingCalculatorScreenState();
}

class _BreedingCalculatorScreenState extends State<BreedingCalculatorScreen> {
  late BreedingCreature _selectedCreature;
  double _hatchSpeed = 1.0;
  double _matureSpeed = 1.0;
  double _currentProgress = 0.0; // 0.0 to 100.0%

  @override
  void initState() {
    super.initState();
    if (widget.initialCreatureId != null) {
      final match = BreedingDatabase.creatures.firstWhere(
        (c) => c.id == widget.initialCreatureId,
        orElse: () => BreedingDatabase.creatures.first,
      );
      _selectedCreature = match;
    } else {
      _selectedCreature = BreedingDatabase.creatures.first;
    }
  }

  void _showCreaturePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Color(0xFF041525),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            border: Border(
              top: BorderSide(color: Color(0xFF00E5FF), width: 1.5),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF00E5FF).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'ОБЕРІТЬ ІСТОТУ ДЛЯ РОЗВЕДЕННЯ',
                      style: TextStyle(
                        color: Color(0xFF00E5FF),
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Color(0xFF003859)),
              Expanded(
                child: ListView.builder(
                  itemCount: BreedingDatabase.creatures.length,
                  itemBuilder: (context, index) {
                    final creature = BreedingDatabase.creatures[index];
                    final isSelected = creature.id == _selectedCreature.id;
                    return ListTile(
                      tileColor: isSelected ? const Color(0xFF003352) : null,
                      leading: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF002238),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF00E5FF) : const Color(0xFF00558F),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            creature.isEgg ? '🥚' : '🤰',
                            style: const TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      title: Text(
                        creature.nameUa,
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF00E5FF) : Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                        ),
                      ),
                      subtitle: Text(
                        '${creature.species} • ${creature.isEgg ? "Яйцекладна" : "Вагітність"}',
                        style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: Color(0xFF00E5FF))
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedCreature = creature;
                          _currentProgress = 0.0;
                        });
                        Navigator.pop(ctx);
                      },
                    );
                  },
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
    final incubationSec = _selectedCreature.getIncubationSeconds(_hatchSpeed);
    final totalMaturationSec = _selectedCreature.getMaturationSeconds(_matureSpeed);
    final babySec = _selectedCreature.getBabySeconds(_matureSpeed);
    final juvSec = _selectedCreature.getJuvenileSeconds(_matureSpeed);
    final adolSec = _selectedCreature.getAdolescentSeconds(_matureSpeed);

    // Dynamic calculations based on current progress %
    final remainingMaturationSec =
        (totalMaturationSec * (1.0 - (_currentProgress / 100.0))).round();
    final currentStage = _currentProgress < 10.0
        ? 'Дитинча (Baby)'
        : _currentProgress < 50.0
            ? 'Підліток (Juvenile)'
            : 'Юний (Adolescent)';

    final babyFoodQty = _selectedCreature.getBabyFoodQuantity(_matureSpeed);
    final totalFoodQty = _selectedCreature.getTotalFoodQuantity(_matureSpeed);
    final imprintCount = _selectedCreature.getImprintCount(_matureSpeed);
    final imprintGain = _selectedCreature.getImprintGainPerAction(_matureSpeed);

    return Scaffold(
      body: ArkScaffoldBackground(
        child: Column(
          children: [
            // Top HUD Bar
            _buildTopBar(),

            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 30),
                children: [
                  // Creature Selector Banner
                  _buildCreatureBanner(),

                  // Server Rates Controllers (Hatch & Mature Multipliers)
                  _buildMultiplierPanel(),

                  // Incubation / Gestation Card
                  _buildIncubationCard(incubationSec),

                  // Maturation 3-Stage Visual Pipeline
                  _buildMaturationPipeline(
                    totalSec: totalMaturationSec,
                    babySec: babySec,
                    juvSec: juvSec,
                    adolSec: adolSec,
                  ),

                  // Interactive Progress Simulator
                  _buildProgressSimulator(
                    totalSec: totalMaturationSec,
                    remainingSec: remainingMaturationSec,
                    currentStage: currentStage,
                    babySec: babySec,
                  ),

                  // Imprinting Planner Card
                  _buildImprintingCard(imprintCount, imprintGain),

                  // Food Consumption & Trough Calculator
                  _buildFoodCalculatorCard(babyFoodQty, totalFoodQty),

                  // Pro Breeding Tips Card
                  _buildTipsCard(),
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
                  Icons.biotech_rounded,
                  color: Color(0xFF00E5FF),
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'ARK BREEDING ENGINE',
                    style: TextStyle(
                      color: Color(0xFF80D8FF),
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    'КАЛЬКУЛЯТОР РОЗВЕДЕННЯ',
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
            child: const Text(
              'v1.0 GENETICS',
              style: TextStyle(
                color: Color(0xFF00E5FF),
                fontSize: 10,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreatureBanner() {
    return ArkCyberContainer(
      title: 'ОБРАНА ІСТОТА',
      icon: Icons.pets,
      child: InkWell(
        onTap: _showCreaturePicker,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF02101C),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.4)),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFF002238),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF00E5FF)),
                ),
                child: Center(
                  child: Text(
                    _selectedCreature.isEgg ? '🥚' : '🤰',
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedCreature.nameUa,
                      style: const TextStyle(
                        color: Color(0xFFE0F7FA),
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${_selectedCreature.species} • ${_selectedCreature.nameEn}',
                      style: TextStyle(
                        color: const Color(0xFF80D8FF).withOpacity(0.8),
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _selectedCreature.isEgg
                                ? const Color(0xFF00558F)
                                : const Color(0xFF880E4F),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            _selectedCreature.isEgg ? 'ІНКУБАЦІЯ ЯЙЦЯ' : 'ВАГІТНІСТЬ',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Їжа: ${_selectedCreature.primaryFoodUa}',
                          style: const TextStyle(color: Color(0xFF80D8FF), fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF00E5FF), size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMultiplierPanel() {
    return ArkCyberContainer(
      title: 'СЕРВЕРНІ МНОЖНИКИ (RATES)',
      icon: Icons.tune_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Швидкість вилуплення (Hatch Speed):',
                style: TextStyle(color: Colors.white, fontSize: 12.5),
              ),
              Text(
                '${_hatchSpeed.toStringAsFixed(1)}x',
                style: const TextStyle(
                  color: Color(0xFF00E5FF),
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF00E5FF),
              inactiveTrackColor: const Color(0xFF003859),
              thumbColor: const Color(0xFF00E5FF),
            ),
            child: Slider(
              value: _hatchSpeed,
              min: 1.0,
              max: 20.0,
              divisions: 19,
              onChanged: (val) => setState(() => _hatchSpeed = val),
            ),
          ),
          _buildQuickRateChips(
            current: _hatchSpeed,
            onSelected: (val) => setState(() => _hatchSpeed = val),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Швидкість дорослішання (Mature Speed):',
                style: TextStyle(color: Colors.white, fontSize: 12.5),
              ),
              Text(
                '${_matureSpeed.toStringAsFixed(1)}x',
                style: const TextStyle(
                  color: Color(0xFF76FF03),
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF76FF03),
              inactiveTrackColor: const Color(0xFF003859),
              thumbColor: const Color(0xFF76FF03),
            ),
            child: Slider(
              value: _matureSpeed,
              min: 1.0,
              max: 20.0,
              divisions: 19,
              onChanged: (val) => setState(() => _matureSpeed = val),
            ),
          ),
          _buildQuickRateChips(
            current: _matureSpeed,
            color: const Color(0xFF76FF03),
            onSelected: (val) => setState(() => _matureSpeed = val),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickRateChips({
    required double current,
    required ValueChanged<double> onSelected,
    Color color = const Color(0xFF00E5FF),
  }) {
    final rates = [1.0, 2.0, 3.0, 5.0, 10.0];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: rates.map((r) {
        final isSelected = (current - r).abs() < 0.1;
        return InkWell(
          onTap: () => onSelected(r),
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? color.withOpacity(0.25) : const Color(0xFF001F35),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: isSelected ? color : color.withOpacity(0.3),
              ),
            ),
            child: Text(
              '${r.toInt()}x',
              style: TextStyle(
                color: isSelected ? color : Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildIncubationCard(int incubationSec) {
    return ArkCyberContainer(
      title: _selectedCreature.isEgg ? 'ІНКУБАЦІЯ ЯЙЦЯ' : 'ПЕРІОД ВАГІТНОСТІ',
      icon: _selectedCreature.isEgg ? Icons.egg_rounded : Icons.pregnant_woman_rounded,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedCreature.isEgg ? 'Час до вилуплення:' : 'Тривалість виношування:',
                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF003352),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFF00E5FF)),
                ),
                child: Text(
                  BreedingCreature.formatDuration(incubationSec),
                  style: const TextStyle(
                    color: Color(0xFF00E5FF),
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
          if (_selectedCreature.isEgg &&
              _selectedCreature.minTempCelsius != null &&
              _selectedCreature.maxTempCelsius != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF02101C),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFFF9100).withOpacity(0.6)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.thermostat_rounded, color: Color(0xFFFF9100), size: 24),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Температурний коридор яйця:',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                        Text(
                          '${_selectedCreature.minTempCelsius}°C — ${_selectedCreature.maxTempCelsius}°C',
                          style: const TextStyle(
                            color: Color(0xFFFF9100),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF263238),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Кондиціонери: 2-4',
                      style: TextStyle(color: Color(0xFF80D8FF), fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMaturationPipeline({
    required int totalSec,
    required int babySec,
    required int juvSec,
    required int adolSec,
  }) {
    return ArkCyberContainer(
      title: '3 СТАДІЇ РОЗВИТКУ (МАТУРАЦІЯ)',
      icon: Icons.timeline_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Повний час до дорослого:',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              Text(
                BreedingCreature.formatDuration(totalSec),
                style: const TextStyle(
                  color: Color(0xFF76FF03),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Multi-color pipeline progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Container(
                    height: 12,
                    color: const Color(0xFFFF5252), // Baby red
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: Container(
                    height: 12,
                    color: const Color(0xFFFFD600), // Juvenile yellow
                  ),
                ),
                Expanded(
                  flex: 50,
                  child: Container(
                    height: 12,
                    color: const Color(0xFF00E676), // Adolescent green
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildStageRow(
            color: const Color(0xFFFF5252),
            title: '🍼 Дитинча (Baby)',
            range: '0% — 10%',
            duration: BreedingCreature.formatDuration(babySec),
            note: 'УВАГА: їсть ТІЛЬКИ з інвентарю!',
          ),
          const Divider(color: Color(0xFF003859), height: 16),
          _buildStageRow(
            color: const Color(0xFFFFD600),
            title: '🌿 Підліток (Juvenile)',
            range: '10% — 50%',
            duration: BreedingCreature.formatDuration(juvSec),
            note: 'Починає їсти зі звичайних годівниць.',
          ),
          const Divider(color: Color(0xFF003859), height: 16),
          _buildStageRow(
            color: const Color(0xFF00E676),
            title: '🦖 Юний (Adolescent)',
            range: '50% — 100%',
            duration: BreedingCreature.formatDuration(adolSec),
            note: 'Годівниці або Тек-годівниці.',
          ),
        ],
      ),
    );
  }

  Widget _buildStageRow({
    required Color color,
    required String title,
    required String range,
    required String duration,
    required String note,
  }) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$title [$range]',
                    style: const TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    duration,
                    style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w900, fontFamily: 'monospace'),
                  ),
                ],
              ),
              Text(
                note,
                style: TextStyle(color: Colors.white.withOpacity(0.55), fontSize: 10.5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSimulator({
    required int totalSec,
    required int remainingSec,
    required String currentStage,
    required int babySec,
  }) {
    return ArkCyberContainer(
      title: 'СИМУЛЯТОР ПОТОЧНОГО ПРОГРЕСУ',
      icon: Icons.speed_rounded,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Поточний % дорослішання:', style: TextStyle(color: Colors.white70, fontSize: 12)),
              Text(
                '${_currentProgress.toStringAsFixed(1)}%',
                style: const TextStyle(
                  color: Color(0xFF00E5FF),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF00E5FF),
              inactiveTrackColor: const Color(0xFF003859),
              thumbColor: const Color(0xFF00E5FF),
            ),
            child: Slider(
              value: _currentProgress,
              min: 0.0,
              max: 100.0,
              divisions: 200,
              onChanged: (val) => setState(() => _currentProgress = val),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF011422),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Поточна фаза:', style: TextStyle(color: Colors.white60, fontSize: 11)),
                    Text(
                      currentStage,
                      style: const TextStyle(color: Color(0xFF80D8FF), fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Залишилось часу:', style: TextStyle(color: Colors.white60, fontSize: 11)),
                    Text(
                      BreedingCreature.formatDuration(remainingSec),
                      style: const TextStyle(
                        color: Color(0xFF76FF03),
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'monospace',
                      ),
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

  Widget _buildImprintingCard(int count, double gain) {
    return ArkCyberContainer(
      title: 'ПЛАНУВАЛЬНИК ІМПРИНТИНГУ (ПРИВ\'ЯЗКИ)',
      icon: Icons.favorite_rounded,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF02101C),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      const Text('Кількість підходів', style: TextStyle(color: Colors.white60, fontSize: 10.5)),
                      const SizedBox(height: 4),
                      Text(
                        '$count',
                        style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF02101C),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      const Text('Бонус за 1 раз', style: TextStyle(color: Colors.white60, fontSize: 10.5)),
                      const SizedBox(height: 4),
                      Text(
                        '+${gain.toStringAsFixed(1)}%',
                        style: const TextStyle(color: Color(0xFF76FF03), fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF002238),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: const [
                Icon(Icons.star_rounded, color: Color(0xFFFFD600), size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '100% Імпринт дає: +20% до базового ХП, ваги, урону та +30% захисту/атаки вершнику!',
                    style: TextStyle(color: Color(0xFFE0F7FA), fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCalculatorCard(int babyFood, int totalFood) {
    // 20 meat/berries per stack
    final babyStacks = (babyFood / 20.0).ceil();
    final totalStacks = (totalFood / 20.0).ceil();
    // Wooden trough = 60 slots, Tek trough = 300 slots
    final woodenTroughs = (totalStacks / 60.0).ceil().clamp(1, 99);

    return ArkCyberContainer(
      title: 'РОЗРАХУНОК ЇЖІ ТА ГОДІВНИЦЬ',
      icon: Icons.restaurant_rounded,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Основна їжа: ${_selectedCreature.primaryFoodUa}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
              Text('Дитинча: $babyFood шт (~$babyStacks стаків)', style: const TextStyle(color: Color(0xFFFF8A80), fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Повна потреба до 100%:', style: TextStyle(color: Colors.white70, fontSize: 12)),
              Text('$totalFood шт (~$totalStacks стаків)', style: const TextStyle(color: Color(0xFF00E5FF), fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF011422),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFF00E5FF).withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Text('🪵 Годівниці: ', style: TextStyle(color: Colors.white70, fontSize: 11)),
                    Text('$woodenTroughs шт', style: const TextStyle(color: Color(0xFFFFD600), fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
                Row(
                  children: [
                    const Text('⚡ ТЕК-годівниця: ', style: TextStyle(color: Colors.white70, fontSize: 11)),
                    Text('${(totalStacks / 300.0).ceil().clamp(1, 99)} шт', style: const TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipsCard() {
    return ArkCyberContainer(
      title: 'ПОРАДИ ТА СЕКРЕТИ ВИРОЩУВАННЯ',
      icon: Icons.lightbulb_rounded,
      child: Text(
        _selectedCreature.tipsUa,
        style: const TextStyle(
          color: Color(0xFFE0F7FA),
          fontSize: 12.5,
          height: 1.4,
        ),
      ),
    );
  }
}
