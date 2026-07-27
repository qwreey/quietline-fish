function _qtm:prompt:venv; argparse --max-args 0 \
	'disable-venv-prompt' \
	'topline-color=*' 'content-color=*' \
	'prefix=*' 'suffix=*' \
-- $argv || return
    # Flag defaults
	set --query -l _flag_topline_color
	or set -l _flag_topline_color "$_qtm_color_topline_default"
	set --query -l _flag_content_color
	or set -l _flag_content_color "$_qtm_color_symbol_default"
	set --query -l _flag_prefix
	or set -l _flag_prefix "venv="
	set --query -l _flag_suffix
	or set -l _flag_suffix " "

	# allow side-effect
	set --query -l _flag_disable_venv_prompt
	and set -g VIRTUAL_ENV_DISABLE_PROMPT

	echo "name   =venv"
	echo "render =_qtm:prompt:venv:render"
	echo "namespace_enter ="(_qtm:ns_capture)

	# Render result
	function _qtm:prompt:venv:render; $_qtm_nsenter
		if command -q node && path is $_qtm_pwd_parent_dirs/package.json
		set -l node_version (node --version | string match -r -- "v(?<v>.*)")
		_qtm:put "$_flag_topline_color" \
		"$_flag_content_color$_flag_prefix$node_version[2]$_flag_suffix"
		end
	end
end
