package playdate_scoreboards

Proc_Add_Score           :: #type proc "c" (board_id: cstring, value: u32, callback: Add_Score_Callback) -> i32
Proc_Get_Personal_Best   :: #type proc "c" (board_id: cstring, callback: Personal_Best_Callback) -> i32
Proc_Free_Score          :: #type proc "c" (score: ^Score)
                          
Proc_Get_Scoreboards     :: #type proc "c" (callback: Boards_List_Callback)-> i32
Proc_Free_Boards_List    :: #type proc "c" (boards_list: ^Boards_List)
                          
Proc_Get_Scores          :: #type proc "c" (board_id: cstring, callback: Scores_Callback) -> i32
Proc_Free_Scores_List    :: #type proc "c" (scores_list: ^Scores_List)

vtable: ^VTable

VTable :: struct {
    add_score           : Proc_Add_Score,
    get_personal_best   : Proc_Get_Personal_Best,
    free_score          : Proc_Free_Score,
                                                
    get_scoreboards     : Proc_Get_Scoreboards,
    free_boards_list    : Proc_Free_Boards_List,
                                                
    get_scores          : Proc_Get_Scores,
    free_scores_list    : Proc_Free_Scores_List,
}