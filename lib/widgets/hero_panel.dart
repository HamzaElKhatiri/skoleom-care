import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/player_controller.dart';
import '../theme/app_theme.dart';

class HeroPanel extends StatelessWidget {
  const HeroPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlayerController>();
    final featured = controller.episodes.isEmpty ? null : controller.episodes.first;
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppTheme.navy, AppTheme.blue]),
        boxShadow: [BoxShadow(color: AppTheme.blue.withOpacity(0.24), blurRadius: 40, offset: const Offset(0, 22))],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth > 720;
          return Flex(
            direction: wide ? Axis.horizontal : Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: wide ? 6 : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.14), borderRadius: BorderRadius.circular(999)),
                      child: const Text('SKOLEOM CARE • AUDIO WELLNESS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 11, letterSpacing: 1.1)),
                    ),
                    const SizedBox(height: 22),
                    Text('Respire. Ecoute. Reviens a toi.', style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white)),
                    const SizedBox(height: 14),
                    Text('Podcasts, meditations et musiques mentales avec une experience fluide, premium et immersive.', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white.withOpacity(0.78))),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: featured == null ? null : () => controller.play(featured),
                          icon: const Icon(Icons.play_arrow_rounded),
                          label: const Text('Lancer'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.ink),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton.icon(
                          onPressed: () => Navigator.of(context).pushNamed('/explore'),
                          icon: const Icon(Icons.auto_awesome_rounded),
                          label: const Text('Explorer'),
                          style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: BorderSide(color: Colors.white.withOpacity(0.28)), padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (wide) const SizedBox(width: 28) else const SizedBox(height: 24),
              Expanded(
                flex: wide ? 4 : 0,
                child: AspectRatio(
                  aspectRatio: wide ? 1 : 1.6,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), borderRadius: BorderRadius.circular(34), border: Border.all(color: Colors.white.withOpacity(0.18))),
                    child: Stack(
                      children: [
                        Positioned.fill(child: CustomPaint(painter: _WavePainter())),
                        const Center(child: Icon(Icons.spa_rounded, size: 78, color: Colors.white)),
                        Positioned(left: 18, right: 18, bottom: 18, child: Text(featured?.title ?? 'Chargement', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800))),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 2..color = Colors.white.withOpacity(0.22);
    for (var i = 0; i < 8; i++) {
      final path = Path();
      final y = size.height * (0.25 + i * 0.07);
      path.moveTo(0, y);
      path.cubicTo(size.width * 0.25, y - 28, size.width * 0.55, y + 28, size.width, y - 8);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
