function _qtm:flush
	test _qtm_var_curr_toplen = "0"
	and return 0

	set _qtm_var_topline "$_qtm_var_topline$_qtm_var_curr_topcolor$(
		string repeat -n $_qtm_var_curr_toplen -- "▁"
	)$(set_color --reset)"
	set _qtm_var_curr_toplen "0"
end
