package phaserHaxe.renderer;

import phaserHaxe.renderer.webgl.WebGLRenderer;
import phaserHaxe.renderer.canvas.CanvasRenderer;
import phaserHaxe.utils.types.Union;

abstract Renderer(Union<CanvasRenderer, WebGLRenderer>) {}
