import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/player_controller.dart';
import '../widgets/adaptive_shell.dart';
import '../widgets/episode_card.dart';
import '../widgets/hero_panel.dart';
import '../widgets/page_background.dart';
import '../widgets/playlist_card.dart';
import '../widgets/section_header.dart';
import '../widgets/state_views.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlayerController>();
    return AdaptiveShell(
      currentIndex: 0,
      child: PageBackground(
        child: SafeArea(
          child: controller.isLoading
              ? const LoadingView()
              : controller.errorMessage != null
                  ? ErrorStateView(message: controller.errorMessage!, onRetry: controller.bootstrap)
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Bonjour', style: Theme.of(context).textTheme.bodyMedium),
                                      Text('Skoleom Care', style: Theme.of(context).textTheme.headlineSmall),
                                    ],
                                  ),
                                ),
                                CircleAvatar(backgroundColor: Colors.white, child: IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none_rounded))),
                              ],
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: HeroPanel()),
                        const SliverToBoxAdapter(child: SectionHeader(title: 'Collections signature', actionLabel: 'Voir tout')),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 238,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.playlists.length,
                              itemBuilder: (context, index) => PlaylistCard(playlist: controller.playlists[index]),
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SectionHeader(title: 'A ecouter maintenant')),
                        SliverList.builder(
                          itemCount: controller.episodes.length,
                          itemBuilder: (context, index) => EpisodeCard(episode: controller.episodes[index]),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 150)),
                      ],
                    ),
        ),
      ),
    );
  }
}
