function _qtm:prompt:ssh \
--argument-names symbol notsymbol
	echo "name   =ssh"
	echo "render =_qtm:prompt:ssh:render"

	_qtm:define_namespace "
		set --global _qtm_var_currsshsymbol \"$symbol\"
		set --global _qtm_var_currsshnotsymbol \"$notsymbol\"
	"

	function _qtm:prompt:ssh:render
		if test -z "$SSH_TTY$SSH_CONNECTION$SSH_CLIENT"
			_qtm:put "$_qtm_var_currsshnotsymbol$(set_color --reset)"
		else
			_qtm:put "$_qtm_var_currsshsymbol$(set_color --reset)"
		end
	end
end
