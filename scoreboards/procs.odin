package playdate_scoreboards

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
add_score :: #force_inline proc "contextless" (board_id: cstring, value: u32, callback: Add_Score_Callback) -> i32 {
    return vtable.add_score(board_id, value, callback)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
get_personal_best :: #force_inline proc "contextless" (board_id: cstring, callback: Personal_Best_Callback) -> i32 {
    return vtable.get_personal_best(board_id, callback)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
free_score :: #force_inline proc "contextless" (score: ^Score) {
    vtable.free_score(score)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
get_scoreboards :: #force_inline proc "contextless" (callback: Boards_List_Callback) -> i32 {
    return vtable.get_scoreboards(callback)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
free_boards_list :: #force_inline proc "contextless" (boards_list: ^Boards_List) {
    vtable.free_boards_list(boards_list)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
get_scores :: #force_inline proc "contextless" (board_id: cstring, callback: Scores_Callback) -> i32 {
    return vtable.get_scores(board_id, callback)
}

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
free_scores_list :: #force_inline proc "contextless" (scores_list: ^Scores_List) {
    vtable.free_scores_list(scores_list)
}