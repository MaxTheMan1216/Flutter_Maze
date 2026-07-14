import 'package:flutter/material.dart';

import '../models/levels_data.dart';
import '../models/maze_level.dart';
import '../services/progress_service.dart';
import '../widgets/responsive.dart';
import 'game_screen.dart';

class LevelSelectScreen extends StatefulWidget {
  const LevelSelectScreen({super.key});

  @override
  State<LevelSelectScreen> createState() => _LevelSelectScreenState();
}

class _LevelSelectScreenState extends State<LevelSelectScreen> {
  final _progressService = ProgressService();
  Set<String> _completed = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final completed = await _progressService.loadCompletedLevelIds();
    if (!mounted) return;
    setState(() {
      _completed = completed;
      _loading = false;
    });
  }

  Future<void> _openLevel(MazeLevel level) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => GameScreen(level: level)),
    );
    // Refresh completion state in case the level was just finished.
    _loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileLayout(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Select a Level')),
      body: SafeArea(
        child: MaxWidthCenter(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : GridView.count(
                  crossAxisCount: mobile ? 1 : 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: mobile ? 3.4 : 2.6,
                  children: [
                    for (final level in kLevels)
                      _LevelCard(
                        level: level,
                        completed: _completed.contains(level.id),
                        onTap: () => _openLevel(level),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final MazeLevel level;
  final bool completed;
  final VoidCallback onTap;

  const _LevelCard({
    required this.level,
    required this.completed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1B2230),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      level.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      level.description,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                completed ? Icons.check_circle : Icons.chevron_right,
                color: completed
                    ? const Color(0xFF7CD992)
                    : Colors.white38,
                size: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
