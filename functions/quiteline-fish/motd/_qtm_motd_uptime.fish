function _qtm_motd_uptime; argparse --max-args 0 \
	'color=*' 'prefix=*' \
-- $argv
	# Define default
	set -q _flag_color || set -l _flag_color (set_color normal)
	set -q _flag_prefix || set -l _flag_prefix "$(set_color '#1D99F3')Uptime: "

	set -l uptime (uptime -p | string replace 'up ' '')

	echo "$_flag_prefix"(set_color --reset)"$_flag_color"$uptime(set_color --reset)
end
