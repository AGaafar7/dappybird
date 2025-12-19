import 'dart:async';

import 'package:dappybird/components/ground.dart';
import 'package:dappybird/components/pipe.dart';
import 'package:dappybird/constraint.dart';
import 'package:dappybird/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  Bird()
    : super(
        position: Vector2(birdStartX, birdStartY),
        size: Vector2(birdWidth, birdheight),
      );
  double velocity = 0;

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load("flappybirdwingmid.png");

    add(RectangleHitbox());
  }

  void flap() {
    velocity = jumpStrength;
  }

  @override
  void update(double dt) {
    velocity += dt * gravity;
    position.y += velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Ground) {
      (parent as FlappyBirdGame).gameOver();
    }

    if(other is Pipe){
      (parent as FlappyBirdGame).gameOver();
    }
  }
}
