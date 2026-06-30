import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class PageBackground extends StatelessWidget {
  const PageBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFBF4), Color(0xFFEAF3FF), Color(0xFFF3E8D5)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -120,
            right: -80,
            child: _Blob(size: 280, color: AppTheme.blue.withOpacity(0.18)),
          ),
          Positioned(
            top: 260,
            left: -100,
            child: _Blob(size: 240, color: AppTheme.beige.withOpacity(0.8)),
          ),
          child,
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color, boxShadow: [BoxShadow(color: color, blurRadius: 90, spreadRadius: 30)]),
    );
  }
}
