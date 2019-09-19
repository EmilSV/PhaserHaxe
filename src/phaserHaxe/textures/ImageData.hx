package phaserHaxe.textures;

#if js
import phaserHaxe.gameobjects.RenderTexture;
import js.html.CanvasElement as HTMLCanvasElement;
import js.html.ImageElement as HTMLImageElement;
abstract ImageData(Dynamic) from HTMLImageElement from HTMLCanvasElement
	from RenderTexture {}
#else
import phaserHaxe.gameobjects.RenderTexture;

abstract ImageData(Dynamic) from RenderTexture {}
#end
