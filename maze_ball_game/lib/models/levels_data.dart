import 'maze_level.dart';

/// The fixed set of levels the player can play, ordered from easiest
/// to hardest. Each level is a distinct hand-picked maze layout; level
/// three additionally introduces hazard tiles ('H') that are not
/// present in the earlier, gentler levels.
const List<MazeLevel> kLevels = [
  MazeLevel(
    id: 'level_1',
    title: '1. First Steps',
    description: 'A small maze to get used to the controls.',
    grid: [
      '#############',
      '#S#.....#...#',
      '#.#####.#.#.#',
      '#.#...#...#.#',
      '#.#.#.#.###.#',
      '#...#.....#.#',
      '#########.#.#',
      '#.#.....#.#.#',
      '#.#.#.###.#.#',
      '#...#......E#',
      '#############',
    ],
  ),
  MazeLevel(
    id: 'level_2',
    title: '2. Twists and Turns',
    description: 'A bigger maze with a lot more branching paths.',
    grid: [
      '###################',
      '#S..#.......#.....#',
      '###.#.#.###.#.#.#.#',
      '#...#.#.#.#.#.....#',
      '#.###.#.#.#.#.###.#',
      '#.#...#.#.#.#.#...#',
      '#.#.###.#.#.###.#.#',
      '#.#.#...#.#...#.#.#',
      '#.###.###.###.#.#.#',
      '#.....#.....#.#.#.#',
      '#######.###.#.#.#.#',
      '#.....#.#.#.....#.#',
      '#.#.###.#.#.#####.#',
      '#.#.......#......E#',
      '###################',
    ],
  ),
  MazeLevel(
    id: 'level_3',
    title: '3. Hazard Run',
    description: 'The largest maze. Avoid the red hazard tiles, or '
        "you'll be sent back to the start!",
    grid: [
      '#######################',
      '#SH...#...#...........#',
      '#.#.#.#.#.#.#########.#',
      '#.#.#.#.#.#...#.....#.#',
      '#.#.#.#.#.###.#.###.#.#',
      '#...#...#.#...#...#...#',
      '#########.#.#####.#####',
      '#.......#...#...#.....#',
      '#.#####.#####.#######.#',
      '#H#...............#...#',
      '#.#.#####.#######.#.###',
      '#.#.#...#...#...#...#.#',
      '#.#.#.#H#.#.###.#####.#',
      '#.#...#...#.....#.....#',
      '#.#######.#.#.#.###.###',
      '#..H#.....#...#...#...#',
      '###.#.###.#######.###.#',
      '#...#........H.H.....E#',
      '#######################',
    ],
  ),
];
