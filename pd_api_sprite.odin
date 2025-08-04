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



SpriteCollisionResponseType :: enum c.int {
	Slide,
	Freeze,
	Overlap,
	Bounce,
}

PDRect :: struct {
	x:      f32,
	y:      f32,
	width:  f32,
	height: f32,
}

CollisionPoint :: struct {
	x: f32,
	y: f32,
}

CollisionVector :: struct {
	x: c.int,
	y: c.int,
}

SpriteCollisionInfo :: struct {
	sprite:       ^LCDSprite,                  // The sprite being moved
	other:        ^LCDSprite,                  // The sprite colliding with the sprite being moved
	responseType: SpriteCollisionResponseType, // The result of collisionResponse
	overlaps:     u8,                          // True if the sprite was overlapping other when the collision started. False if it didn’t overlap but tunneled through other.
	ti:           f32,                         // A number between 0 and 1 indicating how far along the movement to the goal the collision occurred
	move:         CollisionPoint,              // The difference between the original coordinates and the actual ones when the collision happened
	normal:       CollisionVector,             // The collision normal; usually -1, 0, or 1 in x and y. Use this value to determine things like if your character is touching the ground.
	touch:        CollisionPoint,              // The coordinates where the sprite started touching other
	spriteRect:   PDRect,                      // The rectangle the sprite occupied when the touch happened
	otherRect:    PDRect,                      // The rectangle the sprite being collided with occupied when the touch happened
}

SpriteQueryInfo :: struct {
	sprite:     ^LCDSprite,     // The sprite being intersected by the segment
	ti1:        f32,            // entry point
	ti2:        f32,            // exit point
	entryPoint: CollisionPoint, // The coordinates of the first intersection between sprite and the line segment
	exitPoint:  CollisionPoint, // The coordinates of the second intersection between sprite and the line segment
}

LCDSpriteDrawFunction :: proc "c" (^LCDSprite, PDRect, PDRect)

LCDSpriteUpdateFunction :: proc "c" (^LCDSprite)

LCDSpriteCollisionFilterProc :: proc "c" (^LCDSprite, ^LCDSprite) -> SpriteCollisionResponseType

playdate_sprite :: struct {
	setAlwaysRedraw:          proc "c" (c.int),
	addDirtyRect:             proc "c" (LCDRect),
	drawSprites:              proc "c" (void),
	updateAndDrawSprites:     proc "c" (void),
	newSprite:                proc "c" (void) -> ^LCDSprite,
	freeSprite:               proc "c" (^LCDSprite),
	copy:                     proc "c" (^LCDSprite) -> ^LCDSprite,
	addSprite:                proc "c" (^LCDSprite),
	removeSprite:             proc "c" (^LCDSprite),
	removeSprites:            proc "c" (^^LCDSprite, c.int),
	removeAllSprites:         proc "c" (void),
	getSpriteCount:           proc "c" (void) -> c.int,
	setBounds:                proc "c" (^LCDSprite, PDRect),
	getBounds:                proc "c" (^LCDSprite) -> PDRect,
	moveTo:                   proc "c" (^LCDSprite, f32, f32),
	moveBy:                   proc "c" (^LCDSprite, f32, f32),
	setImage:                 proc "c" (^LCDSprite, ^LCDBitmap, LCDBitmapFlip),
	getImage:                 proc "c" (^LCDSprite) -> ^LCDBitmap,
	setSize:                  proc "c" (^LCDSprite, f32, f32),
	setZIndex:                proc "c" (^LCDSprite, i16),
	getZIndex:                proc "c" (^LCDSprite) -> i16,
	setDrawMode:              proc "c" (^LCDSprite, LCDBitmapDrawMode),
	setImageFlip:             proc "c" (^LCDSprite, LCDBitmapFlip),
	getImageFlip:             proc "c" (^LCDSprite) -> LCDBitmapFlip,
	setStencil:               proc "c" (^LCDSprite, ^LCDBitmap),                                           // deprecated in favor of setStencilImage()
	setClipRect:              proc "c" (^LCDSprite, LCDRect),
	clearClipRect:            proc "c" (^LCDSprite),
	setClipRectsInRange:      proc "c" (LCDRect, c.int, c.int),
	clearClipRectsInRange:    proc "c" (c.int, c.int),
	setUpdatesEnabled:        proc "c" (^LCDSprite, c.int),
	updatesEnabled:           proc "c" (^LCDSprite) -> c.int,
	setCollisionsEnabled:     proc "c" (^LCDSprite, c.int),
	collisionsEnabled:        proc "c" (^LCDSprite) -> c.int,
	setVisible:               proc "c" (^LCDSprite, c.int),
	isVisible:                proc "c" (^LCDSprite) -> c.int,
	setOpaque:                proc "c" (^LCDSprite, c.int),
	markDirty:                proc "c" (^LCDSprite),
	setTag:                   proc "c" (^LCDSprite, u8),
	getTag:                   proc "c" (^LCDSprite) -> u8,
	setIgnoresDrawOffset:     proc "c" (^LCDSprite, c.int),
	setUpdateFunction:        proc "c" (^LCDSprite, LCDSpriteUpdateFunction),
	setDrawFunction:          proc "c" (^LCDSprite, LCDSpriteDrawFunction),
	getPosition:              proc "c" (^LCDSprite, ^f32, ^f32),

	// Collisions
	resetCollisionWorld: proc "c" (void),
	setCollideRect:           proc "c" (^LCDSprite, PDRect),
	getCollideRect:           proc "c" (^LCDSprite) -> PDRect,
	clearCollideRect:         proc "c" (^LCDSprite),

	// caller is responsible for freeing the returned array for all collision methods
	setCollisionResponseFunction: proc "c" (^LCDSprite, LCDSpriteCollisionFilterProc),
	checkCollisions:          proc "c" (^LCDSprite, f32, f32, ^f32, ^f32, ^c.int) -> ^SpriteCollisionInfo, // access results using SpriteCollisionInfo *info = &results[i];
	moveWithCollisions:       proc "c" (^LCDSprite, f32, f32, ^f32, ^f32, ^c.int) -> ^SpriteCollisionInfo,
	querySpritesAtPoint:      proc "c" (f32, f32, ^c.int) -> ^^LCDSprite,
	querySpritesInRect:       proc "c" (f32, f32, f32, f32, ^c.int) -> ^^LCDSprite,
	querySpritesAlongLine:    proc "c" (f32, f32, f32, f32, ^c.int) -> ^^LCDSprite,
	querySpriteInfoAlongLine: proc "c" (f32, f32, f32, f32, ^c.int) -> ^SpriteQueryInfo,                   // access results using SpriteQueryInfo *info = &results[i];
	overlappingSprites:       proc "c" (^LCDSprite, ^c.int) -> ^^LCDSprite,
	allOverlappingSprites:    proc "c" (^c.int) -> ^^LCDSprite,

	// added in 1.7
	setStencilPattern: proc "c" (^LCDSprite, ^u8),
	clearStencil:             proc "c" (^LCDSprite),
	setUserdata:              proc "c" (^LCDSprite, rawptr),
	getUserdata:              proc "c" (^LCDSprite) -> rawptr,

	// added in 1.10
	setStencilImage: proc "c" (^LCDSprite, ^LCDBitmap, c.int),

	// 2.1
	setCenter: proc "c" (^LCDSprite, f32, f32),
	getCenter:                proc "c" (^LCDSprite, ^f32, ^f32),

	// 2.7
	setTilemap: proc "c" (^LCDSprite, ^LCDTileMap),
	getTilemap:               proc "c" (^LCDSprite) -> ^LCDTileMap,
}

@(default_calling_convention="c", link_prefix="")
foreign lib {
	PDRectMake :: proc(x: f32, y: f32, width: f32, height: f32) -> PDRect ---
}
