function _qtm:prompt:node; argparse --max-args 0 \
	'topline-color=*' 'content-color=*' \
	'prefix=*' 'suffix=*' \
-- $argv || return
	# Flag defaults
	set --query -l _flag_topline_color
	or set -l _flag_topline_color "$_qtm_color_topline_default"
	set --query -l _flag_content_color
	or set -l _flag_content_color "$_qtm_color_symbol_default"
	set --query -l _flag_prefix
	or set -l _flag_prefix "njs="
	set --query -l _flag_suffix
	or set -l _flag_suffix " "

	echo "name   =node"
	echo "render =_qtm:prompt:node:render"
	echo "namespace_enter ="(_qtm:ns_capture)

	# Render result
	function _qtm:prompt:node:render; $_qtm_nsenter
		if path is $_qtm_pwd_parent_dirs/package.json
			set -l node_version (node --version | string match -r "v(?<v>.*)")
			_qtm:put "$_flag_topline_color" \
				"$_flag_content_color$_flag_prefix$node_version[2]$_flag_suffix"
		end
	end
end
