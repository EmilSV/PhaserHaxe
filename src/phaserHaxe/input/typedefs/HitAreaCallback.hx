package phaserHaxe.input.typedefs;

import phaserHaxe.gameobjects.GameObject;

/**
 * @since 1.0.0
 *
 * @param hitArea - The hit area object.
 * @param x - The translated x coordinate of the hit test event.
 * @param y - The translated y coordinate of the hit test event.
 * @param gameObject - The Game Object that invoked the hit test.
 *
 * @return `true` if the coordinates fall within the space of the hitArea, otherwise `false`.
**/
typedef HitAreaCallback = (hitArea:Any, x:Float, y:Float, gameObject:GameObject) -> Void;
