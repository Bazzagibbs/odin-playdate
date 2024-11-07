package playdate_scoreboards

import pd ".."

Score       :: pd.Score
Scores_List :: pd.Scores_List
Board       :: pd.Board
Boards_List :: pd.Boards_List

Add_Score_Callback     :: pd.Add_Score_Callback
Personal_Best_Callback :: pd.Personal_Best_Callback
Boards_List_Callback   :: pd.Boards_List_Callback
Scores_Callback        :: pd.Scores_Callback

_procs : pd.Api_Scoreboards_Procs

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
add_score :: proc "contextless" (board_id: cstring, value: u32, callback: Add_Score_Callback) -> i32 {
    return _procs.add_score(board_id, value, callback)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
get_personal_best :: proc "contextless" (board_id: cstring, callback: Personal_Best_Callback) -> i32 {
    return _procs.get_personal_best(board_id, callback)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
free_score :: proc "contextless" (score: ^Score) {
    _procs.free_score(score)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
get_scoreboards :: proc "contextless" (callback: Boards_List_Callback) -> i32 {
    return _procs.get_scoreboards(callback)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
free_boards_list :: proc "contextless" (boards_list: ^Boards_List) {
    _procs.free_boards_list(boards_list)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
get_scores :: proc "contextless" (board_id: cstring, callback: Scores_Callback) -> i32 {
    return _procs.get_scores(board_id, callback)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
free_scores_list :: proc "contextless" (scores_list: ^Scores_List) {
    _procs.free_scores_list(scores_list)
}

// =================================================================

@(init, private)
_register_loader :: proc "contextless" () {
    pd._loaders[.scoreboards] = _load
}

@(private)
_load :: proc "contextless" (api: ^pd.Api) {
    _procs = api.scoreboards^
}
