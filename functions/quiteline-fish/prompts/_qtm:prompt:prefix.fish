function _qtm:prompt:prefix
	echo "name   =prefix"
	echo "render =_qtm:prompt:prefix:render"

	function _qtm:prompt:prefix:render
		if fish_is_root_user
			_qtm:put_prompt "$_qtm_config_prefix_prompt_root$(set_color --reset)"
		else
			_qtm:put_prompt "$_qtm_config_prefix_prompt_nonroot$(set_color --reset)"
		end

		_qtm:put "$_qtm_config_prefix_content$(set_color --reset)"
	end
end
