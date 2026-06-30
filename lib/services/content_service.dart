import 'package:flutter/material.dart';

import '../models/episode.dart';
import '../models/playlist.dart';
import '../theme/app_theme.dart';

class ContentService {
  Future<List<Episode>> fetchEpisodes() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return const [
      Episode(
        id: 'breath-reset',
        title: 'Reset mental en 7 minutes',
        show: 'Skoleom Daily Care',
        description: 'Un format court pour relacher la pression, poser la respiration et reprendre le controle de ta journee.',
        category: 'Respiration',
        duration: Duration(minutes: 7, seconds: 12),
        color: AppTheme.navy,
        accent: AppTheme.blue,
        isPremium: false,
      ),
      Episode(
        id: 'deep-focus',
        title: 'Focus profond sans tension',
        show: 'Work Flow',
        description: 'Ambiance bleue, nappes douces et impulsions calmes pour entrer dans une session de travail claire.',
        category: 'Focus',
        duration: Duration(minutes: 24, seconds: 40),
        color: Color(0xFF0A2B61),
        accent: Color(0xFF8BB9FF),
        isPremium: true,
      ),
      Episode(
        id: 'sleep-coast',
        title: 'Sommeil cote bleue',
        show: 'Night Care',
        description: 'Une descente progressive inspiree du bruit des vagues, pensee pour couper les pensees en boucle.',
        category: 'Sommeil',
        duration: Duration(minutes: 38, seconds: 5),
        color: Color(0xFF13213A),
        accent: AppTheme.beige,
        isPremium: false,
      ),
      Episode(
        id: 'confidence-run',
        title: 'Marche de confiance',
        show: 'Move Mind',
        description: 'Comme une campagne Nike minimaliste: voix directe, rythme lent, energie propre et posture haute.',
        category: 'Motivation',
        duration: Duration(minutes: 16, seconds: 20),
        color: Color(0xFF061224),
        accent: Color(0xFFFFD89A),
        isPremium: true,
      ),
      Episode(
        id: 'morning-light',
        title: 'Lumiere du matin',
        show: 'Soft Start',
        description: 'Meditation guidee beige et blanche pour commencer sans bruit mental, avec une intention nette.',
        category: 'Matin',
        duration: Duration(minutes: 11, seconds: 45),
        color: Color(0xFFE8D8BD),
        accent: AppTheme.blue,
        isPremium: false,
      ),
    ];
  }

  Future<List<CarePlaylist>> fetchPlaylists() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const [
      CarePlaylist(
        id: 'blue-room',
        title: 'Blue Room',
        subtitle: 'Meditations calmes, sons profonds, respiration lente.',
        mood: 'Calme',
        minutes: 52,
        gradient: [Color(0xFF071B3A), Color(0xFF0A66FF)],
      ),
      CarePlaylist(
        id: 'beige-mind',
        title: 'Beige Mind',
        subtitle: 'Voix chaudes, textures solaires, retour au corps.',
        mood: 'Ancrage',
        minutes: 36,
        gradient: [Color(0xFFF3E8D5), Color(0xFFFFFBF4)],
      ),
      CarePlaylist(
        id: 'night-drop',
        title: 'Night Drop',
        subtitle: 'Selection nocturne style Netflix, immersive et douce.',
        mood: 'Sommeil',
        minutes: 75,
        gradient: [Color(0xFF030712), Color(0xFF173D78)],
      ),
    ];
  }
}
