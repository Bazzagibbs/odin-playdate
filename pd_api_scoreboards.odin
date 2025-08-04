package playdate

import "core:c"

_ :: c



PDScore :: struct {
	rank:   u32,
	value:  u32,
	player: cstring,
}

PDScoresList :: struct {
	boardID:        cstring,
	count:          c.uint,
	lastUpdated:    u32,
	playerIncluded: c.int,
	limit:          c.uint,
	scores:         ^PDScore,
}

PDBoard :: struct {
	boardID: cstring,
	name:    cstring,
}

PDBoardsList :: struct {
	count:       c.uint,
	lastUpdated: u32,
	boards:      ^PDBoard,
}

AddScoreCallback :: proc "c" (^PDScore, cstring)

PersonalBestCallback :: proc "c" (^PDScore, cstring)

BoardsListCallback :: proc "c" (^PDBoardsList, cstring)

ScoresCallback :: proc "c" (^PDScoresList, cstring)

playdate_scoreboards :: struct {
	addScore:        proc "c" (cstring, u32, AddScoreCallback) -> c.int,
	getPersonalBest: proc "c" (cstring, PersonalBestCallback) -> c.int,
	freeScore:       proc "c" (^PDScore),
	getScoreboards:  proc "c" (BoardsListCallback) -> c.int,
	freeBoardsList:  proc "c" (^PDBoardsList),
	getScores:       proc "c" (cstring, ScoresCallback) -> c.int,
	freeScoresList:  proc "c" (^PDScoresList),
}

