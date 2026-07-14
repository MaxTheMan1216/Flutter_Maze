# Maze Roller

A small maze game built with Flutter and the [Flame](https://flame-engine.org/)
game engine, made for the Device-Agnostic Design course.

## Idea and purpose

Steer a ball through a maze using an on-screen joystick and reach the glowing
exit tile as quickly as possible. The game has three hand-built maze levels of
increasing size and difficulty; the third level adds hazard tiles that send
the ball back to the start if touched. Completed levels are remembered
between visits/restarts, so players can track which mazes they've already
cleared.

## Deployed application

Play it here: **https://MaxTheMan-1216.github.io/Flutter_Maze/**

## How to play

1. On the start screen, tap **Play**.
2. Choose a level from the level select screen. A green checkmark marks
   levels you've already completed.
3. Drag the translucent joystick in the bottom-left corner of the screen in
   the direction you want the ball to roll. The maze walls block movement,
   so the ball slides along corridors as you steer it.
4. Reach the glowing yellow exit tile to complete the level. In level 3,
   avoid the red hazard tiles — touching one sends the ball back to the
   start.
5. From the result screen you can move on to the next level, retry the
   current one, or return to level select.

No keyboard or mouse is required — the game is fully playable with touch on
a phone or tablet (a mouse also works for dragging the joystick when playing
in a desktop browser).

## Running locally

```bash
flutter pub get
flutter run -d chrome
```
