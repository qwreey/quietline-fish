function _qtm:prompt:ssh; argparse --min-args 1 \
	'symbol=*' 'notsymbol=*' \
-- $argv || return
	# Flag defaults
	set --query -l _flag_symbol
	or set -l _flag_symbol "=> "
	set --query -l _flag_notsymbol
	or set -l _flag_notsymbol ""

	echo "name   =ssh"
	echo "render =_qtm:prompt:ssh:render"
	echo "namespace_enter="(_qtm:ns_capture)

	function _qtm:prompt:ssh:render; $_qtm_nsenter
		if test -z "$SSH_TTY$SSH_CONNECTION$SSH_CLIENT"
			_qtm:put "$_flag_notsymbol$(set_color --reset)"
		else
			_qtm:put "$_flag_symbol$(set_color --reset)"
		end
	end
end
