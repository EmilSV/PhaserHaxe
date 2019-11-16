package phaserHaxe.renderer;

import phaserHaxe.device.CanvasFeaturesInfo;
import phaserHaxe.renderer.BlendModes;

final class Canvas
{
	public static function getBlendModes():BlendModeMap
	{
		var output = new BlendModeMap();
		var useNew = CanvasFeaturesInfo.supportNewBlendModes;
		var so = 'source-over';

		output[NORMAL] = so;
		output[ADD] = 'lighter';
		output[MULTIPLY] = (useNew) ? 'multiply' : so;
		output[SCREEN] = (useNew) ? 'screen' : so;
		output[OVERLAY] = (useNew) ? 'overlay' : so;
		output[DARKEN] = (useNew) ? 'darken' : so;
		output[LIGHTEN] = (useNew) ? 'lighten' : so;
		output[COLOR_DODGE] = (useNew) ? 'color-dodge' : so;
		output[COLOR_BURN] = (useNew) ? 'color-burn' : so;
		output[HARD_LIGHT] = (useNew) ? 'hard-light' : so;
		output[SOFT_LIGHT] = (useNew) ? 'soft-light' : so;
		output[DIFFERENCE] = (useNew) ? 'difference' : so;
		output[EXCLUSION] = (useNew) ? 'exclusion' : so;
		output[HUE] = (useNew) ? 'hue' : so;
		output[SATURATION] = (useNew) ? 'saturation' : so;
		output[COLOR] = (useNew) ? 'color' : so;
		output[LUMINOSITY] = (useNew) ? 'luminosity' : so;
		output[ERASE] = 'destination-out';
		output[SOURCE_IN] = 'source-in';
		output[SOURCE_OUT] = 'source-out';
		output[SOURCE_ATOP] = 'source-atop';
		output[DESTINATION_OVER] = 'destination-over';
		output[DESTINATION_IN] = 'destination-in';
		output[DESTINATION_OUT] = 'destination-out';
		output[DESTINATION_ATOP] = 'destination-atop';
		output[LIGHTER] = 'lighter';
		output[COPY] = 'copy';
		output[XOR] = 'xor';

		return output;
	}
}
