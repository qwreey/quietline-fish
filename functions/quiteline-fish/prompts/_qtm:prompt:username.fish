function _qtm:prompt:username
	echo "name   =username"
	echo "render =_qtm:prompt:username:render"

	# Render result
	function _qtm:prompt:username:render
		if test -n "$_qtm_config_username_override"
			_qtm:put "$_qtm_color_username_topline" \
				"$_qtm_color_username$_qtm_config_username_override$(set_color --reset)"
		else if test -n "$USER"
			_qtm:put "$_qtm_color_username_topline" \
				"$_qtm_color_username$USER$(set_color --reset)"
		else if test -n "$USERNAME"
			_qtm:put "$_qtm_color_username_topline" \
				"$_qtm_color_username$USERNAME$(set_color --reset)"
		else if test -n "$_qtm_var_usernamecache"
			_qtm:put "$_qtm_color_username_topline" \
				"$_qtm_color_username$_qtm_var_usernamecache$(set_color --reset)"
		else if command --query whoami
			set --global _qtm_var_usernamecache (whoami)
			_qtm:put "$_qtm_color_username_topline" \
				"$_qtm_color_username$_qtm_var_usernamecache$(set_color --reset)"
		end
	end
end
