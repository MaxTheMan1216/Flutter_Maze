import 'package:flutter/material.dart';

import 'screens/start_screen.dart';

void main() {
  runApp(const MazeRollerApp());
}

class MazeRollerApp extends StatelessWidget {
  const MazeRollerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maze Roller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4FC3F7),
          brightness: Brightness.dark,
        ),
      ),
      home: const StartScreen(),
    );
  }
}
