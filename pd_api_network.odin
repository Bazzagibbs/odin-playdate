//
//  pd_api_http.h
//  Playdate Simulator
//
//  Created by Dave Hayden on 7/18/24.
//  Copyright © 2024 Panic, Inc. All rights reserved.
//
package playdate

import "core:c"

_ :: c



PDNetErr :: enum c.int {
	OK                  = 0,
	NO_DEVICE           = -1,
	BUSY                = -2,
	WRITE_ERROR         = -3,
	WRITE_BUSY          = -4,
	WRITE_TIMEOUT       = -5,
	READ_ERROR          = -6,
	READ_BUSY           = -7,
	READ_TIMEOUT        = -8,
	READ_OVERFLOW       = -9,
	FRAME_ERROR         = -10,
	BAD_RESPONSE        = -11,
	ERROR_RESPONSE      = -12,
	RESET_TIMEOUT       = -13,
	BUFFER_TOO_SMALL    = -14,
	UNEXPECTED_RESPONSE = -15,
	NOT_CONNECTED_TO_AP = -16,
	NOT_IMPLEMENTED     = -17,
	CONNECTION_CLOSED   = -18,
}

WifiStatus :: enum c.int {
	NotConnected = 0, //!< Not connected to an AP
	Connected,        //!< Device is connected to an AP
	NotAvailable,     //!< A connection has been attempted and no configured AP was available
}

AccessRequestCallback :: proc "c" (bool, rawptr)

HTTPConnectionCallback :: proc "c" (^HTTPConnection)

HTTPHeaderCallback :: proc "c" (^HTTPConnection, cstring, cstring)

playdate_http :: struct {
	requestAccess:               proc "c" (cstring, c.int, bool, cstring, AccessRequestCallback, rawptr) -> accessReply,
	newConnection:               proc "c" (cstring, c.int, bool) -> ^HTTPConnection,
	retain:                      proc "c" (^HTTPConnection) -> ^HTTPConnection,
	release:                     proc "c" (^HTTPConnection),
	setConnectTimeout:           proc "c" (^HTTPConnection, c.int),
	setKeepAlive:                proc "c" (^HTTPConnection, bool),
	setByteRange:                proc "c" (^HTTPConnection, c.int, c.int),
	setUserdata:                 proc "c" (^HTTPConnection, rawptr),
	getUserdata:                 proc "c" (^HTTPConnection) -> rawptr,
	get:                         proc "c" (^HTTPConnection, cstring, cstring, c.size_t) -> PDNetErr,
	post:                        proc "c" (^HTTPConnection, cstring, cstring, c.size_t, cstring, c.size_t) -> PDNetErr,
	query:                       proc "c" (^HTTPConnection, cstring, cstring, cstring, c.size_t, cstring, c.size_t) -> PDNetErr,
	getError:                    proc "c" (^HTTPConnection) -> PDNetErr,
	getProgress:                 proc "c" (^HTTPConnection, ^c.int, ^c.int),
	getResponseStatus:           proc "c" (^HTTPConnection) -> c.int,
	getBytesAvailable:           proc "c" (^HTTPConnection) -> c.size_t,
	setReadTimeout:              proc "c" (^HTTPConnection, c.int),
	setReadBufferSize:           proc "c" (^HTTPConnection, c.int),
	read:                        proc "c" (^HTTPConnection, rawptr, c.uint) -> c.int,
	close:                       proc "c" (^HTTPConnection),
	setHeaderReceivedCallback:   proc "c" (^HTTPConnection, HTTPHeaderCallback),
	setHeadersReadCallback:      proc "c" (^HTTPConnection, HTTPConnectionCallback),
	setResponseCallback:         proc "c" (^HTTPConnection, HTTPConnectionCallback),
	setRequestCompleteCallback:  proc "c" (^HTTPConnection, HTTPConnectionCallback),
	setConnectionClosedCallback: proc "c" (^HTTPConnection, HTTPConnectionCallback),
}

TCPConnectionCallback :: proc "c" (^TCPConnection, PDNetErr)

TCPOpenCallback :: proc "c" (^TCPConnection, PDNetErr, rawptr)

playdate_tcp :: struct {
	requestAccess:               proc "c" (cstring, c.int, bool, cstring, AccessRequestCallback, rawptr) -> accessReply,
	newConnection:               proc "c" (cstring, c.int, bool) -> ^TCPConnection,
	retain:                      proc "c" (^TCPConnection) -> ^TCPConnection,
	release:                     proc "c" (^TCPConnection),
	getError:                    proc "c" (^TCPConnection) -> PDNetErr,
	setConnectTimeout:           proc "c" (^TCPConnection, c.int),
	setUserdata:                 proc "c" (^TCPConnection, rawptr),
	getUserdata:                 proc "c" (^TCPConnection) -> rawptr,
	open:                        proc "c" (^TCPConnection, TCPOpenCallback, rawptr) -> PDNetErr,
	close:                       proc "c" (^TCPConnection) -> PDNetErr,
	setConnectionClosedCallback: proc "c" (^TCPConnection, TCPConnectionCallback),
	setReadTimeout:              proc "c" (^TCPConnection, c.int),
	setReadBufferSize:           proc "c" (^TCPConnection, c.int),
	getBytesAvailable:           proc "c" (^TCPConnection) -> c.size_t,
	read:                        proc "c" (^TCPConnection, rawptr, c.size_t) -> c.int, // returns # of bytes read, or PDNetErr on error
	write:                       proc "c" (^TCPConnection, rawptr, c.size_t) -> c.int, // returns # of bytes sent, or PDNetErr on error
}

playdate_network :: struct {
	http:       ^playdate_http,
	tcp:        ^playdate_tcp,
	getStatus:  proc "c" (void) -> WifiStatus,
	setEnabled: proc "c" (bool, proc "c" (PDNetErr)),
	reserved:   [3]c.uintptr_t,
}

