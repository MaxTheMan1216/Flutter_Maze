import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../models/maze_level.dart';
import 'ball_component.dart';
import 'maze_component.dart';

/// The Flame game for a single maze level.
///
/// Uses [CameraComponent.withFixedResolution] so the whole maze is
/// always scaled to fit the available screen space, regardless of the
/// device's actual resolution. The player steers the ball with an
/// on-screen joystick, which works with touch, mouse or stylus input.
class MazeGame extends FlameGame {
  static const double cellSize = 32;
  static const double _speed = cellSize * 3.4;

  final MazeLevel level;
  final void Function(double elapsedSeconds) onWin;

  MazeGame({required this.level, required this.onWin})
      : super(
          camera: CameraComponent.withFixedResolution(
            width: level.cols * cellSize,
            height: level.rows * cellSize,
          ),
        );

  late final BallComponent ball;
  late final Vector2 _startPosition;
  double _elapsed = 0;
  bool _won = false;

  @override
  Color backgroundColor() => const Color(0xFF0D1117);

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.topLeft;

    final maze = MazeComponent(level: level, cellSize: cellSize);
    world.add(maze);

    _startPosition = Vector2(
      (level.startCol + 0.5) * cellSize,
      (level.startRow + 0.5) * cellSize,
    );

    ball = BallComponent(
      maze: maze,
      startPosition: _startPosition,
      speed: _speed,
      onReachExit: _handleWin,
      onHitHazard: () => ball.resetTo(_startPosition),
    );
    world.add(ball);

    final joystick = JoystickComponent(
      knob: CircleComponent(
        radius: 16,
        paint: Paint()..color = const Color(0xCCFFFFFF),
      ),
      background: CircleComponent(
        radius: 42,
        paint: Paint()..color = const Color(0x55FFFFFF),
      ),
      margin: const EdgeInsets.only(left: 20, bottom: 20),
    );
    camera.viewport.add(joystick);
    _joystick = joystick;
  }

  late final JoystickComponent _joystick;

  @override
  void update(double dt) {
    super.update(dt);
    if (!_won) {
      _elapsed += dt;
      ball.velocityDirection = _joystick.relativeDelta;
    }
  }

  void _handleWin() {
    if (_won) return;
    _won = true;
    onWin(_elapsed);
  }
}
