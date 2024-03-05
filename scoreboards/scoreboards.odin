package playdate_scoreboards

import ".."
import "../common"

Score       :: common.Scoreboards_Score
Scores_List :: common.Scoreboards_Scores_List
Board       :: common.Scoreboards_Board
Boards_List :: common.Scoreboards_Boards_List


// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
add_score         : common.Proc_Scoreboards_Add_Score

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
get_personal_best : common.Proc_Scoreboards_Get_Personal_Best

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
free_score        : common.Proc_Scoreboards_Free_Score

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
get_scoreboards   : common.Proc_Scoreboards_Get_Scoreboards

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
free_boards_list  : common.Proc_Scoreboards_Free_Boards_List

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
get_scores        : common.Proc_Scoreboards_Get_Scores

// Scoreboards package has no public documentation, and its API functionality is only available to Season games on Catalog.
free_scores_list  : common.Proc_Scoreboards_Free_Scores_List

// =================================================================


//   /////////////////
//  // LOADER PROC //
// /////////////////

// Position in PlaydateAPI struct (see pd_api.h)
API_INDEX :: 8

@(init)
_register :: proc() {
    playdate._loaders[API_INDEX] = _load_procs
}

_load_procs :: proc "contextless" (api: ^playdate.Api) {
    add_score         = api.scoreboards.add_score
    get_personal_best = api.scoreboards.get_personal_best
    free_score        = api.scoreboards.free_score
    get_scoreboards   = api.scoreboards.get_scoreboards
    free_boards_list  = api.scoreboards.free_boards_list
    get_scores        = api.scoreboards.get_scores
    free_scores_list  = api.scoreboards.free_scores_list
}

