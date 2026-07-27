function _qtm_motd_lastlogin; argparse --max-args 0 \
	'color=*' 'prefix=*' 'dateformat=*' 'locale=*' \
-- $argv
	# Define default
	set -q _flag_color || set -l _flag_color (set_color normal)
	set -q _flag_prefix || set -l _flag_prefix "$(set_color '#9B59B6')Last Login: "
	set -q _flag_dateformat || set -l _flag_dateformat "%a %b %H:%M %Z"
	set -q _flag_locale || set -l _flag_locale "$LC_TIME"
	test -z _flag_locale && set -l _flag_locale "en_US.UTF-8"

	command -q last
	and set -l last_timeiso (string match -rg -- '(\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2})' (last -n 1 --time-format=iso $USER)[1])
	or set -l last_timeiso (date -Iseconds)
	set -l formatted (LC_TIME="$_flag_locale" date -d $last_timeiso "+$_flag_dateformat")

	echo "$_flag_prefix"(set_color --reset)"$_flag_color""$formatted"(set_color --reset)
end
