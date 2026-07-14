/// A single maze level, described as a rectangular grid of characters.
///
/// Legend: '#' wall, '.' open floor, 'S' start tile, 'E' exit tile,
/// 'H' hazard tile (touching it sends the ball back to the start).
class MazeLevel {
  final String id;
  final String title;
  final String description;
  final List<String> grid;

  const MazeLevel({
    required this.id,
    required this.title,
    required this.description,
    required this.grid,
  });

  int get cols => grid.first.length;
  int get rows => grid.length;

  int get startCol => _findCol('S');
  int get startRow => _findRow('S');

  int _findRow(String char) {
    for (var r = 0; r < grid.length; r++) {
      if (grid[r].contains(char)) return r;
    }
    throw StateError('Level $id has no "$char" tile');
  }

  int _findCol(String char) {
    for (final row in grid) {
      final c = row.indexOf('S');
      if (c != -1) return c;
    }
    throw StateError('Level $id has no start tile');
  }

  /// Cell content at [row], [col]. Out-of-bounds is treated as a wall.
  String cellAt(int row, int col) {
    if (row < 0 || row >= rows || col < 0 || col >= cols) return '#';
    return grid[row][col];
  }
}
