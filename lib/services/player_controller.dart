import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/episode.dart';
import '../models/playlist.dart';
import 'content_service.dart';

class PlayerController extends ChangeNotifier {
  final ContentService _contentService = ContentService();
  Timer? _timer;

  bool isLoading = true;
  String? errorMessage;
  List<Episode> episodes = const [];
  List<CarePlaylist> playlists = const [];
  Episode? currentEpisode;
  bool isPlaying = false;
  double progress = 0.18;

  Future<void> bootstrap() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();
      final results = await Future.wait([
        _contentService.fetchEpisodes(),
        _contentService.fetchPlaylists(),
      ]);
      episodes = results[0] as List<Episode>;
      playlists = results[1] as List<CarePlaylist>;
      currentEpisode = episodes.first;
    } catch (_) {
      errorMessage = 'Impossible de charger les contenus Skoleom Care.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void play(Episode episode) {
    currentEpisode = episode;
    isPlaying = true;
    progress = progress.clamp(0.02, 0.96);
    _startTicker();
    notifyListeners();
  }

  void toggle() {
    if (currentEpisode == null && episodes.isNotEmpty) {
      currentEpisode = episodes.first;
    }
    isPlaying = !isPlaying;
    if (isPlaying) {
      _startTicker();
    } else {
      _timer?.cancel();
    }
    notifyListeners();
  }

  void seek(double value) {
    progress = value.clamp(0, 1);
    notifyListeners();
  }

  void next() {
    if (episodes.isEmpty) return;
    final current = currentEpisode;
    final index = current == null ? 0 : episodes.indexWhere((item) => item.id == current.id);
    final nextIndex = index < 0 ? 0 : (index + 1) % episodes.length;
    play(episodes[nextIndex]);
  }

  void previous() {
    if (episodes.isEmpty) return;
    final current = currentEpisode;
    final index = current == null ? 0 : episodes.indexWhere((item) => item.id == current.id);
    final previousIndex = index <= 0 ? episodes.length - 1 : index - 1;
    play(episodes[previousIndex]);
  }

  void _startTicker() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isPlaying) return;
      progress += 0.006;
      if (progress >= 1) {
        progress = 0;
        next();
      } else {
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
