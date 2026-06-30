import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/explore_screen.dart';
import 'screens/home_screen.dart';
import 'screens/library_screen.dart';
import 'screens/player_screen.dart';
import 'services/player_controller.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SkoleomCareApp());
}

class SkoleomCareApp extends StatelessWidget {
  const SkoleomCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlayerController()..bootstrap(),
      child: MaterialApp(
        title: 'Skoleom Care',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (_) => const HomeScreen(),
          ExploreScreen.routeName: (_) => const ExploreScreen(),
          LibraryScreen.routeName: (_) => const LibraryScreen(),
          PlayerScreen.routeName: (_) => const PlayerScreen(),
        },
      ),
    );
  }
}
