package playdate_scoreboards

Score :: struct {
    rank    : u32,
    value   : u32,
    player  : cstring,
}

Scores_List :: struct {
    board_id        : cstring,
    last_updated    : u32,
    player_included : bool,
    limit           : u32,
    scores          : []Score,
}

Board :: struct {
    boad_id : cstring,
    name    : cstring,
}

Boards_List :: struct {
    last_updated : u32,
    boards       : []Board, 
}

Add_Score_Callback      :: proc "contextless" (score: ^Score, error_message: cstring)
Personal_Best_Callback  :: proc "contextless" (score: ^Score, error_message: cstring)
Boards_List_Callback    :: proc "contextless" (boards: ^Boards_List, error_message: cstring)
Scores_Callback         :: proc "contextless" (scores: ^Scores_List, error_message: cstring)
