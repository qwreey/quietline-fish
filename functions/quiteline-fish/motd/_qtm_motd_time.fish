function _qtm_motd_time; argparse --max-args 0 \
	'color=*' 'prefix=*' 'dateformat=*' 'locale=*' \
-- $argv
	# Define default
	set -q _flag_color || set -l _flag_color (set_color normal)
	set -q _flag_prefix || set -l _flag_prefix "$(set_color '#21b666')at "
	set -q _flag_dateformat || set -l _flag_dateformat "%a %b %e %H:%M %Z"
	set -q _flag_locale || set -l _flag_locale "$LC_TIME"
	test -z _flag_locale && set -l _flag_locale "en_US.UTF-8"

	set -l formatted (LC_TIME="$_flag_locale" date "+$_flag_dateformat")

	echo "$_flag_prefix"(set_color --reset)"$_flag_color""$formatted"(set_color --reset)
end
