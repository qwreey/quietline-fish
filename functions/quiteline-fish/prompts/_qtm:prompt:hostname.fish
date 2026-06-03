function _qtm:prompt:hostname
	echo "name   =hostname"
	echo "render =_qtm:prompt:hostname:render"

	# Render result
	function _qtm:prompt:hostname:render
		if test -n "$_qtm_config_hostname_override"
			_qtm:put "$_qtm_color_hostname_topline" \
				"$_qtm_color_hostname$_qtm_config_hostname_override$(set_color --reset)"
		else if test -n "$HOST"
			_qtm:put "$_qtm_color_hostname_topline" \
				"$_qtm_color_hostname$HOST$(set_color --reset)"
		else if test -n "$_qtm_var_hostnamecache"
			_qtm:put "$_qtm_color_hostname_topline" \
				"$_qtm_color_hostname$_qtm_var_hostnamecache$(set_color --reset)"
		else if command --query hostname
			set --global _qtm_var_hostnamecache (hostname -s)
			_qtm:put "$_qtm_color_hostname_topline" \
				"$_qtm_color_hostname$_qtm_var_hostnamecache$(set_color --reset)"
		else if command --query hostnamectl
			set --global _qtm_var_hostnamecache (hostnamectl --transient)
			_qtm:put "$_qtm_color_hostname_topline" \
				"$_qtm_color_hostname$_qtm_var_hostnamecache$(set_color --reset)"
		end
	end
end
