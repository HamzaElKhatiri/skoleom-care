import 'package:flutter/material.dart';

class CarePlaylist {
  const CarePlaylist({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.mood,
    required this.minutes,
    required this.gradient,
  });

  final String id;
  final String title;
  final String subtitle;
  final String mood;
  final int minutes;
  final List<Color> gradient;
}
