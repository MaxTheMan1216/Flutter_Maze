import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'maze_component.dart';

/// The player-controlled ball. Movement is driven every tick by a
/// velocity set from outside (the on-screen joystick); collision
/// against the maze walls is resolved with simple axis-separated
/// tile checks, which lets the ball slide smoothly along walls.
class BallComponent extends PositionComponent {
  final MazeComponent maze;
  final double speed;
  final void Function() onReachExit;
  final void Function() onHitHazard;

  Vector2 velocityDirection = Vector2.zero();
  bool _locked = false;

  BallComponent({
    required this.maze,
    required Vector2 startPosition,
    required this.speed,
    required this.onReachExit,
    required this.onHitHazard,
  }) : super(
          position: startPosition,
          size: Vector2.all(maze.cellSize * 0.6),
          anchor: Anchor.center,
        );

  final _paint = Paint()..color = const Color(0xFF4FC3F7);

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      _paint,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_locked || velocityDirection.isZero()) return;

    final delta = velocityDirection.normalized() * speed * dt;
    final half = size.x / 2;

    final newX = position.x + delta.x;
    if (!_collidesAt(newX, position.y, half)) {
      position.x = newX;
    }
    final newY = position.y + delta.y;
    if (!_collidesAt(position.x, newY, half)) {
      position.y = newY;
    }

    final tile = maze.tileTypeAtPoint(position);
    if (tile == 'E') {
      _locked = true;
      onReachExit();
    } else if (tile == 'H') {
      onHitHazard();
    }
  }

  bool _collidesAt(double cx, double cy, double half) {
    return maze.isWallAtPoint(Vector2(cx - half, cy - half)) ||
        maze.isWallAtPoint(Vector2(cx + half, cy - half)) ||
        maze.isWallAtPoint(Vector2(cx - half, cy + half)) ||
        maze.isWallAtPoint(Vector2(cx + half, cy + half));
  }

  void resetTo(Vector2 startPosition) {
    position = startPosition.clone();
  }
}
