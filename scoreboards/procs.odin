package playdate_scoreboards

add_score :: proc(board_id: cstring, value: u32, callback: Add_Score_Callback) -> i32
get_personal_best :: proc(board_id: cstring, callback: Personal_Best_Callback) -> i32
free_score :: proc(score: ^Score)

get_scoreboards :: proc(callback: Boards_List_Callback) -> i32
free_boards_list :: proc(boards_list: Boards_List)

get_scores :: proc(board_id: cstring, callback: Scores_Callback) -> i32
free_scores_list :: proc(scores_list: ^Scores_List) 