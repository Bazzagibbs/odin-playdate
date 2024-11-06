package playdate

Score :: struct {
    rank    : u32,
    value   : u32,
    player  : cstring,
}

Scores_List :: struct {
    board_id        : cstring,
    count           : u32,
    last_updated    : u32,
    player_included : b32,
    limit           : u32,
    scores          : [^]Score,
}

Board :: struct {
    board_id : cstring,
    name    : cstring,
}

Boards_List :: struct {
    count        : u32,
    last_updated : u32,
    boards       : [^]Board, 
}

Add_Score_Callback      :: #type proc "contextless" (score: ^Score, error_message: cstring)
Personal_Best_Callback  :: #type proc "contextless" (score: ^Score, error_message: cstring)
Boards_List_Callback    :: #type proc "contextless" (boards: ^Boards_List, error_message: cstring)
Scores_Callback         :: #type proc "contextless" (scores: ^Scores_List, error_message: cstring)

// =================================================================


Api_Scoreboards_Procs :: struct {
    add_score           : proc "c" (board_id: cstring, value: u32, callback: Add_Score_Callback) -> i32,
    get_personal_best   : proc "c" (board_id: cstring, callback: Personal_Best_Callback) -> i32,
    free_score          : proc "c" (score: ^Score),

    get_scoreboards     : proc "c" (callback: Boards_List_Callback)-> i32,
    free_boards_list    : proc "c" (boards_list: ^Boards_List),

    get_scores          : proc "c" (board_id: cstring, callback: Scores_Callback) -> i32,
    free_scores_list    : proc "c" (scores_list: ^Scores_List),
}
// =================================================================

