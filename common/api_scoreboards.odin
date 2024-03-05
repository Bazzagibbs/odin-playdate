package playdate_common

//   ///////////
//  // TYPES //
// ///////////

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

Scoreboards_Add_Score_Callback      :: proc "contextless" (score: ^Scoreboards_Score, error_message: cstring)
Scoreboards_Personal_Best_Callback  :: proc "contextless" (score: ^Scoreboards_Score, error_message: cstring)
Scoreboards_Boards_List_Callback    :: proc "contextless" (boards: ^Scoreboards_Boards_List, error_message: cstring)
Scoreboards_Scores_Callback         :: proc "contextless" (scores: ^Scoreboards_Scores_List, error_message: cstring)

// =================================================================


//   ////////////////
//  // PROC TYPES //
// ////////////////
Proc_Scoreboards_Add_Score           :: #type proc "c" (board_id: cstring, value: u32, callback: Scoreboards_Add_Score_Callback) -> i32
Proc_Scoreboards_Get_Personal_Best   :: #type proc "c" (board_id: cstring, callback: Scoreboards_Personal_Best_Callback) -> i32
Proc_Scoreboards_Free_Score          :: #type proc "c" (score: ^Scoreboards_Score)
                          
Proc_Scoreboards_Get_Scoreboards     :: #type proc "c" (callback: Scoreboards_Boards_List_Callback)-> i32
Proc_Scoreboards_Free_Boards_List    :: #type proc "c" (boards_list: ^Scoreboards_Boards_List)
                          
Proc_Scoreboards_Get_Scores          :: #type proc "c" (board_id: cstring, callback: Scoreboards_Scores_Callback) -> i32
Proc_Scoreboards_Free_Scores_List    :: #type proc "c" (scores_list: ^Scoreboards_Scores_List)
// =================================================================


//   ////////////////
//  // API STRUCT //
// ////////////////

Api_Scoreboards_Procs :: struct {
    add_score           : Proc_Scoreboards_Add_Score,
    get_personal_best   : Proc_Scoreboards_Get_Personal_Best,
    free_score          : Proc_Scoreboards_Free_Score,
                                                
    get_scoreboards     : Proc_Scoreboards_Get_Scoreboards,
    free_boards_list    : Proc_Scoreboards_Free_Boards_List,
                                                
    get_scores          : Proc_Scoreboards_Get_Scores,
    free_scores_list    : Proc_Scoreboards_Free_Scores_List,
}
