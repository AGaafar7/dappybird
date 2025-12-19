import 'dart:async';

import 'package:dappybird/constraint.dart';
import 'package:dappybird/game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Ground extends SpriteComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Ground() : super();

  @override
  FutureOr<void> onLoad() async {
    size = Vector2(gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y - groundHeight);

    sprite = await Sprite.load('terrain.png');

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= groundScrollingSpeed * dt;
    if ((position.x + size.x) / 2 <= 0) {
      position.x = 0;
    }
  }
}
