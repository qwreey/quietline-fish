function _qtm:add_prompt
	set -l name
	set -l namespace_enter ""
	set -l render
	set -l on_exit
	set -l on_prompt

	for i in (seq 1 (count $argv))
		set -l kv (string split -m1 "=" $argv[$i])
		set -l k (string trim $kv[1])
		set -l v $kv[2]

		switch $k
			case name; set name $v
			case render; set render $v
			case on_exit; set on_exit $v
			case on_prompt; set on_prompt $v
			case on_pwd; set on_pwd $v
			case namespace_enter; set namespace_enter $v
		end
	end

	set --global "_qtm_isenabled_$name"
	if test -n "$render"
		set --append _qtm_hook_render "$render"
		set --append _qtm_hook_render_nsenter "$namespace_enter"
	end
	if test -n "$on_exit"
		set --append _qtm_hook_onexit "$on_exit"
		set --append _qtm_hook_onexit_nsenter "$namespace_enter"
	end
	if test -n "$on_prompt"
		set --append _qtm_hook_onprompt "$on_prompt"
		set --append _qtm_hook_onprompt_nsenter "$namespace_enter"
	end
	if test -n "$on_pwd"
		set --append _qtm_hook_onpwd "$on_pwd"
		set --append _qtm_hook_onpwd_nsenter "$namespace_enter"
	end
end
