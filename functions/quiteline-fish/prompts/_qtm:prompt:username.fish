function _qtm:prompt:username; argparse --max-args 0 \
	'content-color=?' \
	'topline-color=?' \
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
		set -l result
		if test -n "$_qtm_config_username_override"
			set result "$_qtm_config_username_override"
		else if test -n "$USER"
			set result "$USER"
		else if test -n "$USERNAME"
			set result "$USERNAME"
		else if test -n "$_qtm_var_usernamecache"
			set result "$_qtm_var_usernamecache"
		else if command --query whoami
			set --global _qtm_var_usernamecache (whoami)
			set result "$_qtm_var_usernamecache"
		end

		_qtm:put "$_flag_topline_color" \
			"$_flag_content_color$result$(set_color --reset)"
	end
end
