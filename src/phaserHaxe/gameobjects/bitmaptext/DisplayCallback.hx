package phaserHaxe.gameobjects.bitmaptext;

import phaserHaxe.gameobjects.bitmaptext.typedefs.DisplayCallbackConfig;

/**
 * @param display - Settings of the character that is about to be rendered.
 *
 * @return Altered position, scale and rotation values for the character that is about to be rendered.
**/
typedef DisplayCallback = (display:DisplayCallbackConfig) -> DisplayCallbackConfig;