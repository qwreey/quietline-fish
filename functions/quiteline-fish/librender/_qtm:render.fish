function _qtm:render
	_qtm:flush

	if test -n $_qtm_var_result
		echo "$_qtm_config_prefix_result$(set_color --reset)$_qtm_var_result"
	end

	echo -n "$_qtm_var_topline
$_qtm_var_content
$_qtm_var_prompt"
end
