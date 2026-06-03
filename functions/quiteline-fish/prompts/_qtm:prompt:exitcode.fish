function _qtm:prompt:exitcode; argparse \
	'content-color=?' \
	'err-prefix=?' \
	'err-suffix=?' \
	'ok-content=?' \
	'hide-ok' \
	'status-joiner=?' \
-- $argv || return
	# Flag defaults
	set --query -l _flag_content_color
	or set -l _flag_content_color "$_qtm_color_symbol_default"
	set --query -l _flag_err_prefix
	or set -l _flag_err_prefix "err! "
	set --query -l _flag_err_suffix
	or set -l _flag_err_suffix " "
	set --query -l _flag_ok_content
	or set -l _flag_ok_content "ok! "
	set --query -l _flag_status_joiner
	or set -l _flag_status_joiner "|"

	echo "name   =exitcode"
	echo "render =_qtm:prompt:exitcode:render"
	echo "namespace_enter ="(_qtm:ns_capture)

	# Render result
	function _qtm:prompt:exitcode:render; $_qtm_nsenter
		# Check every pipe is ok
		set -l all_ok 1
		for pipe in $_qtm_last_pipestatus
			if test $pipe != 0
				set all_ok 0
				break
			end
		end

		# If ok, show ok or return
		if test $all_ok = 1
			set --query _flag_hide_ok
			and return 0

			_qtm:put_result \
				"$_flag_content_color$_flag_ok_content$(set_color --reset)"
		end

		# Show error numbers
		set -l joined "$(string join "$_flag_status_joiner" $_qtm_last_pipestatus)"
		_qtm:put_result \
			"$_flag_content_color$_flag_err_prefix$joined$_flag_err_suffix$(set_color --reset)"
	end
end
