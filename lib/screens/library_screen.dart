import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/player_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/adaptive_shell.dart';
import '../widgets/episode_card.dart';
import '../widgets/page_background.dart';
import '../widgets/section_header.dart';
import '../widgets/state_views.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  static const routeName = '/library';

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlayerController>();
    final saved = controller.episodes.where((episode) => !episode.isPremium).toList();

    return AdaptiveShell(
      currentIndex: 2,
      child: PageBackground(
        child: SafeArea(
          child: controller.isLoading
              ? const LoadingView()
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.82), borderRadius: BorderRadius.circular(34), border: Border.all(color: AppTheme.line)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Library', style: Theme.of(context).textTheme.displayMedium),
                              const SizedBox(height: 10),
                              Text('Tes contenus sauvegardes, progressions et routines recommandees.', style: Theme.of(context).textTheme.bodyLarge),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  _Stat(label: 'Ecoutes', value: '${controller.episodes.length * 7}'),
                                  const SizedBox(width: 12),
                                  _Stat(label: 'Minutes', value: '184'),
                                  const SizedBox(width: 12),
                                  _Stat(label: 'Streak', value: '9j'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SectionHeader(title: 'Sauvegardes')),
                    if (saved.isEmpty)
                      const SliverFillRemaining(child: EmptyStateView(title: 'Bibliotheque vide', subtitle: 'Lance un episode pour commencer ta selection.'))
                    else
                      SliverList.builder(
                        itemCount: saved.length,
                        itemBuilder: (context, index) => EpisodeCard(episode: saved[index]),
                      ),
                    const SliverToBoxAdapter(child: SizedBox(height: 150)),
                  ],
                ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: AppTheme.sky.withOpacity(0.65), borderRadius: BorderRadius.circular(22)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.blue)),
            const SizedBox(height: 2),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
