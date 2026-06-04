function _qtm:prompt:duration; argparse \
	'content-color=*' 'decimals=*' \
	'threshold-ms=*' 'prefix=*' \
	'suffix=*' \
-- $argv || return
	# Flag defaults
	set --query -l _flag_content_color
	or set -l _flag_content_color "$_qtm_color_symbol_default"
	set --query -l _flag_decimals
	or set -l _flag_decimals 0
	set --query -l _flag_threshold_ms
	or set -l _flag_threshold_ms 10
	set --query -l _flag_prefix
	or set -l _flag_prefix ""
	set --query -l _flag_suffix
	or set -l _flag_suffix " taken "

	echo "name   =duration"
	echo "render =_qtm:prompt:duration:render"
	echo "namespace_enter ="(_qtm:ns_capture)

	# Render result
	function _qtm:prompt:duration:render; $_qtm_nsenter
		test $CMD_DURATION -lt $_flag_threshold_ms
		and return 0
		set -l t (
			math -s0 "$CMD_DURATION/3600000" # Hours
			math -s0 "$CMD_DURATION/60000"%60 # Minutes
			math -s$_flag_decimals "$CMD_DURATION/1000"%60
		)
		set -l content
		if test $t[1] != 0
			set content "$t[1]h $t[2]m $t[3]s"
		else if test $t[2] != 0
			set content "$t[2]m $t[3]s"
		else
			set content "$t[3]s"
		end

		_qtm:put_result \
			"$_flag_content_color$_flag_prefix$content$_flag_suffix$(set_color --reset)"
	end
end
