import 'package:flutter/material.dart';

import '../models/levels_data.dart';
import '../models/maze_level.dart';
import '../widgets/responsive.dart';
import 'game_screen.dart';
import 'level_select_screen.dart';

class ResultScreen extends StatelessWidget {
  final MazeLevel level;
  final double elapsedSeconds;

  const ResultScreen({
    super.key,
    required this.level,
    required this.elapsedSeconds,
  });

  MazeLevel? get _nextLevel {
    final index = kLevels.indexWhere((l) => l.id == level.id);
    if (index == -1 || index + 1 >= kLevels.length) return null;
    return kLevels[index + 1];
  }

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileLayout(context);
    final next = _nextLevel;

    return Scaffold(
      body: SafeArea(
        child: MaxWidthCenter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.emoji_events,
                color: Color(0xFFFFC857),
                size: 72,
              ),
              const SizedBox(height: 20),
              Text(
                'Level Complete!',
                style: TextStyle(
                  fontSize: mobile ? 28 : 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                level.title,
                style: const TextStyle(fontSize: 18, color: Colors.white70),
              ),
              const SizedBox(height: 4),
              Text(
                'Time: ${elapsedSeconds.toStringAsFixed(1)}s',
                style: const TextStyle(fontSize: 16, color: Colors.white54),
              ),
              const SizedBox(height: 40),
              if (next != null)
                _ResultButton(
                  label: 'Next Level',
                  filled: true,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => GameScreen(level: next),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 12),
              _ResultButton(
                label: 'Retry Level',
                filled: false,
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => GameScreen(level: level),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              _ResultButton(
                label: 'Level Select',
                filled: false,
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const LevelSelectScreen(),
                    ),
                    (route) => route.isFirst,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultButton extends StatelessWidget {
  final String label;
  final bool filled;
  final VoidCallback onTap;

  const _ResultButton({
    required this.label,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 52,
      child: filled
          ? ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4FC3F7),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white38),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(label, style: const TextStyle(fontSize: 16)),
            ),
    );
  }
}
