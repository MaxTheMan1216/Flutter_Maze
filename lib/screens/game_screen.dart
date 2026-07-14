import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../game/maze_game.dart';
import '../models/maze_level.dart';
import '../services/progress_service.dart';
import 'result_screen.dart';

class GameScreen extends StatefulWidget {
  final MazeLevel level;

  const GameScreen({super.key, required this.level});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late MazeGame _game;
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    _game = MazeGame(level: widget.level, onWin: _onWin);
  }

  Future<void> _onWin(double elapsedSeconds) async {
    if (_finished) return;
    _finished = true;
    await ProgressService().markLevelCompleted(widget.level.id);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          level: widget.level,
          elapsedSeconds: elapsedSeconds,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(child: GameWidget(game: _game)),
            Positioned(
              top: 8,
              left: 8,
              child: _HudButton(
                icon: Icons.arrow_back,
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: _HudButton(
                icon: Icons.refresh,
                onTap: () {
                  setState(() {
                    _finished = false;
                    _game = MazeGame(level: widget.level, onWin: _onWin);
                  });
                },
              ),
            ),
            Positioned(
              top: 12,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.level.title,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HudButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HudButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black45,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}
