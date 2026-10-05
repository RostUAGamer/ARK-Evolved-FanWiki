import 'package:flutter/material.dart';
import '../models/dinosaur.dart';

class CryopodAvatar extends StatelessWidget {
  final Dinosaur dino;
  final double size;
  final bool showBadge;

  const CryopodAvatar({
    super.key,
    required this.dino,
    this.size = 72,
    this.showBadge = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF04131F),
        borderRadius: BorderRadius.circular(size * 0.12),
        border: Border.all(
          color: const Color(0xFF00E5FF).withOpacity(0.85),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00E5FF).withOpacity(0.35),
            blurRadius: 8,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: const Color(0xFF002244).withOpacity(0.6),
            blurRadius: 4,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size * 0.10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Holographic Radial Background
            Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.85,
                  colors: [
                    Color(0xFF0C3852),
                    Color(0xFF062031),
                    Color(0xFF020B13),
                  ],
                ),
              ),
            ),

            // Cryo grid scanlines
            CustomPaint(
              size: Size(size, size),
              painter: _CryoScanlinePainter(),
            ),

            // Creature Image
            Padding(
              padding: EdgeInsets.all(size * 0.08),
              child: Image.network(
                dino.imageUrl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Center(
                    child: SizedBox(
                      width: size * 0.35,
                      height: size * 0.35,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00E5FF)),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to secondary image or holographic icon
                  return Image.network(
                    dino.backupImageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error2, stackTrace2) {
                      return _buildCryoIconFallback();
                    },
                  );
                },
              ),
            ),

            // Holographic Frost Ring (Cryopod effect)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size * 0.10),
                border: Border.all(
                  color: Colors.white.withOpacity(0.12),
                  width: 1.0,
                ),
              ),
            ),

            // Top-left Cryo freeze corner marker
            Positioned(
              top: 2,
              left: 2,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFF00E5FF),
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Cryo Pod Tag
            if (showBadge && size >= 60)
              Positioned(
                bottom: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: const Color(0xFF001F33).withOpacity(0.85),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: const Color(0xFF00E5FF).withOpacity(0.5),
                      width: 0.5,
                    ),
                  ),
                  child: Text(
                    'CRYO',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: size * 0.11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      color: const Color(0xFF80D8FF),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCryoIconFallback() {
    IconData icon;
    switch (dino.habitat) {
      case HabitatType.flying:
        icon = Icons.air;
        break;
      case HabitatType.marine:
        icon = Icons.water;
        break;
      case HabitatType.semiAquatic:
        icon = Icons.waves;
        break;
      case HabitatType.terrestrial:
        icon = Icons.pets;
        break;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: size * 0.45,
          color: const Color(0xFF00E5FF).withOpacity(0.85),
        ),
        Text(
          dino.nameEn.split(' ').first,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: const Color(0xFF80D8FF),
            fontSize: size * 0.12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _CryoScanlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00E5FF).withOpacity(0.06)
      ..strokeWidth = 1.0;

    for (double y = 4; y < size.height; y += 6) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
