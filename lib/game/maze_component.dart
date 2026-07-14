import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../models/maze_level.dart';

/// Renders the maze grid (walls, floor, exit, hazards) and answers
/// simple tile queries used by [BallComponent] for collision and for
/// detecting when the ball has reached the exit or a hazard tile.
class MazeComponent extends PositionComponent {
  final MazeLevel level;
  final double cellSize;

  MazeComponent({required this.level, required this.cellSize});

  final _wallPaint = Paint()..color = const Color(0xFF3A4A63);
  final _floorPaint = Paint()..color = const Color(0xFF161B22);
  final _exitPaint = Paint()..color = const Color(0xFFFFC857);
  final _hazardPaint = Paint()..color = const Color(0xFFE05555);

  @override
  void render(Canvas canvas) {
    for (var row = 0; row < level.rows; row++) {
      for (var col = 0; col < level.cols; col++) {
        final rect = Rect.fromLTWH(
          col * cellSize,
          row * cellSize,
          cellSize,
          cellSize,
        );
        switch (level.cellAt(row, col)) {
          case '#':
            canvas.drawRect(rect, _wallPaint);
            break;
          case 'E':
            canvas.drawRect(rect, _floorPaint);
            canvas.drawRect(rect.deflate(cellSize * 0.15), _exitPaint);
            break;
          case 'H':
            canvas.drawRect(rect, _floorPaint);
            canvas.drawRect(rect.deflate(cellSize * 0.15), _hazardPaint);
            break;
          default:
            canvas.drawRect(rect, _floorPaint);
        }
      }
    }
  }

  bool isWallAtPoint(Vector2 point) {
    final col = (point.x / cellSize).floor();
    final row = (point.y / cellSize).floor();
    return level.cellAt(row, col) == '#';
  }

  String tileTypeAtPoint(Vector2 point) {
    final col = (point.x / cellSize).floor();
    final row = (point.y / cellSize).floor();
    return level.cellAt(row, col);
  }
}
