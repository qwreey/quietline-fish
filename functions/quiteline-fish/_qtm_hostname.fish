function _qtm_hostname
	set -l result
	if test -n "$_qtm_config_hostname_override"
		set result "$_qtm_config_hostname_override"
	else if test -n "$HOST"
		set result "$HOST"
	else if test -n "$_qtm_var_hostnamecache"
		set result "$_qtm_var_hostnamecache"
	else if command --query hostname
		set --global _qtm_var_hostnamecache (hostname)
		set result "$_qtm_var_hostnamecache"
	else if test -e /run/systemd/system && command --query hostnamectl
		set --global _qtm_var_hostnamecache (hostnamectl --transient)
		set result "$_qtm_var_hostnamecache"
	else if test -e /etc/hostname
		set --global _qtm_var_hostnamecache (cat /etc/hostname)
		set result "$_qtm_var_hostnamecache"
	else
		set --global _qtm_var_hostnamecache ("*hostname-unset*")
		set result "$_qtm_var_hostnamecache"
	end
	echo "$result"
end
