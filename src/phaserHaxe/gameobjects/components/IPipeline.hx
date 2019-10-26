package phaserHaxe.gameobjects.components;

import phaserHaxe.renderer.webgl.WebGLPipeline;
import phaserHaxe.gameobjects.GameObject;

@:phaserHaxe.Mixin(phaserHaxe.gameobjects.components.IPipeline.PipelineMixin)
interface IPipeline
{
	/**
	 * The initial WebGL pipeline of this Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var defaultPipeline:WebGLPipeline;

	/**
	 * The current WebGL pipeline of this Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var pipeline:WebGLPipeline;

	/**
	 * Sets the initial WebGL Pipeline of this Game Object.
	 * This should only be called during the instantiation of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @param pipelineName - The name of the pipeline to set on this Game Object. Defaults to the Texture Tint Pipeline.
	 *
	 * @return `true` if the pipeline was set successfully, otherwise `false`.
	**/
	public function initPipeline(pipelineName:String = "TextureTintPipeline"):Bool;

	/**
	 * Sets the active WebGL Pipeline of this Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @param pipelineName - The name of the pipeline to set on this Game Object.
	 *
	 * @return This Game Object instance.
	 */
	public function setPipeline(pipelineName:String):IPipeline;

	/**
	 * Resets the WebGL Pipeline of this Game Object back to the default it was created with.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @return `true` if the pipeline was set successfully, otherwise `false`.
	**/
	public function resetPipeline():Bool;

	/**
	 * Gets the name of the WebGL Pipeline this Game Object is currently using.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @return The string-based name of the pipeline being used by this Game Object.
	**/
	public function getPipelineName():String;
}

final class PipelineImplementation
{
	public static inline function initPipeline<T:IPipeline & GameObject>(self:T,
			pipelineName:String = "TextureTintPipeline"):Bool
	{
		var renderer:Dynamic = self.scene.sys.game.renderer;

		if (renderer != null && renderer.gl != null && renderer.hasPipeline(pipelineName))
		{
			self.defaultPipeline = renderer.getPipeline(pipelineName);
			self.pipeline = self.defaultPipeline;

			return true;
		}

		return false;
	}

	/**
	 * Sets the active WebGL Pipeline of this Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @param pipelineName - The name of the pipeline to set on this Game Object.
	 *
	 * @return This Game Object instance.
	 */
	public static inline function setPipeline<T:IPipeline & GameObject>(self:T,
			pipelineName:String):T
	{
		var renderer:Dynamic = self.scene.sys.game.renderer;

		if (renderer != null && renderer.gl != null && renderer.hasPipeline(pipelineName))
		{
			self.pipeline = renderer.getPipeline(pipelineName);
		}

		return self;
	}

	/**
	 * Resets the WebGL Pipeline of this Game Object back to the default it was created with.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @return `true` if the pipeline was set successfully, otherwise `false`.
	**/
	public static inline function resetPipeline<T:IPipeline>(self:T):Bool
	{
		self.pipeline = self.defaultPipeline;

		return (self.pipeline != null);
	}

	/**
	 * Gets the name of the WebGL Pipeline this Game Object is currently using.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @return The string-based name of the pipeline being used by this Game Object.
	**/
	public static inline function getPipelineName<T:IPipeline>(self:T):String
	{
		return self.pipeline.name;
	}
}

final class PipelineMixin extends GameObject implements IPipeline
{
	/**
	 * The initial WebGL pipeline of this Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var defaultPipeline:WebGLPipeline = null;

	/**
	 * The current WebGL pipeline of this Game Object.
	 *
	 * @webglOnly
	 * @since 1s.0.0
	**/
	public var pipeline:WebGLPipeline = null;

	/**
	 * Sets the initial WebGL Pipeline of this Game Object.
	 * This should only be called during the instantiation of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @param pipelineName - The name of the pipeline to set on this Game Object. Defaults to the Texture Tint Pipeline.
	 *
	 * @return `true` if the pipeline was set successfully, otherwise `false`.
	**/
	public function initPipeline(pipelineName:String = "TextureTintPipeline"):Bool
	{
		return PipelineImplementation.initPipeline(this, pipelineName);
	}

	/**
	 * Sets the active WebGL Pipeline of this Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @param pipelineName - The name of the pipeline to set on this Game Object.
	 *
	 * @return This Game Object instance.
	 */
	public function setPipeline(pipelineName:String):PipelineMixin
	{
		return PipelineImplementation.setPipeline(this, pipelineName);
	}

	/**
	 * Resets the WebGL Pipeline of this Game Object back to the default it was created with.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @return `true` if the pipeline was set successfully, otherwise `false`.
	**/
	public function resetPipeline():Bool
	{
		return PipelineImplementation.resetPipeline(this);
	}

	/**
	 * Gets the name of the WebGL Pipeline this Game Object is currently using.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @return The string-based name of the pipeline being used by this Game Object.
	**/
	public function getPipelineName():String
	{
		return PipelineImplementation.getPipelineName(this);
	}
}
