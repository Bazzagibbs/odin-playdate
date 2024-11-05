package playdate_bindings

Scoreboards_Score :: struct {
    rank    : u32,
    value   : u32,
    player  : cstring,
}

Scoreboards_Scores_List :: struct {
    board_id        : cstring,
    last_updated    : u32,
    player_included : bool,
    limit           : u32,
    scores          : []Scoreboards_Score,
}

Scoreboards_Board :: struct {
    boad_id : cstring,
    name    : cstring,
}

Scoreboards_Boards_List :: struct {
    last_updated : u32,
    boards       : []Scoreboards_Board, 
}

Add_Score_Callback      :: #type proc "contextless" (score: ^Scoreboards_Score, error_message: cstring)
Personal_Best_Callback  :: #type proc "contextless" (score: ^Scoreboards_Score, error_message: cstring)
Boards_List_Callback    :: #type proc "contextless" (boards: ^Scoreboards_Boards_List, error_message: cstring)
Scores_Callback         :: #type proc "contextless" (scores: ^Scoreboards_Scores_List, error_message: cstring)

// =================================================================


Api_Scoreboards_Procs :: struct {
    add_score           : proc "c" (board_id: cstring, value: u32, callback: Add_Score_Callback) -> i32,
    get_personal_best   : proc "c" (board_id: cstring, callback: Personal_Best_Callback) -> i32,
    free_score          : proc "c" (score: ^Scoreboards_Score),

    get_scoreboards     : proc "c" (callback: Boards_List_Callback)-> i32,
    free_boards_list    : proc "c" (boards_list: ^Scoreboards_Boards_List),

    get_scores          : proc "c" (board_id: cstring, callback: Scores_Callback) -> i32,
    free_scores_list    : proc "c" (scores_list: ^Scoreboards_Scores_List),
}
// =================================================================

