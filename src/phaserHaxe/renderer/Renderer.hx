package phaserHaxe.renderer;

import phaserHaxe.renderer.webgl.WebGLRenderer;
import phaserHaxe.renderer.canvas.CanvasRenderer;
import phaserHaxe.Either;

abstract Renderer(Either<CanvasRenderer, WebGLRenderer>) {}
