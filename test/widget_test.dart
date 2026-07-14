import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:maze_ball_game/main.dart';

void main() {
  testWidgets('Start screen shows title and Play button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MazeRollerApp());

    expect(find.text('Maze Roller'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Play'), findsOneWidget);
  });
}
