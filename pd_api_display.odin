//
//  pdext_display.h
//  Playdate Simulator
//
//  Created by Dave Hayden on 10/6/17.
//  Copyright © 2017 Panic, Inc. All rights reserved.
//
package playdate





playdate_display :: struct {
	getWidth:       proc "c" (void) -> c.int,
	getHeight:      proc "c" (void) -> c.int,
	setRefreshRate: proc "c" (f32),
	setInverted:    proc "c" (c.int),
	setScale:       proc "c" (c.uint),
	setMosaic:      proc "c" (c.uint, c.uint),
	setFlipped:     proc "c" (c.int, c.int),
	setOffset:      proc "c" (c.int, c.int),

	// 2.7
	getRefreshRate: proc "c" (void) -> f32,
	getFPS:         proc "c" (void) -> f32,
}

