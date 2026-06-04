function _qtm:prompt:hostname; argparse --max-args 0 \
	'content-color=*' 'topline-color=*' \
-- $argv || return
	# Flag defaults
	set --query -l _flag_topline_color
	or set -l _flag_topline_color "$_qtm_color_topline_default"
	set --query -l _flag_content_color
	or set -l _flag_content_color "$_qtm_color_symbol_default"

	echo "name   =hostname"
	echo "render =_qtm:prompt:hostname:render"
	echo "namespace_enter ="(_qtm:ns_capture)

	# Render result
	function _qtm:prompt:hostname:render; $_qtm_nsenter
		set -l result
		if test -n "$_qtm_config_hostname_override"
			set result "$_qtm_config_hostname_override"
		else if test -n "$HOST"
			set result "$HOST"
		else if test -n "$_qtm_var_hostnamecache"
			set result "$_qtm_var_hostnamecache"
		else if command --query hostname
			set --global _qtm_var_hostnamecache (hostname -s)
			set result "$_qtm_var_hostnamecache"
		else if command --query hostnamectl
			set --global _qtm_var_hostnamecache (hostnamectl --transient)
			set result "$_qtm_var_hostnamecache"
		end

		_qtm:put "$_flag_topline_color" \
			"$_flag_content_color$result$(set_color --reset)"
	end
end
