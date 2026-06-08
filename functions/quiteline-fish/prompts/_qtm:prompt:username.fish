function _qtm:prompt:username; argparse --max-args 0 \
	'content-color=*' 'topline-color=*' \
-- $argv || return
	# Flag defaults
	set --query -l _flag_topline_color
	or set -l _flag_topline_color "$_qtm_color_topline_default"
	set --query -l _flag_content_color
	or set -l _flag_content_color "$_qtm_color_symbol_default"

	echo "name   =username"
	echo "render =_qtm:prompt:username:render"
	echo "namespace_enter ="(_qtm:ns_capture)

	# Render result
	function _qtm:prompt:username:render; $_qtm_nsenter
		_qtm:put "$_flag_topline_color" \
			"$_flag_content_color$(_qtm_username)$(set_color --reset)"
	end
end
