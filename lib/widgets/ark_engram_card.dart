import 'package:flutter/material.dart';
import '../models/dinosaur.dart';
import 'cryopod_avatar.dart';

class ArkEngramCard extends StatelessWidget {
  final Dinosaur dino;
  final VoidCallback onTap;

  const ArkEngramCard({
    super.key,
    required this.dino,
    required this.onTap,
  });

  Color _getDietColor(DietType diet) {
    switch (diet) {
      case DietType.carnivore:
        return const Color(0xFFFF5252);
      case DietType.herbivore:
        return const Color(0xFF69F0AE);
      case DietType.piscivore:
        return const Color(0xFF40C4FF);
    }
  }

  Color _getTemperamentColor(TemperamentType temperament) {
    switch (temperament) {
      case TemperamentType.aggressive:
        return const Color(0xFFFF3D00);
      case TemperamentType.neutral:
        return const Color(0xFFFFD600);
      case TemperamentType.passive:
        return const Color(0xFF00E676);
    }
  }

  IconData _getHabitatIcon(HabitatType habitat) {
    switch (habitat) {
      case HabitatType.terrestrial:
        return Icons.landscape;
      case HabitatType.flying:
        return Icons.flight;
      case HabitatType.marine:
        return Icons.waves;
      case HabitatType.semiAquatic:
        return Icons.pool;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dietColor = _getDietColor(dino.diet);
    final temperamentColor = _getTemperamentColor(dino.temperament);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF071B2B).withOpacity(0.88),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF00E5FF).withOpacity(0.65),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00E5FF).withOpacity(0.12),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
          const BoxShadow(
            color: Color(0xFF000810),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: const Color(0xFF00E5FF).withOpacity(0.2),
          highlightColor: const Color(0xFF00E5FF).withOpacity(0.1),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Cryopod Preview Box
                CryopodAvatar(
                  dino: dino,
                  size: 76,
                  showBadge: true,
                ),

                const SizedBox(width: 14),

                // Dino Name & Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Ukrainian Name (Bold primary)
                      Text(
                        dino.nameUa,
                        style: const TextStyle(
                          color: Color(0xFFE1F5FE),
                          fontSize: 16.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                          shadows: [
                            Shadow(
                              color: Color(0xFF00E5FF),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 2),

                      // English Name (underneath, as requested)
                      Text(
                        dino.nameEn,
                        style: TextStyle(
                          color: const Color(0xFF80D8FF).withOpacity(0.85),
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 7),

                      // Badge Tags Row (Diet, Temperament, Habitat)
                      Wrap(
                        spacing: 5,
                        runSpacing: 4,
                        children: [
                          // Diet Badge
                          _buildMiniBadge(
                            label: dino.dietStringUa,
                            color: dietColor,
                          ),

                          // Temperament Badge
                          _buildMiniBadge(
                            label: dino.temperamentStringUa,
                            color: temperamentColor,
                          ),

                          // Habitat Badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFF003859).withOpacity(0.6),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: const Color(0xFF00B0FF).withOpacity(0.4),
                                width: 0.6,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _getHabitatIcon(dino.habitat),
                                  size: 11,
                                  color: const Color(0xFFB3E5FC),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  dino.habitatStringUa,
                                  style: const TextStyle(
                                    color: Color(0xFFB3E5FC),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 6),

                // Engram Arrow / Holographic Unlock glyph
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF002A44).withOpacity(0.6),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF00E5FF).withOpacity(0.4),
                      width: 0.8,
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: Color(0xFF00E5FF),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMiniBadge({required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.14),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: color.withOpacity(0.6),
          width: 0.7,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
