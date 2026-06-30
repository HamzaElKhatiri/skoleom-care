import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/player_controller.dart';
import '../theme/app_theme.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  static const routeName = '/player';

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlayerController>();
    final episode = controller.currentEpisode;
    if (episode == null) {
      return Scaffold(
        backgroundColor: AppTheme.cream,
        appBar: AppBar(),
        body: const Center(child: Text('Aucun episode en cours')),
      );
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [episode.color, AppTheme.ink, episode.accent])),
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 34)),
                        const Spacer(),
                        const Text('NOW PLAYING', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
                        const Spacer(),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded, color: Colors.white)),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 430),
                      aspectRatio: 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.white.withOpacity(0.24), Colors.white.withOpacity(0.05)]),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.22), blurRadius: 60, offset: const Offset(0, 34))],
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(child: CustomPaint(painter: _OrbPainter(progress: controller.progress))),
                          const Center(child: Icon(Icons.spa_rounded, color: Colors.white, size: 96)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(episode.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.white)),
                    const SizedBox(height: 8),
                    Text(episode.show, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 26),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(trackHeight: 5, thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7), overlayShape: const RoundSliderOverlayShape(overlayRadius: 16), activeTrackColor: AppTheme.beige, inactiveTrackColor: Colors.white24, thumbColor: Colors.white),
                      child: Slider(value: controller.progress, onChanged: controller.seek),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        children: [
                          Text(_time(controller.progress, episode.duration), style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700)),
                          const Spacer(),
                          Text(episode.formattedDuration, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: controller.previous, icon: const Icon(Icons.skip_previous_rounded, color: Colors.white, size: 42)),
                        const SizedBox(width: 18),
                        FilledButton(
                          onPressed: controller.toggle,
                          style: FilledButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.ink, fixedSize: const Size(82, 82), shape: const CircleBorder()),
                          child: Icon(controller.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, size: 42),
                        ),
                        const SizedBox(width: 18),
                        IconButton(onPressed: controller.next, icon: const Icon(Icons.skip_next_rounded, color: Colors.white, size: 42)),
                      ],
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _time(double progress, Duration duration) {
    final seconds = (duration.inSeconds * progress).round();
    final minutes = seconds ~/ 60;
    final rest = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$rest';
  }
}

class _OrbPainter extends CustomPainter {
  const _OrbPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final base = Paint()..style = PaintingStyle.stroke..strokeWidth = 2..color = Colors.white.withOpacity(0.16);
    for (var i = 1; i <= 7; i++) {
      canvas.drawCircle(center, size.width * (0.08 + i * 0.058), base);
    }
    final active = Paint()..style = PaintingStyle.stroke..strokeWidth = 7..strokeCap = StrokeCap.round..color = Colors.white.withOpacity(0.8);
    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width * 0.39), -1.57, progress * 6.28, false, active);
  }

  @override
  bool shouldRepaint(covariant _OrbPainter oldDelegate) => oldDelegate.progress != progress;
}
