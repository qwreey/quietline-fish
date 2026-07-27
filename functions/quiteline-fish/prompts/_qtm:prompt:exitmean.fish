function _qtm:prompt:exitmean; argparse \
	'content-color=*' 'prefix=*' \
	'suffix=*' 'hide-ok' \
-- $argv || return
	# Flag defaults
	set --query -l _flag_content_color
	or set -l _flag_content_color "$_qtm_color_symbol_default"
	set --query -l _flag_prefix
	or set -l _flag_prefix "("
	set --query -l _flag_suffix
	or set -l _flag_suffix ") "

	echo "name   =exitmean"
	echo "render =_qtm:prompt:exitmean:render"
	echo "namespace_enter ="(_qtm:ns_capture)

	# Guess the exit code meaning
	function _qtm:prompt:exitmean:meaning
		# Ref: https://tldp.org/LDP/abs/html/exitcodes.html
		# Ref: https://man7.org/linux/man-pages/man7/signal.7.html
		# Note: These meanings are not standardized
		switch $argv[1]
			case 126; echo -n 'Command cannot execute'
			case 127; echo -n 'Command not found'
			case 129; echo -n 'Hangup'
			case 130; echo -n 'Interrupted'
			case 131; echo -n 'Quit'
			case 132; echo -n 'Illegal instruction'
			case 133; echo -n 'Trapped'
			case 134; echo -n 'Aborted'
			case 135; echo -n 'Bus error'
			case 136; echo -n 'Arithmetic error'
			case 137; echo -n 'Killed'
			case 138; echo -n 'User signal 1'
			case 139; echo -n 'Segmentation fault'
			case 140; echo -n 'User signal 2'
			case 141; echo -n 'Pipe error'
			case 142; echo -n 'Alarm'
			case 143; echo -n 'Terminated'
			case "*"; return 1
		end
	end

	# Render result
	function _qtm:prompt:exitmean:render; $_qtm_nsenter
		if test $_qtm_last_status = 0
			set --query _flag_hide_ok
			and return 0
		end

		set -l meaning "$(_qtm:prompt:exitmean:meaning $_qtm_last_status)"
		test -z "$meaning"
		and return 0

		_qtm:put_result \
			"$_flag_content_color$_flag_prefix$meaning$_flag_suffix$(set_color --reset)"
	end
end
