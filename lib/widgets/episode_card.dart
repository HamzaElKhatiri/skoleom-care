import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/episode.dart';
import '../services/player_controller.dart';
import '../theme/app_theme.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({super.key, required this.episode, this.compact = false});

  final Episode episode;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlayerController>();
    final active = controller.currentEpisode?.id == episode.id;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      margin: EdgeInsets.symmetric(horizontal: compact ? 0 : 20, vertical: 7),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(active ? 0.98 : 0.82),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: active ? AppTheme.blue.withOpacity(0.35) : AppTheme.line),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(active ? 0.08 : 0.035), blurRadius: active ? 24 : 16, offset: const Offset(0, 10))],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => controller.play(episode),
        child: Row(
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [episode.color, episode.accent]),
              ),
              child: Icon(active && controller.isPlaying ? Icons.graphic_eq_rounded : Icons.play_arrow_rounded, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(child: Text(episode.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium)),
                      if (episode.isPremium) ...[
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: AppTheme.ink, borderRadius: BorderRadius.circular(999)), child: const Text('PLUS', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900))),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('${episode.show} • ${episode.category}', maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text(episode.formattedDuration, style: const TextStyle(color: AppTheme.blue, fontWeight: FontWeight.w800, fontSize: 12)),
                ],
              ),
            ),
            IconButton(
              onPressed: () => controller.play(episode),
              icon: Icon(active && controller.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded, color: AppTheme.ink, size: 34),
            ),
          ],
        ),
      ),
    );
  }
}
