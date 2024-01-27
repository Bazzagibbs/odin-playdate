package playdate_graphics

make_rect :: #force_inline proc "contextless" (x, y, width, height: i32) -> Rect {
    r := Rect { 
        left    = x, 
        right   = x + width, 
        top     = y, 
        bottom  = y + height,
    }

    return r
}


rect_translate :: #force_inline proc "contextless" (rect: Rect, delta_x, delta_y: i32) -> Rect {
    r := Rect {
        left    = rect.left + delta_x,
        right   = rect.right + delta_x,
        top     = rect.top + delta_y,
        bottom  = rect.bottom + delta_y,
    }
    return r
}


make_pattern :: proc {
    make_pattern_full,
    make_pattern_opaque,
}

make_pattern_full :: #force_inline proc "contextless" (r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, ra, rb, rc, rd, re, rf: u8) -> Pattern {
    return {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, ra, rb, rc, rd, re, rf}
}

make_pattern_opaque :: #force_inline proc "contextless" (r0, r1, r2, r3, r4, r5, r6, r7: u8) -> Pattern {
    return Pattern{r0, r1, r2, r3, r4, r5, r6, r7, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff}
}

