import 'package:flutter/material.dart';

class Episode {
  const Episode({
    required this.id,
    required this.title,
    required this.show,
    required this.description,
    required this.category,
    required this.duration,
    required this.color,
    required this.accent,
    required this.isPremium,
  });

  final String id;
  final String title;
  final String show;
  final String description;
  final String category;
  final Duration duration;
  final Color color;
  final Color accent;
  final bool isPremium;

  String get formattedDuration {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
