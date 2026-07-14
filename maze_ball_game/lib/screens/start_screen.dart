import 'package:flutter/material.dart';

import '../widgets/responsive.dart';
import 'level_select_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = isMobileLayout(context);

    return Scaffold(
      body: SafeArea(
        child: MaxWidthCenter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                size: mobile ? 64 : 84,
                color: const Color(0xFF4FC3F7),
              ),
              const SizedBox(height: 24),
              Text(
                'Maze Roller',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: mobile ? 34 : 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Steer the ball through each maze with the on-screen '
                'joystick and reach the glowing exit. Avoid hazard tiles '
                'along the way — three levels, each trickier than the last.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: mobile ? 15 : 17,
                  color: Colors.white70,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: mobile ? double.infinity : 260,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LevelSelectScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4FC3F7),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Play',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
