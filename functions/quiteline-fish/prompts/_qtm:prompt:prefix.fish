function _qtm:prompt:prefix; argparse --max-args 0 \
	'content=' \
	'prompt_root=' \
	'prompt_nonroot=' \
-- $argv || return
	echo "name   =prefix"
	echo "render =_qtm:prompt:prefix:render"
	echo "namespace_enter ="(_qtm:ns_capture)

	function _qtm:prompt:prefix:render; $_qtm_nsenter
		if fish_is_root_user
			_qtm:put_prompt "$_flag_prompt_root$(set_color --reset)"
		else
			_qtm:put_prompt "$_flag_prompt_nonroot$(set_color --reset)"
		end

		_qtm:put "$_flag_content$(set_color --reset)"
	end
end
