package playdate_scoreboards

import "../bindings"

Score       :: bindings.Scoreboards_Score
Scores_List :: bindings.Scoreboards_Scores_List
Board       :: bindings.Scoreboards_Board
Boards_List :: bindings.Scoreboards_Boards_List

Add_Score_Callback     :: bindings.Add_Score_Callback
Personal_Best_Callback :: bindings.Personal_Best_Callback
Boards_List_Callback   :: bindings.Boards_List_Callback
Scores_Callback        :: bindings.Scores_Callback


// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
add_score :: proc "contextless" (board_id: cstring, value: u32, callback: Add_Score_Callback) -> i32 {
    return bindings.scoreboards.add_score(board_id, value, callback)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
get_personal_best :: proc "contextless" (board_id: cstring, callback: Personal_Best_Callback) -> i32 {
    return bindings.scoreboards.get_personal_best(board_id, callback)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
free_score :: proc "contextless" (score: ^Score) {
    bindings.scoreboards.free_score(score)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
get_scoreboards :: proc "contextless" (callback: Boards_List_Callback) -> i32 {
    return bindings.scoreboards.get_scoreboards(callback)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
free_boards_list :: proc "contextless" (boards_list: ^Boards_List) {
    bindings.scoreboards.free_boards_list(boards_list)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
get_scores :: proc "contextless" (board_id: cstring, callback: Scores_Callback) -> i32 {
    return bindings.scoreboards.get_scores(board_id, callback)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
free_scores_list :: proc "contextless" (scores_list: ^Scores_List) {
    bindings.scoreboards.free_scores_list(scores_list)
}

// =================================================================

