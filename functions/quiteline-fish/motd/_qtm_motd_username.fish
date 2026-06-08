function _qtm_motd_username; argparse --max-args 0 \
	'color=*' \
-- $argv
	# Define default
	set -q _flag_color || set -l _flag_color (set_color "#F80001")

	echo $_flag_color(_qtm_username)(set_color --reset)
end
