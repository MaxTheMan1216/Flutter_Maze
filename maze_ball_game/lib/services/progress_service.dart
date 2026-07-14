import 'package:shared_preferences/shared_preferences.dart';

/// Persists which levels the player has already completed so that
/// progress survives an application restart.
class ProgressService {
  static const _key = 'completed_level_ids';

  Future<Set<String>> loadCompletedLevelIds() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_key) ?? const []).toSet();
  }

  Future<void> markLevelCompleted(String levelId) async {
    final prefs = await SharedPreferences.getInstance();
    final completed = (prefs.getStringList(_key) ?? const []).toSet();
    completed.add(levelId);
    await prefs.setStringList(_key, completed.toList());
  }
}
