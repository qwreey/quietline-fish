function _qtm:prompt:symbol; argparse --min-args 1 \
	'content-color=?' 'topline-color=?' \
-- $argv || return
	# Flag defaults
	set --query -l _flag_topline_color
	or set -l _flag_topline_color "$_qtm_color_topline_default"
	set --query -l _flag_content_color
	or set -l _flag_content_color "$_qtm_color_symbol_default"

	echo "name   =symbol"
	echo "render =_qtm:prompt:symbol:render"
	echo "namespace_enter="(_qtm:ns_capture \
		-v "content=$argv[1]")

	# Render result
	function _qtm:prompt:symbol:render; $_qtm_nsenter
		_qtm:put "$_flag_topline_color" \
			"$_flag_content_color$content$(set_color --reset)"
	end
end
