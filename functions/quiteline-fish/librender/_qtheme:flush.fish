function _qtheme:flush
    test _qtheme_var_curr_toplen = "0"
    and return 0

    set _qtheme_var_topline "$_qtheme_var_topline$_qtheme_var_curr_topcolor$(
        string repeat -n $_qtheme_var_curr_toplen "▁"
    )$(set_color --reset)"
    set _qtheme_var_curr_toplen "0"
end
