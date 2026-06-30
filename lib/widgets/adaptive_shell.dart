import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/explore_screen.dart';
import '../screens/home_screen.dart';
import '../screens/library_screen.dart';
import '../services/player_controller.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'mini_player.dart';

class AdaptiveShell extends StatelessWidget {
  const AdaptiveShell({super.key, required this.currentIndex, required this.child});

  final int currentIndex;
  final Widget child;

  void _go(BuildContext context, int index) {
    final routes = [HomeScreen.routeName, ExploreScreen.routeName, LibraryScreen.routeName];
    if (index != currentIndex) Navigator.of(context).pushReplacementNamed(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    final mobile = Responsive.isMobile(context);
    final controller = context.watch<PlayerController>();
    final body = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: Responsive.maxContentWidth(context)),
        child: child,
      ),
    );

    if (!mobile) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) => _go(context, index),
              backgroundColor: Colors.white.withOpacity(0.72),
              indicatorColor: AppTheme.sky,
              minWidth: 92,
              labelType: NavigationRailLabelType.all,
              leading: Padding(
                padding: const EdgeInsets.only(top: 22, bottom: 28),
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(color: AppTheme.ink, borderRadius: BorderRadius.circular(18)),
                  child: const Icon(Icons.spa_rounded, color: Colors.white),
                ),
              ),
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: Text('Accueil')),
                NavigationRailDestination(icon: Icon(Icons.travel_explore_outlined), selectedIcon: Icon(Icons.travel_explore_rounded), label: Text('Explorer')),
                NavigationRailDestination(icon: Icon(Icons.bookmark_border_rounded), selectedIcon: Icon(Icons.bookmark_rounded), label: Text('Library')),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  body,
                  if (controller.currentEpisode != null)
                    Positioned(left: 24, right: 24, bottom: 24, child: MiniPlayer(large: true)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          body,
          if (controller.currentEpisode != null)
            const Positioned(left: 14, right: 14, bottom: 92, child: MiniPlayer()),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => _go(context, index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Accueil'),
          NavigationDestination(icon: Icon(Icons.travel_explore_outlined), selectedIcon: Icon(Icons.travel_explore_rounded), label: 'Explorer'),
          NavigationDestination(icon: Icon(Icons.bookmark_border_rounded), selectedIcon: Icon(Icons.bookmark_rounded), label: 'Library'),
        ],
      ),
    );
  }
}
