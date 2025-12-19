import 'dart:async';

import 'package:dappybird/components/background.dart';
import 'package:dappybird/components/bird.dart';
import 'package:dappybird/components/ground.dart';
import 'package:dappybird/components/pipe.dart';
import 'package:dappybird/components/pipe_manager.dart';
import 'package:dappybird/components/score.dart';
import 'package:dappybird/constraint.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class FlappyBirdGame extends FlameGame
    with TapCallbacks, HasCollisionDetection {
  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

  @override
  FutureOr<void> onLoad() {
    background = Background(size);
    add(background);

    ground = Ground();
    add(ground);

    pipeManager = PipeManager();
    add(pipeManager);

    bird = Bird();
    add(bird);

    scoreText = ScoreText();
    add(scoreText);
  }

  @override
  void onTapDown(TapDownEvent event) {
    bird.flap();
  }

  int score = 0;
  void incrementScore() {
    score += 1;
  }

  bool isGameOver = false;
  void gameOver() {
    if (isGameOver) return;
    isGameOver = true;
    pauseEngine();

    showDialog(
      context: buildContext!,
      builder: (context) => AlertDialog.adaptive(
        title: const Text("Game Over"),
        content: Text("High Score: $score"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              resetGame();
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0;
    score = 0;
    isGameOver = false;
    children.whereType<Pipe>().forEach((Pipe pipe) => pipe.removeFromParent());
    resumeEngine();
  }
}
