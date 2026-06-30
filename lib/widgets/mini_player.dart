import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/player_screen.dart';
import '../services/player_controller.dart';
import '../theme/app_theme.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key, this.large = false});

  final bool large;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlayerController>();
    final episode = controller.currentEpisode;
    if (episode == null) return const SizedBox.shrink();
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(PlayerScreen.routeName),
      child: Container(
        padding: EdgeInsets.all(large ? 16 : 12),
        decoration: BoxDecoration(
          color: AppTheme.ink.withOpacity(0.96),
          borderRadius: BorderRadius.circular(large ? 30 : 26),
          boxShadow: [BoxShadow(color: AppTheme.ink.withOpacity(0.25), blurRadius: 32, offset: const Offset(0, 18))],
        ),
        child: Row(
          children: [
            Container(width: 50, height: 50, decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), gradient: LinearGradient(colors: [episode.color, episode.accent])), child: const Icon(Icons.spa_rounded, color: Colors.white)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(episode.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 4),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(value: controller.progress, minHeight: 4, backgroundColor: Colors.white.withOpacity(0.14), valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.beige)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: controller.toggle,
              icon: Icon(controller.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
