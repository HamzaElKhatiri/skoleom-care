import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/episode.dart';
import '../services/player_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/adaptive_shell.dart';
import '../widgets/category_pill.dart';
import '../widgets/episode_card.dart';
import '../widgets/page_background.dart';
import '../widgets/state_views.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  static const routeName = '/explore';

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String query = '';
  String category = 'Tout';

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlayerController>();
    final categories = ['Tout', ...controller.episodes.map((e) => e.category).toSet()];
    final filtered = controller.episodes.where(_matches).toList();

    return AdaptiveShell(
      currentIndex: 1,
      child: PageBackground(
        child: SafeArea(
          child: controller.isLoading
              ? const LoadingView()
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Explorer', style: Theme.of(context).textTheme.displayMedium),
                            const SizedBox(height: 10),
                            Text('Trouve la bonne energie: sommeil, focus, motivation, respiration.', style: Theme.of(context).textTheme.bodyLarge),
                            const SizedBox(height: 20),
                            TextField(
                              onChanged: (value) => setState(() => query = value),
                              decoration: InputDecoration(
                                hintText: 'Rechercher un podcast ou une meditation',
                                prefixIcon: const Icon(Icons.search_rounded),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.86),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: const BorderSide(color: AppTheme.blue, width: 1.4)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 58,
                        child: ListView.builder(
                          padding: const EdgeInsets.only(left: 20),
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          itemBuilder: (context, index) => CategoryPill(label: categories[index], selected: category == categories[index], onTap: () => setState(() => category = categories[index])),
                        ),
                      ),
                    ),
                    if (filtered.isEmpty)
                      const SliverFillRemaining(child: EmptyStateView(title: 'Aucun contenu trouve', subtitle: 'Essaie une autre recherche ou une autre categorie.'))
                    else
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 8),
                        sliver: SliverList.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) => EpisodeCard(episode: filtered[index]),
                        ),
                      ),
                    const SliverToBoxAdapter(child: SizedBox(height: 150)),
                  ],
                ),
        ),
      ),
    );
  }

  bool _matches(Episode episode) {
    final normalized = query.trim().toLowerCase();
    final inCategory = category == 'Tout' || episode.category == category;
    final inQuery = normalized.isEmpty || episode.title.toLowerCase().contains(normalized) || episode.show.toLowerCase().contains(normalized) || episode.description.toLowerCase().contains(normalized);
    return inCategory && inQuery;
  }
}
