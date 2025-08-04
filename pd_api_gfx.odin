//
//  pdext_gfx.h
//  Playdate Simulator
//
//  Created by Dave Hayden on 10/6/17.
//  Copyright © 2017 Panic, Inc. All rights reserved.
//
package playdate

import "core:c"

_ :: c



LCDRect :: struct {
	left:   c.int,
	right:  c.int, // not inclusive
	top:    c.int,
	bottom: c.int, // not inclusive
}

LCD_COLUMNS :: 400
LCD_ROWS :: 240
LCD_ROWSIZE :: 52
// LCD_SCREEN_RECT :: LCDMakeRect(0,0,LCD_COLUMNS,LCD_ROWS)

LCDBitmapDrawMode :: enum c.int {
	Copy,
	WhiteTransparent,
	BlackTransparent,
	FillWhite,
	FillBlack,
	XOR,
	NXOR,
	Inverted,
}

LCDBitmapFlip :: enum c.int {
	Unflipped,
	FlippedX,
	FlippedY,
	FlippedXY,
}

LCDSolidColor :: enum c.int {
	Black,
	White,
	Clear,
	XOR,
}

LCDLineCapStyle :: enum c.int {
	Butt,
	Square,
	Round,
}

LCDFontLanguage :: enum c.int {
	English,
	Japanese,
	Unknown,
}

PDStringEncoding :: enum c.int {
	ASCIIEncoding,
	UTF8Encoding,
	_16BitLEEncoding,
}

LCDPattern :: [16]u8 // 8x8 pattern: 8 rows image data, 8 rows mask

LCDColor :: c.uintptr_t // LCDSolidColor or pointer to LCDPattern

LCDPolygonFillRule :: enum c.int {
	NonZero,
	EvenOdd,
}

PDTextWrappingMode :: enum c.int {
	Clip,
	Character,
	Word,
}

PDTextAlignment :: enum c.int {
	Left,
	Center,
	Right,
}

playdate_video :: struct {
	loadVideo:        proc "c" (cstring) -> ^LCDVideoPlayer,
	freePlayer:       proc "c" (^LCDVideoPlayer),
	setContext:       proc "c" (^LCDVideoPlayer, ^LCDBitmap) -> c.int,
	useScreenContext: proc "c" (^LCDVideoPlayer),
	renderFrame:      proc "c" (^LCDVideoPlayer, c.int) -> c.int,
	getError:         proc "c" (^LCDVideoPlayer) -> cstring,
	getInfo:          proc "c" (^LCDVideoPlayer, ^c.int, ^c.int, ^f32, ^c.int, ^c.int),
	getContext:       proc "c" (^LCDVideoPlayer) -> ^LCDBitmap,
}

playdate_videostream :: struct {
	newPlayer:             proc "c" (void) -> ^LCDStreamPlayer,
	freePlayer:            proc "c" (^LCDStreamPlayer),
	setBufferSize:         proc "c" (^LCDStreamPlayer, c.int, c.int),
	setFile:               proc "c" (^LCDStreamPlayer, ^SDFile),
	setHTTPConnection:     proc "c" (^LCDStreamPlayer, ^HTTPConnection),
	getFilePlayer:         proc "c" (^LCDStreamPlayer) -> ^FilePlayer,
	getVideoPlayer:        proc "c" (^LCDStreamPlayer) -> ^LCDVideoPlayer,

	// returns true if it drew a frame, else false
	update: proc "c" (^LCDStreamPlayer) -> bool,
	getBufferedFrameCount: proc "c" (^LCDStreamPlayer) -> c.int,
	getBytesRead:          proc "c" (^LCDStreamPlayer) -> u32,

	// 3.0
	setTCPConnection: proc "c" (^LCDStreamPlayer, ^TCPConnection),
}

playdate_tilemap :: struct {
	newTilemap:        proc "c" (void) -> ^LCDTileMap,
	freeTilemap:       proc "c" (^LCDTileMap),
	setImageTable:     proc "c" (^LCDTileMap, ^LCDBitmapTable),
	getImageTable:     proc "c" (^LCDTileMap) -> ^LCDBitmapTable,
	setSize:           proc "c" (^LCDTileMap, c.int, c.int),
	getSize:           proc "c" (^LCDTileMap, ^c.int, ^c.int),
	getPixelSize:      proc "c" (^LCDTileMap, ^u32, ^u32),
	setTiles:          proc "c" (^LCDTileMap, ^u16, c.int, c.int),
	setTileAtPosition: proc "c" (^LCDTileMap, c.int, c.int, u16),
	getTileAtPosition: proc "c" (^LCDTileMap, c.int, c.int) -> c.int,
	drawAtPoint:       proc "c" (^LCDTileMap, f32, f32),
}

playdate_graphics :: struct {
	video:                 ^playdate_video,

	// Drawing Functions
	clear: proc "c" (LCDColor),
	setBackgroundColor:    proc "c" (LCDSolidColor),
	setStencil:            proc "c" (^LCDBitmap),                                            // deprecated in favor of setStencilImage, which adds a "tile" flag
	setDrawMode:           proc "c" (LCDBitmapDrawMode) -> LCDBitmapDrawMode,
	setDrawOffset:         proc "c" (c.int, c.int),
	setClipRect:           proc "c" (c.int, c.int, c.int, c.int),
	clearClipRect:         proc "c" (void),
	setLineCapStyle:       proc "c" (LCDLineCapStyle),
	setFont:               proc "c" (^LCDFont),
	setTextTracking:       proc "c" (c.int),
	pushContext:           proc "c" (^LCDBitmap),
	popContext:            proc "c" (void),
	drawBitmap:            proc "c" (^LCDBitmap, c.int, c.int, LCDBitmapFlip),
	tileBitmap:            proc "c" (^LCDBitmap, c.int, c.int, c.int, c.int, LCDBitmapFlip),
	drawLine:              proc "c" (c.int, c.int, c.int, c.int, c.int, LCDColor),
	fillTriangle:          proc "c" (c.int, c.int, c.int, c.int, c.int, c.int, LCDColor),
	drawRect:              proc "c" (c.int, c.int, c.int, c.int, LCDColor),
	fillRect:              proc "c" (c.int, c.int, c.int, c.int, LCDColor),
	drawEllipse:           proc "c" (c.int, c.int, c.int, c.int, c.int, f32, f32, LCDColor), // stroked inside the rect
	fillEllipse:           proc "c" (c.int, c.int, c.int, c.int, f32, f32, LCDColor),
	drawScaledBitmap:      proc "c" (^LCDBitmap, c.int, c.int, f32, f32),
	drawText:              proc "c" (rawptr, c.size_t, PDStringEncoding, c.int, c.int) -> c.int,

	// LCDBitmap
	newBitmap: proc "c" (c.int, c.int, LCDColor) -> ^LCDBitmap,
	freeBitmap:            proc "c" (^LCDBitmap),
	loadBitmap:            proc "c" (cstring, [^]cstring) -> ^LCDBitmap,
	copyBitmap:            proc "c" (^LCDBitmap) -> ^LCDBitmap,
	loadIntoBitmap:        proc "c" (cstring, ^LCDBitmap, [^]cstring),
	getBitmapData:         proc "c" (^LCDBitmap, ^c.int, ^c.int, ^c.int, ^^u8, ^^u8),
	clearBitmap:           proc "c" (^LCDBitmap, LCDColor),
	rotatedBitmap:         proc "c" (^LCDBitmap, f32, f32, f32, ^c.int) -> ^LCDBitmap,

	// LCDBitmapTable
	newBitmapTable: proc "c" (c.int, c.int, c.int) -> ^LCDBitmapTable,
	freeBitmapTable:       proc "c" (^LCDBitmapTable),
	loadBitmapTable:       proc "c" (cstring, [^]cstring) -> ^LCDBitmapTable,
	loadIntoBitmapTable:   proc "c" (cstring, ^LCDBitmapTable, [^]cstring),
	getTableBitmap:        proc "c" (^LCDBitmapTable, c.int) -> ^LCDBitmap,

	// LCDFont
	loadFont: proc "c" (cstring, [^]cstring) -> ^LCDFont,
	getFontPage:           proc "c" (^LCDFont, u32) -> ^LCDFontPage,
	getPageGlyph:          proc "c" (^LCDFontPage, u32, ^^LCDBitmap, ^c.int) -> ^LCDFontGlyph,
	getGlyphKerning:       proc "c" (^LCDFontGlyph, u32, u32) -> c.int,
	getTextWidth:          proc "c" (^LCDFont, rawptr, c.size_t, PDStringEncoding, c.int) -> c.int,
	getFrame:              proc "c" (void) -> ^u8,                                           // row stride = LCD_ROWSIZE
	getDisplayFrame:       proc "c" (void) -> ^u8,                                           // row stride = LCD_ROWSIZE
	getDebugBitmap:        proc "c" (void) -> ^LCDBitmap,                                    // valid in simulator only, function is NULL on device
	copyFrameBufferBitmap: proc "c" (void) -> ^LCDBitmap,
	markUpdatedRows:       proc "c" (c.int, c.int),
	display:               proc "c" (void),

	// misc util.
	setColorToPattern: proc "c" (^LCDColor, ^LCDBitmap, c.int, c.int),
	checkMaskCollision:    proc "c" (^LCDBitmap, c.int, c.int, LCDBitmapFlip, ^LCDBitmap, c.int, c.int, LCDBitmapFlip, LCDRect) -> c.int,

	// 1.1
	setScreenClipRect: proc "c" (c.int, c.int, c.int, c.int),

	// 1.1.1
	fillPolygon: proc "c" (c.int, ^c.int, LCDColor, LCDPolygonFillRule),
	getFontHeight:         proc "c" (^LCDFont) -> u8,

	// 1.7
	getDisplayBufferBitmap: proc "c" (void) -> ^LCDBitmap,
	drawRotatedBitmap:     proc "c" (^LCDBitmap, c.int, c.int, f32, f32, f32, f32, f32),
	setTextLeading:        proc "c" (c.int),

	// 1.8
	setBitmapMask: proc "c" (^LCDBitmap, ^LCDBitmap) -> c.int,
	getBitmapMask:         proc "c" (^LCDBitmap) -> ^LCDBitmap,

	// 1.10
	setStencilImage: proc "c" (^LCDBitmap, c.int),

	// 1.12
	makeFontFromData: proc "c" (^LCDFontData, c.int) -> ^LCDFont,

	// 2.1
	getTextTracking: proc "c" (void) -> c.int,

	// 2.5
	setPixel: proc "c" (c.int, c.int, LCDColor),
	getBitmapPixel:        proc "c" (^LCDBitmap, c.int, c.int) -> LCDSolidColor,
	getBitmapTableInfo:    proc "c" (^LCDBitmapTable, ^c.int, ^c.int),

	// 2.6
	drawTextInRect: proc "c" (rawptr, c.size_t, PDStringEncoding, c.int, c.int, c.int, c.int, PDTextWrappingMode, PDTextAlignment),

	// 2.7
	getTextHeightForMaxWidth: proc "c" (^LCDFont, rawptr, c.size_t, c.int, PDStringEncoding, PDTextWrappingMode, c.int, c.int) -> c.int,
	drawRoundRect:         proc "c" (c.int, c.int, c.int, c.int, c.int, c.int, LCDColor),
	fillRoundRect:         proc "c" (c.int, c.int, c.int, c.int, c.int, LCDColor),

	// 3.0
	tilemap: ^playdate_tilemap,
	videostream:           ^playdate_videostream,
}

@(default_calling_convention="c", link_prefix="")
foreign lib {
	LCDMakeRect       :: proc(x: c.int, y: c.int, width: c.int, height: c.int) -> LCDRect ---
	LCDRect_translate :: proc(r: LCDRect, dx: c.int, dy: c.int) -> LCDRect ---
}
