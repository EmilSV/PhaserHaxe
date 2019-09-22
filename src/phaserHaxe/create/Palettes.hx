package phaserHaxe.create;

import phaserHaxe.create.Palette;

final class Palettes
{
	/**
	 * A 16 color palette inspired by Japanese computers like the MSX.
	 *
	 * @since 1.0.0
	**/
	public static final msx:Palette = new Palette({
		"0": '#000',
		"1": '#191028',
		"2": '#46af45',
		"3": '#a1d685',
		"4": '#453e78',
		"5": '#7664fe',
		"6": '#833129',
		"7": '#9ec2e8',
		"8": '#dc534b',
		"9": '#e18d79',
		"A": '#d6b97b',
		"B": '#e9d8a1',
		"C": '#216c4b',
		"D": '#d365c8',
		"E": '#afaab9',
		"F": '#fff'
	});

	/**
	 * A 16 color JMP palette by [Arne](http://androidarts.com/palette/16pal.htm)
	 *
	 * @since 1.0.0
	**/
	public static final jmp:Palette = new Palette({
		"0": '#000',
		"1": '#191028',
		"2": '#46af45',
		"3": '#a1d685',
		"4": '#453e78',
		"5": '#7664fe',
		"6": '#833129',
		"7": '#9ec2e8',
		"8": '#dc534b',
		"9": '#e18d79',
		"A": '#d6b97b',
		"B": '#e9d8a1',
		"C": '#216c4b',
		"D": '#d365c8',
		"E": '#afaab9',
		"F": '#f5f4eb'
	});

	/**
	 * A 16 color CGA inspired palette by [Arne](http://androidarts.com/palette/16pal.htm)
	 *
	 * @since 1.0.0
	**/
	public static final cga = new Palette({
		"0": '#000',
		"1": '#2234d1',
		"2": '#0c7e45',
		"3": '#44aacc',
		"4": '#8a3622',
		"5": '#5c2e78',
		"6": '#aa5c3d',
		"7": '#b5b5b5',
		"8": '#5e606e',
		"9": '#4c81fb',
		"A": '#6cd947',
		"B": '#7be2f9',
		"C": '#eb8a60',
		"D": '#e23d69',
		"E": '#ffd93f',
		"F": '#fff'
	});

	/**
	 * A 16 color palette inspired by the Commodore 64.
	 *
	 * @since 1.0.0
	**/
	public static final c64 = new Palette({
		"0": '#000',
		"1": '#fff',
		"2": '#8b4131',
		"3": '#7bbdc5',
		"4": '#8b41ac',
		"5": '#6aac41',
		"6": '#3931a4',
		"7": '#d5de73',
		"8": '#945a20',
		"9": '#5a4100',
		"A": '#bd736a',
		"B": '#525252',
		"C": '#838383',
		"D": '#acee8b',
		"E": '#7b73de',
		"F": '#acacac'
	});

	/**
	 * A 16 color palette by [Arne](http://androidarts.com/palette/16pal.htm)
	 *
	 * @since 1.0.0
	**/
	public static final arne16 = new Palette({
		"0": '#000',
		"1": '#9D9D9D',
		"2": '#FFF',
		"3": '#BE2633',
		"4": '#E06F8B',
		"5": '#493C2B',
		"6": '#A46422',
		"7": '#EB8931',
		"8": '#F7E26B',
		"9": '#2F484E',
		"A": '#44891A',
		"B": '#A3CE27',
		"C": '#1B2632',
		"D": '#005784',
		"E": '#31A2F2',
		"F": '#B2DCEF'
	});
}
