import 'package:flutter/material.dart';

import '../models/playlist.dart';
import '../theme/app_theme.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({super.key, required this.playlist});

  final CarePlaylist playlist;

  @override
  Widget build(BuildContext context) {
    final darkText = playlist.gradient.first.computeLuminance() > 0.55;
    final textColor = darkText ? AppTheme.ink : Colors.white;
    return Container(
      width: 252,
      margin: const EdgeInsets.only(left: 20, right: 2),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: playlist.gradient),
        boxShadow: [BoxShadow(color: playlist.gradient.last.withOpacity(0.22), blurRadius: 26, offset: const Offset(0, 16))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 46, height: 46, decoration: BoxDecoration(color: Colors.white.withOpacity(0.18), borderRadius: BorderRadius.circular(17)), child: Icon(Icons.self_improvement_rounded, color: textColor)),
              const Spacer(),
              Text('${playlist.minutes} min', style: TextStyle(color: textColor.withOpacity(0.72), fontWeight: FontWeight.w800, fontSize: 12)),
            ],
          ),
          const Spacer(),
          Text(playlist.mood.toUpperCase(), style: TextStyle(color: textColor.withOpacity(0.62), fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 1.2)),
          const SizedBox(height: 8),
          Text(playlist.title, style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: textColor)),
          const SizedBox(height: 8),
          Text(playlist.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: textColor.withOpacity(0.76), fontWeight: FontWeight.w600, height: 1.35)),
        ],
      ),
    );
  }
}
