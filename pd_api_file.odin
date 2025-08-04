//
//  pdext_file.h
//  Playdate Simulator
//
//  Created by Dave Hayden on 10/6/17.
//  Copyright © 2017 Panic, Inc. All rights reserved.
//
package playdate

import "core:c"

_ :: c



SDFile :: void

FileOptions :: enum c.int {
	Read     = 1,
	ReadData = 2,
	Write    = 4,
	Append   = 8,
}

FileStat :: struct {
	isdir:    c.int,
	size:     c.uint,
	m_year:   c.int,
	m_month:  c.int,
	m_day:    c.int,
	m_hour:   c.int,
	m_minute: c.int,
	m_second: c.int,
}

ListFilesCallback :: #type proc "c" (path: cstring, userdata: rawptr)

playdate_file :: struct {
	geterr:    proc "c" (void) -> cstring,
	listfiles: proc "c" (path: cstring, callback: ListfilesCallback, userdata: rawptr, showhidden: b32) -> c.int,
	stat:      proc "c" (cstring, ^FileStat) -> c.int,
	mkdir:     proc "c" (cstring) -> c.int,
	unlink:    proc "c" (cstring, c.int) -> c.int,
	rename:    proc "c" (cstring, cstring) -> c.int,
	open:      proc "c" (cstring, FileOptions) -> ^SDFile,
	close:     proc "c" (^SDFile) -> c.int,
	read:      proc "c" (^SDFile, rawptr, c.uint) -> c.int,
	write:     proc "c" (^SDFile, rawptr, c.uint) -> c.int,
	flush:     proc "c" (^SDFile) -> c.int,
	tell:      proc "c" (^SDFile) -> c.int,
	seek:      proc "c" (^SDFile, c.int, c.int) -> c.int,
}

