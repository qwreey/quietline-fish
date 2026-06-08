function _qtm_username
	set -l result
	if test -n "$_qtm_config_username_override"
		set result "$_qtm_config_username_override"
	else if test -n "$USER"
		set result "$USER"
	else if test -n "$USERNAME"
		set result "$USERNAME"
	else if test -n "$_qtm_var_usernamecache"
		set result "$_qtm_var_usernamecache"
	else if command --query whoami
		set --global _qtm_var_usernamecache (whoami)
		set result "$_qtm_var_usernamecache"
	end
	echo "$result"
end
